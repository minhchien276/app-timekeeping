import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/data/models/room_model.dart';
import 'package:e_tmsc_app/data/models/task_model.dart';
import 'package:e_tmsc_app/logic/controllers/application/application_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_toast.dart';
import 'package:e_tmsc_app/presentation/widgets/dialog/submit_dialog.dart';
import 'package:e_tmsc_app/presentation/widgets/loading/loading.dart';
import 'package:e_tmsc_app/services/service/work_service.dart';
import 'package:e_tmsc_app/shared/enums/task_enum.dart';
import 'package:e_tmsc_app/shared/extensions/context_extension.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkDetailController extends GetxController {
  final _isLoadingRx = Rx<bool>(false);
  final _employeesRx = Rx<List<SelectedReceiver>>([]);
  final _employeesQueryRx = Rx<List<SelectedReceiver>>([]);
  final _employeesAdded = Rx<List<EmployeeModel>>([]);
  final _todoTasks = Rx<List<TaskModel>>([]);
  final _workingTasks = Rx<List<TaskModel>>([]);
  final _doneTasks = Rx<List<TaskModel>>([]);
  final _cancelTasks = Rx<List<TaskModel>>([]);

  late final WorkService _workService;
  late final TextEditingController taskTitleController;
  late final TextEditingController taskContentController;
  late final TextEditingController searchController;
  late final FocusNode taskTitleFocusNode;
  late final FocusNode taskContentFocusNode;
  late final FocusNode searchFocusNode;
  late final ScrollController scrollController;

  List<SelectedReceiver> get employees => _employeesRx.value;
  List<SelectedReceiver> get employeesQuery => _employeesQueryRx.value;
  List<EmployeeModel> get employeesAdded => _employeesAdded.value;
  bool get canRemoveGroupName =>
      taskTitleFocusNode.hasFocus && taskTitleController.text.isNotEmpty;
  bool get canRemoveSearchName =>
      searchFocusNode.hasFocus && searchController.text.isNotEmpty;
  bool get isLoading => _isLoadingRx.value;
  List<TaskModel> get todoTasks => _todoTasks.value;
  List<TaskModel> get workingTasks => _workingTasks.value;
  List<TaskModel> get doneTasks => _doneTasks.value;
  List<TaskModel> get cancelTasks => _cancelTasks.value;

  @override
  void onInit() {
    super.onInit();
    _workService = WorkService();
    taskTitleController = TextEditingController();
    taskContentController = TextEditingController();
    searchController = TextEditingController();
    taskTitleFocusNode = FocusNode();
    taskContentFocusNode = FocusNode();
    searchFocusNode = FocusNode();

    taskTitleController.addListener(listener);
    taskTitleFocusNode.addListener(listener);
    searchFocusNode.addListener(listener);
    scrollController = ScrollController();
  }

  @override
  void onClose() {
    taskTitleController.dispose();
    taskContentController.dispose();
    searchController.dispose();
    taskTitleFocusNode.dispose();
    searchFocusNode.dispose();
    taskContentFocusNode.dispose();
    taskTitleController.removeListener(listener);
    taskTitleFocusNode.removeListener(listener);
    searchFocusNode.removeListener(listener);
    super.onClose();
  }

  void disposeCreateTask() {}

  void listener() => update();

  void setLoading(bool value) {
    _isLoadingRx.value = value;
    update();
  }

  void handleCreateTaskPressed(
    BuildContext context, {
    required RoomModel room,
    required List<EmployeeModel> employees,
    DateTime? expired,
  }) {
    if (taskTitleController.text.trim().isNotEmpty) {
      showSubmitDialog(
        context,
        title: 'Tạo việc',
        message: 'Các thay đổi sẽ được lưu ngay lập tức',
        onSubmit: () => createTask(context, room, employees, expired),
      );
    } else {
      context.showToast('Chưa nhập tiêu đề');
    }
  }

  Future createTask(
    BuildContext context,
    RoomModel room,
    List<EmployeeModel> employees,
    DateTime? expired,
  ) async {
    Loading().show(context: context);
    final res = await _workService.createTask({
      'employeeId': SharedPrefs().id,
      'title': taskTitleController.text.trim(),
      'content': taskContentController.text.trim(),
      'roomId': room.roomId,
      'participantId': employees.map((e) => e.participantId).toList(),
      'expired': expired?.millisecondsSinceEpoch,
    });
    Loading().hide();
    if (res.isOk) {
      fetchListTask(TaskStatus.todo);
      if (!context.mounted) return;
      context.pop();
    }
  }

  Future fetchListTask(TaskStatus tab) async {
    final res = await _workService.getListTask(tab);
    if (res.isOk) {
      switch (tab) {
        case TaskStatus.todo:
          _todoTasks.value = res.data;
          break;
        case TaskStatus.working:
          _workingTasks.value = res.data;
          break;
        case TaskStatus.done:
          _doneTasks.value = res.data;
          break;
        case TaskStatus.cancel:
          _cancelTasks.value = res.data;
          break;
        default:
      }
      update();
    }
  }
}
