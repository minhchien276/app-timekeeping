import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/logic/controllers/application/application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/work/work_room_approve_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_snackbar.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_toast.dart';
import 'package:e_tmsc_app/presentation/widgets/dialog/submit_dialog.dart';
import 'package:e_tmsc_app/presentation/widgets/loading/loading.dart';
import 'package:e_tmsc_app/services/service/employee_service.dart';
import 'package:e_tmsc_app/services/service/work_service.dart';
import 'package:e_tmsc_app/shared/extensions/context_extension.dart';
import 'package:e_tmsc_app/shared/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkController extends GetxController {
  final _employeesRx = Rx<List<SelectedReceiver>>([]);
  final _employeesQueryRx = Rx<List<SelectedReceiver>>([]);
  final _employeesAdded = Rx<List<EmployeeModel>>([]);
  final _isLoadingRx = Rx<bool>(false);
  late final EmployeeService _employeeService;
  late final WorkService _workService;
  late final TextEditingController groupNameController;
  late final TextEditingController searchController;
  late final FocusNode groupNameFocusNode;
  late final FocusNode searchFocusNode;
  late final ScrollController scrollController;

  List<SelectedReceiver> get employees => _employeesRx.value;
  List<SelectedReceiver> get employeesQuery => _employeesQueryRx.value;
  List<EmployeeModel> get employeesAdded => _employeesAdded.value;
  bool get canRemoveGroupName =>
      groupNameFocusNode.hasFocus && groupNameController.text.isNotEmpty;
  bool get canRemoveSearchName =>
      searchFocusNode.hasFocus && searchController.text.isNotEmpty;
  bool get isLoading => _isLoadingRx.value;

  @override
  void onInit() {
    super.onInit();
    _workService = WorkService();
    _employeeService = EmployeeService();
    groupNameController = TextEditingController();
    searchController = TextEditingController();
    groupNameFocusNode = FocusNode();
    searchFocusNode = FocusNode();

    groupNameController.addListener(listener);
    searchController.addListener(searchEmployees);
    groupNameFocusNode.addListener(listener);
    searchFocusNode.addListener(listener);
    scrollController = ScrollController();
  }

  @override
  void onClose() {
    groupNameController.dispose();
    searchController.dispose();
    groupNameFocusNode.dispose();
    searchFocusNode.dispose();
    groupNameController.removeListener(listener);
    searchController.removeListener(searchEmployees);
    groupNameFocusNode.removeListener(listener);
    searchFocusNode.removeListener(listener);
    super.onClose();
  }

  void listener() => update();

  void _animatedPosition() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (employeesAdded.isNotEmpty) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void setLoading(bool value) {
    _isLoadingRx.value = value;
    update();
  }

  void _resetData() {
    for (var e in _employeesQueryRx.value) {
      e.hasSelect = false;
    }
    _employeesAdded.value.clear();
    groupNameController.clear();
    searchController.clear();
    update();
  }

  void handleBackPressed(BuildContext context) {
    if (employeesAdded.isNotEmpty) {
      showSubmitDialog(
        context,
        title: 'Bỏ nhóm',
        message: 'Các thay đổi sẽ không được lưu',
        onSubmit: () {
          _resetData();
          context.pop();
        },
      );
    } else {
      _resetData();
      context.pop();
    }
  }

  void handleCreateRoomPressed(BuildContext context) {
    if (employeesAdded.isNotEmpty &&
        groupNameController.text.trim().isNotEmpty) {
      showSubmitDialog(
        context,
        title: 'Tạo nhóm',
        message: 'Các thay đổi sẽ được lưu ngay lập tức',
        onSubmit: () => createRoom(context),
      );
    } else {
      if (employeesAdded.isEmpty) {
        context.showToast('Chưa thêm người tham gia');
      } else {
        context.showToast('Chưa nhập tên nhóm');
      }
    }
  }

  Future createRoom(BuildContext context) async {
    try {
      Loading().show(context: context);
      final res = await _workService.createRoom({
        'name': groupNameController.text,
        'participantId': employeesAdded.map((e) => e.id).toList()
      });
      Loading().hide();
      if (res.isOk) {
        if (!context.mounted) return;
        context.showSuccessMessage('Tạo nhóm thành công');
        _resetData();
        final WorkRoomApproveController roomApproveController = Get.find();
        roomApproveController.refreshing();
        context.pop();
      }
    } catch (e) {
      Loading().hide();
      if (!context.mounted) return;
      context.showErrorMessage('Tạo nhóm không thành công ${e.toString()}');
    }
  }

  Future fetchEmployees() async {
    try {
      if (employees.isEmpty) {
        setLoading(true);
        final res = await _employeeService.getAllEmployee();
        setLoading(false);
        if (res.isOk) {
          for (var e in res.data) {
            _employeesRx.value
                .add(SelectedReceiver(employee: e, hasSelect: false));
            _employeesQueryRx.value = employees;
          }
          update();
        }
      }
    } catch (e) {
      setLoading(false);
    }
  }

  void handleAddEmployee(EmployeeModel item) {
    for (var e in employees) {
      if (e.employee == item) {
        if (e.hasSelect) {
          employeesAdded.remove(item);
        } else {
          employeesAdded.add(item);
        }
        e.hasSelect = !e.hasSelect;
      }
    }
    update();
    _animatedPosition(); 
  }

  void searchEmployees() {
    if (searchController.text.trim().isNotEmpty) {
      _employeesQueryRx.value = employees;
      String searchText =
          searchController.text.trim().toLowerCase().toEnglish();
      _employeesQueryRx.value = _employeesRx.value.where((e) {
        return e.employee.fullname!
            .toLowerCase()
            .toEnglish()
            .contains(searchText);
      }).toList();
    } else {
      _employeesQueryRx.value = _employeesRx.value;
    }
    update();
  }
}
