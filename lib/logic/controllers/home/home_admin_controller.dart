// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:e_tmsc_app/data/models/blog_model.dart';
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/data/models/overtime_model.dart';
import 'package:e_tmsc_app/data/models/timekeeping_model.dart';
import 'package:e_tmsc_app/data/models/typeofwork_model.dart';
import 'package:e_tmsc_app/logic/controllers/application/approve_application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/application/pending_application_controller.dart';
import 'package:e_tmsc_app/services/service/blog_service.dart';
import 'package:e_tmsc_app/services/service/employee_service.dart';
import 'package:e_tmsc_app/services/service/notification_service.dart';
import 'package:e_tmsc_app/shared/enums/department_enum.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAdminController extends GetxController {
  final player = AudioPlayer();
  final ApproveApplicationController approveController = Get.find();
  final PendingApplicationController pedingController = Get.find();

  late final Rx<Widget> currentPage;
  late EmployeeService _employeeService;
  late BlogService _blogService;
  late NotificationService _notiService;

  final _prefs = SharedPrefs();
  final _employee = Rx<EmployeeModel?>(null);
  final _blogsRx = Rx<List<BlogModel>>([]);

  final _daysRx = Rx<List<TimeKeeping>>([]);
  final _loadingRx = Rx<bool>(false);
  final _qrCodeRx = Rx<String?>(null);
  final _overtimeRx = Rx<List<OvertimeModel>>([]);
  final _typeOfWork = Rx<TypeOfWork?>(null);
  final _timeKeeping = Rx<TimeKeeping?>(null);

  final _employeeOnline = Rx<Map<DepartmentEnum, List<EmployeeModel>>>({});
  final _employeeDayoff = Rx<Map<DepartmentEnum, List<EmployeeModel>>>({});
  final _employeeAll = Rx<Map<DepartmentEnum, List<EmployeeModel>>>({});
  final _employeeBirthdayRx = Rx<List<EmployeeModel>>([]);
  final _employeeOnboardRx = Rx<List<EmployeeModel>>([]);

  final _listEmployeeOff = Rx<List<EmployeeModel>>([]);

  @override
  void onInit() {
    super.onInit();
    _employeeService = EmployeeService();
    _blogService = BlogService();
    _notiService = NotificationService();

    fetchListEmployeeOff();
  }

  bool get isLoading => _loadingRx.value;
  EmployeeModel? get employee => _employee.value;
  TypeOfWork? get typeOfWork => _typeOfWork.value;
  TimeKeeping? get timeKeeping => _timeKeeping.value;
  List<BlogModel> get blog => _blogsRx.value;
  List<TimeKeeping> get days => _daysRx.value;
  String? get qrCode => _qrCodeRx.value;
  List<OvertimeModel> get overtime => _overtimeRx.value;
  num get totalOvertime => _overtimeRx.value
      .fold(0, (previousValue, item) => previousValue + item.hours!);

  Map<DepartmentEnum, List<EmployeeModel>> get employeeOnline =>
      _employeeOnline.value;
  Map<DepartmentEnum, List<EmployeeModel>> get employeeDayoff =>
      _employeeDayoff.value;
  Map<DepartmentEnum, List<EmployeeModel>> get employeeAll =>
      _employeeAll.value;

  int get totalEmployeeOnline => _employeeOnline.value.values
      .toList()
      .fold(0, (previousValue, item) => previousValue + item.length);
  int get totalEmployeeDayoff => _employeeDayoff.value.values
      .toList()
      .fold(0, (previousValue, item) => previousValue + item.length);
  int get pendingCount => pedingController.pendingCount;
  List<EmployeeModel> get employeeBirthday => _employeeBirthdayRx.value;
  List<EmployeeModel> get employeeOnboard => _employeeOnboardRx.value;

  List<EmployeeModel> get listEmployeeOff => _listEmployeeOff.value;

  setLoading(bool value) => _loadingRx.value = value;

  void playSound() async {
    await player.play(AssetSource('sounds/ting.mp3'));
  }

  onChangePage(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        approveController.refreshing();
        pedingController.refreshing();
        break;
      case 4:
        break;
      default:
    }
  }

  Future refreshHome(BuildContext context) async {
    await fetchEmployee();
    fetchBlog();
    fetchEmployeeOnline();
    fetchEmployeeDayoff();
    fetchEmployeeBirthday();
    fetchEmployeeOnboard();
    updateDeviceToken();
  }

  refreshCalenlar() async {
    setLoading(true);
    await fetchEmployee();
    setLoading(false);
  }

  setEmployeeData(dynamic res) {
    _employee.value = EmployeeModel.fromJson(jsonEncode(res['employee']));
    _typeOfWork.value = TypeOfWork.fromJson(jsonEncode(res['typeOfWork']));
    _timeKeeping.value = TimeKeeping.fromJson(jsonEncode(res['timeKeeping']));
    update();
  }

  updateDeviceToken() async {
    try {
      if (_prefs.fcmStatus != true && _prefs.fcm != null) {
        final res = await _notiService.updateDeviceToken(_prefs.fcm!);
        if (res.isOk) {
          _prefs.setUpdateFCM(true);
        }
      }
    } catch (e) {
      _prefs.setUpdateFCM(false);
      debugPrint('updateDeviceToken: $e');
    }
  }

  fetchEmployee() async {
    try {
      final res = await _employeeService.getEmployeeDetails(id: _prefs.id!);
      if (res.isOk) {
        setEmployeeData(res.data);
      }
    } catch (e) {
      debugPrint('fetchEmployee: $e');
    }
  }

  fetchBlog() async {
    try {
      final res = await _blogService.getAllBlog();
      if (res.isOk) {
        _blogsRx.value = res.data;
        update();
      }
    } catch (e) {
      debugPrint('fetchBlog: $e');
    }
  }

  fetchAllEmployee() async {
    try {
      setLoading(true);
      if (employeeAll.isEmpty) {
        setLoading(true);
        final res = await _employeeService.getAllEmployee();
        if (res.isOk) {
          DepartmentEnum.departments.forEach((e) => _employeeAll.value[e] = []);
          res.data.forEach((e) => _employeeAll
              .value[DepartmentEnum.toEnum(e.departmentId!)]
              ?.add(e));
          update();
        }
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      debugPrint('fetchAllEmployee: $e');
    }
  }

  fetchEmployeeOnline() async {
    try {
      final res = await _employeeService.getEmployeeOnline();
      if (res.isOk) {
        DepartmentEnum.departments
            .forEach((e) => _employeeOnline.value[e] = []);
        res.data.forEach((e) => _employeeOnline
            .value[DepartmentEnum.toEnum(e.departmentId!)]
            ?.add(e));
        update();
      }
    } catch (e) {
      debugPrint('fetchEmployeeOnline: $e');
    }
  }

  fetchEmployeeDayoff() async {
    try {
      final res = await _employeeService.getEmployeeDayoff();
      if (res.isOk) {
        DepartmentEnum.departments
            .forEach((e) => _employeeDayoff.value[e] = []);
        res.data.forEach((e) => _employeeDayoff
            .value[DepartmentEnum.toEnum(e.departmentId!)]
            ?.add(e));
        update();
      }
    } catch (e) {
      debugPrint('fetchEmployeeDayoff: $e');
    }
  }

  fetchListEmployeeOff() async {
    try {
      final res = await _employeeService.getEmployeeDayoff();
      if (res.isOk) {
        _listEmployeeOff(res.data);
      }
    } catch (e) {
      debugPrint('fetchEmployeeDayoff: $e');
    }
  }

  fetchEmployeeOnboard() async {
    try {
      final res = await _employeeService.getEmployeeOnboardToday();
      if (res.isOk) {
        _employeeOnboardRx.value = res.data;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  fetchEmployeeBirthday() async {
    try {
      final res = await _employeeService.getEmployeeBirthdayToday();
      if (res.isOk) {
        _employeeBirthdayRx.value = res.data;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
