// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/overtime_model.dart';
import 'package:e_tmsc_app/data/models/timekeeping_model.dart';
import 'package:e_tmsc_app/logic/controllers/home/home_client_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/shared/enums/day_enum.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CalendarNormalBuilder extends StatelessWidget {
  final DateTime day;
  const CalendarNormalBuilder({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeClientController controller = Get.find();
    if (checkDay(day, controller.calendar.daysOfLate)) {
      return buildDay(day.day, DayEnum.lated);
    } else if (checkDay(day, controller.calendar.daysOfMissing)) {
      return buildDay(day.day, DayEnum.missing);
    } else if (checkDay(day, controller.calendar.daysOfWork)) {
      return buildDay(day.day, DayEnum.success);
    } else if (checkDay(day, controller.calendar.daysOff)) {
      return buildDay(day.day, DayEnum.dayoff);
    } else if (checkDay(day, controller.calendar.daysOfPending)) {
      return buildDay(day.day, DayEnum.pending);
    } else if (checkDay(day, controller.calendar.daysHoliday)) {
      return buildDay(day.day, DayEnum.holiday);
    } else if (checkDay(day, controller.previousCalendar.daysOfLate)) {
      return buildDay(day.day, DayEnum.lated);
    } else if (checkDay(day, controller.previousCalendar.daysOfMissing)) {
      return buildDay(day.day, DayEnum.missing);
    } else if (checkDay(day, controller.previousCalendar.daysOfWork)) {
      return buildDay(day.day, DayEnum.success);
    } else if (checkDay(day, controller.previousCalendar.daysOff)) {
      return buildDay(day.day, DayEnum.dayoff);
    } else if (checkDay(day, controller.previousCalendar.daysOfPending)) {
      return buildDay(day.day, DayEnum.pending);
    } else if (checkDay(day, controller.previousCalendar.daysHoliday)) {
      return buildDay(day.day, DayEnum.holiday);
    } else if (CalendarHandler.theSameDay(day, DateTime.now())) {
      return buildDay(day.day, DayEnum.today);
    }
    return buildDay(day.day, DayEnum.normal);
  }

  bool checkDay(DateTime day, List<TimeKeeping> data) {
    for (var e in data) {
      if (e.date?.millisecondsSinceEpoch == day.millisecondsSinceEpoch) {
        return true;
      }
    }
    return false;
  }

  Widget buildDay(int day, DayEnum dayEnum) {
    return Container(
      height: 32.h,
      width: 32.h,
      decoration: BoxDecoration(
        color: dayEnum.buildData().bgColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: dayEnum.buildData().borderColor),
      ),
      child: Center(
        child: TextWidget(
          text: day.toString(),
          color: dayEnum.buildData().textColor,
          textStyle: textStyle14SemiBold,
        ),
      ),
    );
  }
}

class CalendarExtraBuilder extends StatelessWidget {
  final DateTime day;
  const CalendarExtraBuilder({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeClientController controller = Get.find();
    if (checkDay(day, controller.overtime)) {
      return buildDay(day.day, DayEnum.success);
    } else if (CalendarHandler.theSameDay(day, DateTime.now())) {
      return buildDay(day.day, DayEnum.today);
    }
    return buildDay(day.day, DayEnum.normal);
  }

  bool checkDay(DateTime day, List<OvertimeModel> data) {
    for (var e in data) {
      if (e.dayOffDate?.millisecondsSinceEpoch == day.millisecondsSinceEpoch) {
        return true;
      }
    }
    return false;
  }

  Widget buildDay(int day, DayEnum dayEnum) {
    return Container(
      height: 32.h,
      width: 32.h,
      decoration: BoxDecoration(
        color: dayEnum.buildData().bgColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: dayEnum.buildData().borderColor),
      ),
      child: Center(
        child: TextWidget(
          text: day.toString(),
          color: dayEnum.buildData().textColor,
          textStyle: textStyle14SemiBold,
        ),
      ),
    );
  }
}
