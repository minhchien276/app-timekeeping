// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:flutter/material.dart';

import 'package:e_tmsc_app/data/models/timekeeping_model.dart';
import 'package:e_tmsc_app/data/models/typeofwork_model.dart';
import 'package:e_tmsc_app/utils/color.dart';

final dayNoteList = [
  DayEnum.success,
  DayEnum.lated,
  DayEnum.missing,
  DayEnum.pending,
  DayEnum.dayoff,
];

enum DayEnum {
  success,
  lated,
  missing,
  pending,
  dayoff,
  holiday,
  today,
  normal;

  CalendarData buildData() {
    switch (this) {
      case DayEnum.success:
        return CalendarData(
          bgColor: Colors.green,
          textColor: white,
          borderColor: Colors.green,
          text: 'Ngày công',
          icon: AppIcon.timekeepingSuccess,
        );
      case DayEnum.lated:
        return CalendarData(
          borderColor: Colors.red,
          bgColor: Colors.red,
          textColor: white,
          text: 'Đi muộn',
          icon: AppIcon.goLate,
        );
      case DayEnum.missing:
        return CalendarData(
          borderColor: primary900,
          bgColor: primary900,
          textColor: white,
          text: 'Quên công',
          icon: AppIcon.timekeepingFail,
        );
      case DayEnum.pending:
        return CalendarData(
          borderColor: Colors.grey,
          bgColor: Colors.grey,
          textColor: white,
          text: 'Đang xử lý',
          icon: AppIcon.timekeepingFail,
        );
      case DayEnum.dayoff:
        return CalendarData(
          bgColor: Colors.blue,
          borderColor: Colors.blue,
          textColor: white,
          text: 'Ngày phép',
          icon: AppIcon.dayoff,
        );
      case DayEnum.today:
        return CalendarData(
          bgColor: white,
          textColor: black,
          borderColor: primary900,
          text: 'Ngày hôm nay',
          icon: AppIcon.dayoff,
        );
      case DayEnum.holiday:
        return CalendarData(
          bgColor: const Color(0xffBD4CFF),
          borderColor: const Color(0xffBD4CFF),
          textColor: white,
          text: 'Ngày nghỉ lễ',
          icon: AppIcon.dayoff,
        );
      case DayEnum.normal:
        return CalendarData(
          bgColor: white,
          borderColor: white,
          textColor: black,
          text: 'Ngày bình thường',
          icon: AppIcon.dayoff,
        );
      default:
        return CalendarData(
          bgColor: white,
          textColor: black,
          text: 'Ngày bình thường',
          icon: AppIcon.dayoff,
        );
    }
  }

  static DayEnum parseInt(int status) {
    switch (status) {
      case 1:
        return DayEnum.success;
      case 2:
        return DayEnum.lated;
      case 3:
        return DayEnum.missing;
      case 4:
        return DayEnum.pending;
      case 5:
        return DayEnum.dayoff;
      case 6:
        return DayEnum.today;
      case 7:
        return DayEnum.holiday;
      default:
        return DayEnum.normal;
    }
  }

  static int fromEnum(DayEnum? status) {
    switch (status) {
      case DayEnum.success:
        return 1;
      case DayEnum.lated:
        return 2;
      case DayEnum.missing:
        return 3;
      case DayEnum.pending:
        return 4;
      case DayEnum.dayoff:
        return 5;
      case DayEnum.today:
        return 6;
      case DayEnum.holiday:
        return 7;
      default:
        return 8;
    }
  }
}

class CalendarData {
  final Color borderColor;
  final Color bgColor;
  final Color textColor;
  final String text;
  final String icon;
  CalendarData({
    this.borderColor = white,
    required this.bgColor,
    required this.textColor,
    required this.text,
    required this.icon,
  });
}

class CalendarHandler {
  static bool theSameDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  static String convertTitleWeekDay(int weekDay) {
    switch (weekDay) {
      case 1:
        return 'T2';
      case 2:
        return 'T3';
      case 3:
        return 'T4';
      case 4:
        return 'T5';
      case 5:
        return 'T6';
      case 6:
        return 'T7';
      case 7:
        return 'CN';
      default:
        return 'T2';
    }
  }

  static List<String> buildPickerData(
    TimeKeeping? timeKeeping,
    TypeOfWork? typeOfWork,
  ) {
    if (timeKeeping?.checkin?.checkin != null && typeOfWork != null) {
      DateTime date = timeKeeping!.date ?? DateTime.now().startTime();
      DateTime checkIn = timeKeeping.checkin!.checkin!;
      DateTime timeIn = DateTime(date.year, date.month, date.day,
          typeOfWork.timeIn!.hour, typeOfWork.timeIn!.minute);
      DateTime timeOut = DateTime(date.year, date.month, date.day,
          typeOfWork.timeIn!.hour, typeOfWork.timeIn!.minute);
      String lated = '--:--';

      if (timeKeeping.lated != null) {
        lated =
            '${timeKeeping.lated!.split(":")[0]}:${timeKeeping.lated!.split(":")[1]}';
      }

      if (timeKeeping.checkout?.checkout != null) {
        DateTime checkOut = timeKeeping.checkout!.checkout!;
        Duration duration1 = checkOut.difference(checkIn);
        final title =
            '${duration1.inHours} tiếng ${duration1.inMinutes.remainder(60)} phút';

        if (checkIn.isBefore(timeIn)) {
          checkIn = timeIn;
        }
        if (checkOut.isBefore(timeOut)) {
          checkOut = timeOut;
        }

        Duration duration2 = checkOut.difference(checkIn);
        final total =
            '${duration2.inHours.toString().padLeft(2, '0')}:${duration2.inMinutes.remainder(60).toString().padLeft(2, '0')}';

        return [title, total, lated];
      }
      return ['0 tiếng 0 phút', '--:--', lated];
    }
    return ['0 tiếng 0 phút', '--:--', '--:--'];
  }
}
