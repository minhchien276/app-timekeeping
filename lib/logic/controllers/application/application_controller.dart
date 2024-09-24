// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_function_literals_in_foreach_calls
import 'package:e_tmsc_app/data/models/application_model.dart';
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/logic/controllers/application/approve_application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/application/my_application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/application/pending_application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/application/people_application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/home/home_admin_controller.dart';
import 'package:e_tmsc_app/logic/controllers/home/home_client_controller.dart';
import 'package:e_tmsc_app/presentation/screens/application/widgets/application_modal.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_snackbar.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_toast.dart';
import 'package:e_tmsc_app/presentation/widgets/dialog/submit_dialog.dart';
import 'package:e_tmsc_app/presentation/widgets/loading/loading.dart';
import 'package:e_tmsc_app/services/service/application_service.dart';
import 'package:e_tmsc_app/shared/enums/application_enum.dart';
import 'package:e_tmsc_app/shared/enums/role_enum.dart';
import 'package:e_tmsc_app/shared/enums/type_day_enum.dart';
import 'package:e_tmsc_app/shared/extensions/context_extension.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/shared/typedef.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/selected_reason.dart';

class ApplicationController extends GetxController {
  final HomeClientController homeClientController = Get.find();
  final HomeAdminController homeAdminController = Get.find();

  late final ApplicationService _appSevice;
  final _prefs = SharedPrefs();

  final _loadingRx = Rx<bool>(false);

  final _selectedDayOff = Rx<List<SelectedDayOff>>([]);
  final _selectedOvertime = Rx<List<SelectedOvertime>>([]);
  final _selectedLate = Rx<List<SelectedLateSoon>>([]);
  final _selectedSoon = Rx<List<SelectedLateSoon>>([]);
  final _selectedReason = Rx<List<SelectedReason>>([]);
  final _selectedReceiver = Rx<List<SelectedReceiver>>([]);
  final _typeDayIndex = Rx<int?>(null);
  final _receiverText = Rx<String>('');
  final _reasonIndex = Rx<int?>(null);

  final _timeBegin = Rx<TimeOfDay?>(null);
  final _timeEnd = Rx<TimeOfDay?>(null);

  final _timeLate = Rx<TimeOfDay?>(null);
  final _timeSoon = Rx<TimeOfDay?>(null);

  final _focusDay = Rx<DateTime>(DateTime.now());
  late final TextEditingController reason;

  late final FocusNode reasonFocusNode;

  final _typeSessionDayOff = Rx<List<TypeDay>>([
    TypeDay(
      title: 'Nghỉ phép 1 ngày',
      subTitle: 'Nghỉ phép một ngày',
      isChecked: false,
      typeDayEnum: TypeDayEnum.none,
    ),
    TypeDay(
      title: 'Nghỉ buổi sáng',
      subTitle: 'Nghỉ phép buổi sáng',
      isChecked: false,
      typeDayEnum: TypeDayEnum.none,
    ),
    TypeDay(
      title: 'Nghỉ buổi chiều',
      subTitle: 'Nghỉ phép buổi chiều',
      isChecked: false,
      typeDayEnum: TypeDayEnum.none,
    ),
  ]);

  final _typeDayOff = Rx<List<TypeDay>>([
    TypeDay(
      title: 'Đơn nghỉ phép có lương',
      subTitle: 'Vui lòng chọn đúng ngày và giờ',
      isChecked: false,
      typeDayEnum: TypeDayEnum.dayOff,
    ),
    TypeDay(
      title: 'Đơn nghỉ phép không lương',
      subTitle: 'Vui lòng chọn đúng ngày và giờ',
      isChecked: false,
      typeDayEnum: TypeDayEnum.dayOffNotSalary,
    ),
    TypeDay(
      title: 'Đơn xin tăng ca',
      subTitle: 'Vui lòng chọn đúng ngày và giờ',
      isChecked: false,
      typeDayEnum: TypeDayEnum.dayOvertime,
    ),
    TypeDay(
      title: 'Đơn xin đi làm muộn',
      subTitle: 'Vui lòng chọn đúng ngày và giờ',
      isChecked: false,
      typeDayEnum: TypeDayEnum.dayGoLate,
    ),
    TypeDay(
      title: 'Đơn xin về sớm',
      subTitle: 'Vui lòng chọn đúng ngày và giờ',
      isChecked: false,
      typeDayEnum: TypeDayEnum.dayBackSoon,
    ),
  ]);

  bool get isLoading => _loadingRx.value;
  List<SelectedReason> get selectedReason => _selectedReason.value;
  List<SelectedDayOff> get selectDayOff => _selectedDayOff.value;
  List<SelectedOvertime> get selectOvertime => _selectedOvertime.value;
  List<SelectedLateSoon> get selectSoon => _selectedSoon.value;
  List<SelectedLateSoon> get selectLate => _selectedLate.value;
  List<SelectedReceiver> get selectReceiver => _selectedReceiver.value;
  List<TypeDay> get typeSessionDayOff => _typeSessionDayOff.value;
  List<TypeDay> get typeDayOff => _typeDayOff.value;
  int? get reasonIndex => _reasonIndex.value;
  String get reasonText =>
      reasonIndex != null ? selectedReason[reasonIndex!].reason.subTitle : '';
  TypeDayEnum get typeDayEnumSelected => typeDayIndex != null
      ? typeDayOff[typeDayIndex!].typeDayEnum
      : TypeDayEnum.none;
  int? get typeDayIndex => _typeDayIndex.value;
  String get typeDayText =>
      typeDayIndex != null ? typeDayOff[typeDayIndex!].title : '';

  String get timeBeginText => formatTime(_timeBegin.value);
  String get timeEndText => formatTime(_timeEnd.value);
  String get timeTotal => totalTime(timeBegin, timeEnd);
  String get timeTotalText => totalTimeText(timeBegin, timeEnd);

  String get timeLateText => formatTime(timeLate);
  String get timeSoonText => formatTime(timeSoon);

  TimeOfDay? get timeBegin => _timeBegin.value;
  TimeOfDay? get timeEnd => _timeEnd.value;

  TimeOfDay? get timeLate => _timeLate.value;
  TimeOfDay? get timeSoon => _timeSoon.value;

  DateTime get focusDay => _focusDay.value;

  String get receiverText => _receiverText.value;

  @override
  void onInit() {
    super.onInit();
    reason = TextEditingController();
    _appSevice = ApplicationService();
    reasonFocusNode = FocusNode();
    initReceiver();
    initReason();
  }

  setLoading(bool value) => _loadingRx.value = value;

  //SELECT TYPE DAY
  selectTypeApplication(BuildContext context, int index) {
    if (index != 0 || homeClientController.employee!.dayOff! > 0) {
      if (typeDayIndex != index) {
        for (int i = 0; i < typeDayOff.length; i++) {
          if (i == index) {
            typeDayOff[i].isChecked = true;
            _typeDayIndex.value = index;
          } else {
            typeDayOff[i].isChecked = false;
          }
        }
      } else {
        typeDayOff[index].isChecked = false;
        _typeDayIndex.value = null;
      }
      update();
      resetCalendar();
    } else {
      context.showToast(
          'Bạn đã hết số ngày nghỉ phép. Vui lòng chọn nghỉ phép không lương');
    }
  }

  resetCalendar() {
    selectDayOff.clear();
    selectOvertime.clear();
    selectLate.clear();
    selectSoon.clear();
  }

  selectCalendarPicker(BuildContext context, DateTime date) {
    if (typeDayIndex != null) {
      TypeDayEnum type = typeDayOff[typeDayIndex!].typeDayEnum;
      switch (type) {
        case TypeDayEnum.dayOff:
          initSessionDayOff(date.millisecondsSinceEpoch);
          showDayoffPicker(context, date);
          break;
        case TypeDayEnum.dayOffNotSalary:
          initSessionDayOff(date.millisecondsSinceEpoch);
          showDayoffPicker(context, date);
          break;
        case TypeDayEnum.dayOvertime:
          initOvertime(date);
          showOvertimePicker(context, date);
          break;
        case TypeDayEnum.dayGoLate:
          initLate(date);
          showGoLatePicker(context, date);
          break;
        case TypeDayEnum.dayBackSoon:
          initSoon(date);
          showBackSoonPicker(context, date);
          break;
        default:
      }
    } else {
      context.showErrorMessage('Vui lòng chọn loại đơn trước');
    }
  }

  //SESSION DAY OFF
  selectSessionType(DateTime day, int type) {
    for (int i = 0; i < _typeSessionDayOff.value.length; i++) {
      if (type == i) {
        if (_typeSessionDayOff.value[i].isChecked) {
          _typeSessionDayOff.value[i].isChecked = false;
          removeSessionDayOff(day);
        } else {
          _typeSessionDayOff.value[i].isChecked = true;
          addSessionDayOff(day, type);
        }
      } else {
        _typeSessionDayOff.value[i].isChecked = false;
      }
    }
    update();
  }

  initSessionDayOff(int day) {
    bool hasNotExist = selectDayOff.every((e) => e.day != day);
    if (!hasNotExist) {
      for (var e in selectDayOff) {
        if (e.day == day) {
          for (int i = 0; i < typeSessionDayOff.length; i++) {
            if (e.type == i) {
              typeSessionDayOff[i].isChecked = true;
            } else {
              typeSessionDayOff[i].isChecked = false;
            }
          }
        }
      }
    } else {
      for (var e in typeSessionDayOff) {
        e.isChecked = false;
      }
    }
  }

  addSessionDayOff(DateTime date, int type) {
    int day = date.millisecondsSinceEpoch;
    bool hasNotExist = selectDayOff.every((e) => e.day != day);
    if (hasNotExist) {
      _selectedDayOff.value.add(SelectedDayOff(day: day, type: type));
    } else {
      for (var e in selectDayOff) {
        if (e.day == day) {
          e.type = type;
        }
      }
    }
    _focusDay.value = date;
  }

  removeSessionDayOff(DateTime date) {
    int day = date.millisecondsSinceEpoch;
    bool hasNotExist = selectDayOff.every((e) => e.day != day);
    if (!hasNotExist) {
      _selectedDayOff.value.removeWhere((e) => e.day == day);
    }
  }

  //DAY OVERTIME
  initOvertime(DateTime day) {
    bool hasNotExist = selectOvertime
        .every((e) => e.day != day.startTime().millisecondsSinceEpoch);
    if (!hasNotExist) {
      for (var e in selectOvertime) {
        if (e.day == day.startTime().millisecondsSinceEpoch) {
          _timeBegin.value =
              TimeOfDay(hour: e.begin.hour, minute: e.begin.minute);
          _timeEnd.value = TimeOfDay(hour: e.end.hour, minute: e.end.minute);
        }
      }
    } else {
      _timeBegin.value = null;
      _timeEnd.value = null;
    }
  }

  onChangeOvertime(TimeOfDay? begin, TimeOfDay? end) {
    if (begin != null) {
      _timeBegin.value = begin;
    }
    if (end != null) {
      _timeEnd.value = end;
    }
    update();
  }

  addOvertime(BuildContext context, DateTime day) {
    bool hasNotExist = selectOvertime
        .every((e) => e.day != day.startTime().millisecondsSinceEpoch);
    if (timeBegin != null && timeEnd != null) {
      if (hasNotExist) {
        selectOvertime.add(
          SelectedOvertime(
            day: day.startTime().millisecondsSinceEpoch,
            begin: timeBegin!,
            end: timeEnd!,
          ),
        );
      } else {
        for (var e in selectOvertime) {
          if (e.day == day.startTime().millisecondsSinceEpoch) {
            e.begin = timeBegin!;
            e.end = timeEnd!;
          }
        }
      }
      update();
    }
    _focusDay.value = day;
    context.pop();
  }

  removeOvertime(BuildContext context, DateTime day) {
    bool hasNotExist = selectOvertime
        .every((e) => e.day != day.startTime().millisecondsSinceEpoch);
    if (!hasNotExist) {
      _selectedOvertime.value
          .removeWhere((e) => e.day == day.startTime().millisecondsSinceEpoch);
    }
    update();
    context.pop();
  }

  //DAY LATE
  onChangeLate(TimeOfDay? date) {
    if (date != null) {
      _timeLate.value = date;
    }
  }

  initLate(DateTime day) {
    bool hasNotExist = selectLate
        .every((e) => e.day != day.startTime().millisecondsSinceEpoch);
    if (!hasNotExist) {
      for (var e in selectLate) {
        if (e.day == day.startTime().millisecondsSinceEpoch) {
          _timeLate.value = TimeOfDay(hour: e.time.hour, minute: e.time.minute);
        }
      }
    } else {
      _timeLate.value = null;
    }
  }

  addLate(BuildContext context, DateTime day) {
    bool hasNotExist = _selectedLate.value
        .every((e) => e.day != day.startTime().millisecondsSinceEpoch);
    if (timeLate != null) {
      if (hasNotExist) {
        _selectedLate.value.add(SelectedLateSoon(
          day: day.startTime().millisecondsSinceEpoch,
          time: timeLate!,
        ));
      } else {
        for (var e in _selectedLate.value) {
          if (e.day == day.startTime().millisecondsSinceEpoch) {
            e.time = timeLate!;
          }
        }
      }
    }
    _focusDay.value = day;
    update();
    context.pop();
  }

  removeLate(BuildContext context, DateTime day) {
    bool hasNotExist = selectLate
        .every((e) => e.day != day.startTime().millisecondsSinceEpoch);
    if (!hasNotExist) {
      _selectedLate.value
          .removeWhere((e) => e.day == day.startTime().millisecondsSinceEpoch);
    }
    update();
    context.pop();
  }

  //DAY SOON
  onChangeSoon(TimeOfDay? date) {
    if (date != null) {
      _timeSoon.value = date;
      update();
    }
  }

  initSoon(DateTime day) {
    bool hasNotExist = selectSoon
        .every((e) => e.day != day.startTime().millisecondsSinceEpoch);
    if (!hasNotExist) {
      for (var e in selectSoon) {
        if (e.day == day.startTime().millisecondsSinceEpoch) {
          _timeSoon.value = TimeOfDay(hour: e.time.hour, minute: e.time.minute);
        }
      }
    } else {
      _timeSoon.value = null;
    }
  }

  addSoon(BuildContext context, DateTime day) {
    bool hasNotExist = selectSoon
        .every((e) => e.day != day.startTime().millisecondsSinceEpoch);
    if (timeSoon != null) {
      if (hasNotExist) {
        selectSoon.add(SelectedLateSoon(
          day: day.startTime().millisecondsSinceEpoch,
          time: timeSoon!,
        ));
      } else {
        for (var e in selectLate) {
          if (e.day == day.startTime().millisecondsSinceEpoch) {
            e.time = timeSoon!;
          }
        }
      }
    }
    update();
    _focusDay.value = day;
    context.pop();
  }

  removeSoon(BuildContext context, DateTime day) {
    bool hasNotExist = selectSoon
        .every((e) => e.day != day.startTime().millisecondsSinceEpoch);
    if (!hasNotExist) {
      _selectedSoon.value
          .removeWhere((e) => e.day == day.startTime().millisecondsSinceEpoch);
    }
    update();
    context.pop();
  }

  //RECEIVER
  initReceiver() async {
    try {
      final res = await _appSevice.getReceiver();
      if (res.isOk) {
        res.data.forEach((e) => _selectedReceiver.value
            .add(SelectedReceiver(employee: e, hasSelect: false)));
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  addReceiver(int index) {
    selectReceiver[index].hasSelect = !selectReceiver[index].hasSelect;
    _receiverText.value = '';
    for (var e in selectReceiver) {
      if (e.hasSelect) {
        _receiverText.value += '${e.employee.fullname!}, ';
      }
    }
    update();
  }

  initReason() async {
    try {
      final res = await _appSevice.getListReason();
      res.forEach((e) => _selectedReason.value
          .add(SelectedReason(reason: e, hasSelect: false)));
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  addReason(int index) async {
    if (reasonIndex != index) {
      for (int i = 0; i < selectedReason.length; i++) {
        if (i == index) {
          selectedReason[i].reason.isChecked = true;
          _reasonIndex.value = index;
        } else {
          selectedReason[i].reason.isChecked = false;
        }
      }
    } else {
      selectedReason[index].reason.isChecked = false;
      _reasonIndex.value = null;
    }
    update();
  }

  //API
  getParmsData() {
    List<JSON> data = [];
    switch (typeDayEnumSelected) {
      case TypeDayEnum.dayOff:
      case TypeDayEnum.dayOffNotSalary:
        for (var e in selectDayOff) {
          data.add({
            'dayOffDate': e.day,
            'session': e.type,
          });
        }
        break;
      case TypeDayEnum.dayOvertime:
        for (var e in selectOvertime) {
          data.add({
            'startTime': convertDateTimeFromTime(e.day, e.begin),
            'endTime': convertDateTimeFromTime(e.day, e.end),
            'dayOffDate': e.day,
            'hours': parseHoursFromTwoTime(e.begin, e.end),
          });
        }
        break;
      case TypeDayEnum.dayGoLate:
        for (var e in selectLate) {
          data.add({
            'dayOffDate': e.day,
            'hours': convertDateTimeFromTime(e.day, e.time),
          });
        }
        break;
      case TypeDayEnum.dayBackSoon:
        for (var e in selectSoon) {
          data.add({
            'dayOffDate': e.day,
            'hours': convertDateTimeFromTime(e.day, e.time),
          });
        }
        break;
      default:
        break;
    }

    List<int?> receiverId = selectReceiver
        .where((e) => e.hasSelect)
        .map((e) => e.employee.id)
        .toList();
    return {
      'employeeId': _prefs.id,
      'type_application': typeDayEnumSelected.getId(),
      'title': typeDayEnumSelected.getTitle(),
      'content': reasonText,
      'receiverId': receiverId,
      'data': data,
    };
  }

  submitApplication(BuildContext context) {
    JSON data = getParmsData();
    if ((data['data'] as List).isEmpty) {
      context.showErrorMessage('Vui lòng chọn ngày gửi');
      return;
    } else if ((data['receiverId'] as List).isEmpty) {
      context.showErrorMessage('Vui lòng chọn người gửi');
      return;
    } else {
      showSubmitDialog(
        context,
        title: 'Xác nhận gửi đơn',
        message: 'Bạn đã chắc chắn muốn gửi đơn?',
        onSubmit: () => createApplication(context, data),
      );
    }
  }

  createApplication(BuildContext context, JSON data) async {
    try {
      setLoading(true);
      final res = await _appSevice.createApplication(parms: data);
      setLoading(false);
      if (res.isOk) {
        if (!context.mounted) return;
        context.showSuccessMessage('Gửi đơn thành công');
        final MyApplicationController controller = Get.find();
        controller.refreshing();
        context.pop();
      }
    } catch (e) {
      setLoading(false);
      if (!context.mounted) return;
      context.showErrorMessage('Gửi đơn không thành công $e');
    }
  }

  updateStatus(
    BuildContext context,
    ApplicationEnum status,
    ApplicationModel item,
  ) async {
    try {
      Loading().show(context: context);
      final res = await _appSevice.updateStatus({
        'status': ApplicationEnum.parseId(status),
        'id': item.id,
      });
      if (res.isOk) {
        if (_prefs.role == RoleEnum.client) {
          final PeopleApplicationController controller = Get.find();
          controller.handleApproved(item.id, status);
        } else {
          final ApproveApplicationController approve = Get.find();
          final PendingApplicationController pending = Get.find();
          item.changeStatus(status);
          pending.handleRemoveItem(item);
          approve.handleAddItem(item);
        }
        Loading().hide();
        if (!context.mounted) return;
        context.showSuccessMessage('Duyệt đơn thành công');
        context.pop();
      }
    } catch (e) {
      debugPrint(e.toString());
      Loading().hide();
      if (!context.mounted) return;
      context.showErrorMessage('Duyệt đơn không thành công. $e');
    }
  }
}

class SelectedDayOff {
  final int day;
  int type;
  SelectedDayOff({
    required this.day,
    required this.type,
  });
}

class SelectedOvertime {
  final int day;
  TimeOfDay begin;
  TimeOfDay end;
  SelectedOvertime({
    required this.day,
    required this.begin,
    required this.end,
  });
}

class SelectedLateSoon {
  final int day;
  TimeOfDay time;
  SelectedLateSoon({
    required this.day,
    required this.time,
  });
}

class TypeDay {
  final String title;
  final String subTitle;
  bool isChecked;
  final TypeDayEnum typeDayEnum;
  TypeDay({
    required this.title,
    required this.subTitle,
    required this.isChecked,
    required this.typeDayEnum,
  });
}

class SelectedReceiver {
  EmployeeModel employee;
  bool hasSelect;
  SelectedReceiver({
    required this.employee,
    required this.hasSelect,
  });

  copyWith() {
    return SelectedReceiver(
      employee: employee,
      hasSelect: hasSelect,
    );
  }
}
