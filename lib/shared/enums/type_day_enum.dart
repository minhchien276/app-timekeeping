import 'package:e_tmsc_app/shared/enums/day_enum.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:flutter/material.dart';

enum TypeDayEnum {
  dayOff,
  dayOffNotSalary,
  dayOvertime,
  dayGoLate,
  dayBackSoon,
  none;

  CalendarData buildData() {
    switch (this) {
      case TypeDayEnum.dayOff:
        return CalendarData(
          bgColor: Colors.blue,
          textColor: white,
          text: 'Nghỉ phép có lương',
          icon: AppIcon.timekeepingSuccess,
        );
      case TypeDayEnum.dayOffNotSalary:
        return CalendarData(
          bgColor: Colors.blue,
          textColor: white,
          text: 'Nghỉ phép không lương',
          icon: AppIcon.timekeepingSuccess,
        );
      case TypeDayEnum.dayOvertime:
        return CalendarData(
          bgColor: primary900,
          textColor: white,
          text: 'Tăng ca',
          icon: AppIcon.timekeepingFail,
        );
      case TypeDayEnum.dayGoLate:
        return CalendarData(
          bgColor: Colors.grey,
          textColor: white,
          text: 'Đi muộn',
          icon: AppIcon.timekeepingFail,
        );
      case TypeDayEnum.dayBackSoon:
        return CalendarData(
          bgColor: Colors.blue,
          textColor: white,
          text: 'Về sớm',
          icon: AppIcon.dayoff,
        );
      default:
        return CalendarData(
          bgColor: Colors.blue,
          textColor: white,
          text: 'Nghỉ phép có lương',
          icon: AppIcon.timekeepingSuccess,
        );
    }
  }

  int getId() {
    switch (this) {
      case TypeDayEnum.dayOff:
        return 0;
      case TypeDayEnum.dayOffNotSalary:
        return 1;
      case TypeDayEnum.dayOvertime:
        return 2;
      case TypeDayEnum.dayGoLate:
        return 3;
      case TypeDayEnum.dayBackSoon:
        return 4;
      default:
        return -1;
    }
  }

  String getTitle() {
    switch (this) {
      case TypeDayEnum.dayOff:
        return 'Đơn nghỉ phép có lương';
      case TypeDayEnum.dayOffNotSalary:
        return 'Đơn nghỉ phép không lương';
      case TypeDayEnum.dayOvertime:
        return 'Đơn xin tăng ca';
      case TypeDayEnum.dayGoLate:
        return 'Đơn xin đi làm muộn';
      case TypeDayEnum.dayBackSoon:
        return 'Đơn xin về sớm';
      default:
        return '';
    }
  }

  static TypeDayEnum parseEnum(int id) {
    switch (id) {
      case 0:
        return TypeDayEnum.dayOff;
      case 1:
        return TypeDayEnum.dayOffNotSalary;
      case 2:
        return TypeDayEnum.dayOvertime;
      case 3:
        return TypeDayEnum.dayGoLate;
      case 4:
        return TypeDayEnum.dayBackSoon;
      default:
        return TypeDayEnum.none;
    }
  }
}
