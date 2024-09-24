import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:e_tmsc_app/data/models/blog_model.dart';
import 'package:e_tmsc_app/data/models/checkin_model.dart';
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/data/models/overtime_model.dart';
import 'package:e_tmsc_app/data/models/salary_model.dart';
import 'package:e_tmsc_app/data/models/timekeeping_model.dart';
import 'package:e_tmsc_app/data/models/typeofwork_model.dart';
import 'package:e_tmsc_app/logic/controllers/application/my_application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/application/people_application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/location/location_core.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_snackbar.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/services/service/blog_service.dart';
import 'package:e_tmsc_app/services/service/calendar_service.dart';
import 'package:e_tmsc_app/services/service/employee_service.dart';
import 'package:e_tmsc_app/services/service/notification_service.dart';
import 'package:e_tmsc_app/shared/enums/day_enum.dart';
import 'package:e_tmsc_app/utils/internet_connection.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:vibration/vibration.dart';

class HomeClientController extends GetxController {
  final player = AudioPlayer();
  final PeopleApplicationController peopleController = Get.find();
  final MyApplicationController myController = Get.find();

  late final Rx<Widget> currentPage;
  late EmployeeService _employeeService;
  late BlogService _blogService;
  late CalendarService _calendarService;
  late LocationCore _locationCore;
  late NotificationService _notiService;

  final _prefs = SharedPrefs();
  final _employee = Rx<EmployeeModel?>(null);
  final _typeOfWork = Rx<TypeOfWork?>(null);
  final _timeKeeping = Rx<TimeKeeping?>(null);
  final _blogsRx = Rx<List<BlogModel>>([]);
  final Rx<Calendar> _calendarRx = Rx<Calendar>(
      Calendar(daysOfWork: [], daysOfLate: [], daysOff: [], daysOfMissing: []));
  final Rx<Calendar> _previousCalendarRx = Rx<Calendar>(
      Calendar(daysOfWork: [], daysOfLate: [], daysOff: [], daysOfMissing: []));
  final _daysRx = Rx<List<TimeKeeping>>([]);
  final _loadingRx = Rx<bool>(false);
  final _qrCodeRx = Rx<String?>(null);
  final _overtimeRx = Rx<List<OvertimeModel>>([]);
  final _salaryRx = Rx<List<SalaryModel>>([]);
  final _employeeBirthdayRx = Rx<List<EmployeeModel>>([]);
  final _employeeOnboardRx = Rx<List<EmployeeModel>>([]);
  final _totalLeaveDay = Rx<int>(0);

  @override
  void onInit() {
    super.onInit();
    _employeeService = EmployeeService();
    _blogService = BlogService();
    _calendarService = CalendarService();
    _locationCore = LocationCore();
    _notiService = NotificationService();
    fetchSalary();
  }

  bool get isLoading => _loadingRx.value;
  EmployeeModel? get employee => _employee.value;
  TypeOfWork? get typeOfWork => _typeOfWork.value;
  TimeKeeping? get timeKeeping => _timeKeeping.value;
  List<BlogModel> get blog => _blogsRx.value;
  Calendar get calendar => _calendarRx.value;
  Calendar get previousCalendar => _previousCalendarRx.value;
  List<TimeKeeping> get days => _daysRx.value;
  String? get qrCode => _qrCodeRx.value;
  List<OvertimeModel> get overtime => _overtimeRx.value;
  num get totalOvertime => _overtimeRx.value
      .fold(0, (previousValue, item) => previousValue + item.hours!);
  List<SalaryModel> get salary => _salaryRx.value;
  List<EmployeeModel> get employeeBirthday => _employeeBirthdayRx.value;
  List<EmployeeModel> get employeeOnboard => _employeeOnboardRx.value;
  int get totalLeaveDay => _totalLeaveDay.value;

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
        peopleController.refreshing();
        myController.refreshing();
        break;
      case 4:
        break;
      default:
    }
  }

  Future refreshHome(BuildContext context) async {
    await fetchEmployee(context);
    await fetchCalendar();
    fetchOvertime();
    fetchBlog();
    fetchEmployeeBirthday();
    fetchEmployeeOnboard();
    updateDeviceToken();
  }

  refreshCalenlar(BuildContext context) async {
    setLoading(true);
    await fetchEmployee(context);
    await fetchCalendar();
    setLoading(false);
  }

  setEmployeeData(dynamic res) {
    _employee.value = EmployeeModel.fromJson(jsonEncode(res['employee']));
    _typeOfWork.value = TypeOfWork.fromJson(jsonEncode(res['typeOfWork']));
    _timeKeeping.value = TimeKeeping.fromJson(jsonEncode(res['timeKeeping']));
    SharedPrefs().insertRole(_employee.value?.roleId ?? 2);
    update();
    fetchCalendar();
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

  fetchEmployee(BuildContext context) async {
    try {
      final res = await _employeeService.getEmployeeDetails(id: _prefs.id!);
      if (res.isOk) {
        setEmployeeData(res.data);
      }
    } catch (e) {
      if (!context.mounted) return;
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

  fetchCalendar() async {
    try {
      final res = await _calendarService.getCalendar(id: _prefs.id!);
      if (res != null) {
        _daysRx.value.clear();
        final current = res['current'];
        final previous = res['previous'];
        _calendarRx.value.daysOfWork = [];
        _calendarRx.value.daysOfLate = [];
        _calendarRx.value.daysOff = [];
        _calendarRx.value.daysOfMissing = [];
        _calendarRx.value.daysOfPending = [];
        _calendarRx.value.daysHoliday = [];
        _previousCalendarRx.value.daysOfWork = [];
        _previousCalendarRx.value.daysOfLate = [];
        _previousCalendarRx.value.daysOff = [];
        _previousCalendarRx.value.daysOfMissing = [];
        _previousCalendarRx.value.daysOfPending = [];
        _previousCalendarRx.value.daysHoliday = [];

        List<TimeKeeping> currentData =
            List<TimeKeeping>.from(current.map((e) => TimeKeeping.fromMap(e)));
        _daysRx.value.addAll(currentData);
        for (var e in currentData) {
          switch (e.status) {
            case DayEnum.success:
              _calendarRx.value.daysOfWork.add(e);
              break;
            case DayEnum.lated:
              _calendarRx.value.daysOfLate.add(e);
              break;
            case DayEnum.dayoff:
              _calendarRx.value.daysOff.add(e);
              break;
            case DayEnum.missing:
              _calendarRx.value.daysOfMissing.add(e);
              break;
            case DayEnum.holiday:
              _calendarRx.value.daysHoliday.add(e);
              break;
            case DayEnum.pending:
              _calendarRx.value.daysOfPending.add(e);
              break;
            default:
          }
        }

        List<TimeKeeping> previousData =
            List<TimeKeeping>.from(previous.map((e) => TimeKeeping.fromMap(e)));
        _daysRx.value.addAll(previousData);
        for (var e in previousData) {
          switch (e.status) {
            case DayEnum.success:
              _previousCalendarRx.value.daysOfWork.add(e);
              break;
            case DayEnum.lated:
              _previousCalendarRx.value.daysOfLate.add(e);
              break;
            case DayEnum.dayoff:
              _previousCalendarRx.value.daysOff.add(e);
              break;
            case DayEnum.missing:
              _previousCalendarRx.value.daysOfMissing.add(e);
              break;
            case DayEnum.holiday:
              _previousCalendarRx.value.daysHoliday.add(e);
              break;
            case DayEnum.pending:
              _previousCalendarRx.value.daysOfPending.add(e);
              break;
            default:
          }
        }

        update();
      }
    } catch (e) {
      debugPrint('fetchCalendar: $e');
    }
  }

  num totalAllWorkday() {
    num total1 = _calendarRx.value.daysOfWork
        .fold(0, (previousValue, item) => previousValue + (item.daywork ?? 0));
    num total2 = _calendarRx.value.daysOfLate
        .fold(0, (previousValue, item) => previousValue + (item.daywork ?? 0));
    num total3 = _calendarRx.value.daysOfMissing
        .fold(0, (previousValue, item) => previousValue + (item.daywork ?? 0));
    num total4 = _calendarRx.value.daysOff
        .fold(0, (previousValue, item) => previousValue + (item.daywork ?? 0));
    num total5 = _calendarRx.value.daysHoliday
        .fold(0, (previousValue, item) => previousValue + (item.daywork ?? 0));
    return total1 + total2 + total3 + total4 + total5;
  }

  num totalAllDayoff() {
    num total1 = _calendarRx.value.daysOfWork
        .fold(0, (previousValue, item) => previousValue + (item.dayoff ?? 0));
    num total2 = _calendarRx.value.daysOfLate
        .fold(0, (previousValue, item) => previousValue + (item.dayoff ?? 0));
    num total3 = _calendarRx.value.daysOfMissing
        .fold(0, (previousValue, item) => previousValue + (item.dayoff ?? 0));
    num total4 = _calendarRx.value.daysOff
        .fold(0, (previousValue, item) => previousValue + (item.dayoff ?? 0));

    return total1 + total2 + total3 + total4;
  }

  fetchOvertime() async {
    try {
      final res = await _calendarService.getOvertime();
      if (res.isOk) {
        _overtimeRx.value = res.data;
        update();
      }
    } catch (e) {
      debugPrint('fetchOvertime: $e');
    }
  }

  //checkin
  handleCheckIn(BuildContext context, String value) async {
    try {
      if (qrCode == null) {
        _qrCodeRx.value = value;
        setLoading(true);
        CheckInModel checkInModel = await _locationCore.getCheckIn(context);
        final res = await _employeeService.checkIn(
          params: {
            'checkQr': value,
            'employeeId': _prefs.id,
            'checkin': DateTime.now().millisecondsSinceEpoch,
            'location': checkInModel.location,
            'latitude': checkInModel.latitude,
            'longtitude': checkInModel.longtitude,
            'createdAt': DateTime.now().millisecondsSinceEpoch,
          },
        );
        setLoading(false);
        if (res.isOk) {
          setEmployeeData(res.data);
          if (!context.mounted) return;
          _qrCodeRx.value = null;
          context.showSuccessMessage('Check in thành công');
          playSound();
          context.goNamed(AppRoute.timekeeping.name);
          Vibration.vibrate(duration: 100);
        }
      }
    } catch (e) {
      setLoading(false);
      if (!context.mounted) return;
      if (e is PlatformException) {
        context.showErrorMessage(disconnnectMessage);
      } else {
        context.showErrorMessage(e.toString());
      }
      Vibration.vibrate(duration: 500);
      Future.delayed(const Duration(seconds: 3), () {
        _qrCodeRx.value = null;
      });
    }
  }

  //checkout
  handleCheckOut(BuildContext context, String value) async {
    try {
      if (qrCode == null) {
        _qrCodeRx.value = value;
        setLoading(true);
        CheckInModel checkOutModel = await _locationCore.getCheckIn(context);
        final res = await _employeeService.checkOut(
          params: {
            'checkQr': value,
            'employeeId': _prefs.id,
            'checkout': DateTime.now().millisecondsSinceEpoch,
            'location': checkOutModel.location,
            'latitude': checkOutModel.latitude,
            'longtitude': checkOutModel.longtitude,
            'createdAt': DateTime.now().millisecondsSinceEpoch,
          },
        );
        setLoading(false);
        if (res.isOk) {
          setEmployeeData(res.data);
          if (!context.mounted) return;
          _qrCodeRx.value = null;
          context.showSuccessMessage('Check out thành công');
          playSound();
          context.goNamed(AppRoute.timekeeping.name);
          Vibration.vibrate(duration: 100);
        }
      }
    } catch (e) {
      setLoading(false);
      if (!context.mounted) return;
      if (e is PlatformException) {
        context.showErrorMessage(disconnnectMessage);
      } else {
        context.showErrorMessage(e.toString());
      }
      Vibration.vibrate(duration: 500);
      context.showErrorMessage(e.toString());
      Future.delayed(const Duration(seconds: 3), () {
        _qrCodeRx.value = null;
      });
    }
  }

  fetchSalary() async {
    try {
      setLoading(true);
      final res = await _employeeService.getSalary();
      setLoading(false);
      if (res.isOk) {
        _salaryRx.value = res.data;
        update();
      }
    } catch (e) {
      setLoading(false);
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
}
