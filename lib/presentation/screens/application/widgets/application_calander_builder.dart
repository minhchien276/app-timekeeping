// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/logic/controllers/application/application_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/shared/enums/type_day_enum.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CalendarPickerBuilder extends StatelessWidget {
  final DateTime day;
  final TypeDayEnum type;
  const CalendarPickerBuilder({
    Key? key,
    required this.day,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApplicationController controller = Get.find();
    switch (type) {
      case TypeDayEnum.dayOff:
      case TypeDayEnum.dayOffNotSalary:
        return dayoffItem(day, checkDayoff(day, controller.selectDayOff));
      case TypeDayEnum.dayOvertime:
        return overtimeItem(day, checkOvertime(day, controller.selectOvertime));
      case TypeDayEnum.dayGoLate:
        return lateSoonItem(day, checkLateSoon(day, controller.selectLate));
      case TypeDayEnum.dayBackSoon:
        return lateSoonItem(day, checkLateSoon(day, controller.selectSoon));
      default:
        return normalDay(day);
    }
  }

  int checkDayoff(DateTime day, List<SelectedDayOff> data) {
    for (var e in data) {
      if (e.day == day.millisecondsSinceEpoch) {
        return e.type;
      }
    }
    return -1;
  }

  bool checkOvertime(DateTime day, List<SelectedOvertime> data) {
    for (var e in data) {
      if (e.day == day.millisecondsSinceEpoch) {
        return true;
      }
    }
    return false;
  }

  bool checkLateSoon(DateTime day, List<SelectedLateSoon> data) {
    for (var e in data) {
      if (e.day == day.millisecondsSinceEpoch) {
        return true;
      }
    }
    return false;
  }

  Widget dayoffItem(
    DateTime date,
    int type,
  ) {
    return Container(
      height: 32.h,
      width: 32.h,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(4),
        border: type != -1
            ? Border.all(color: Colors.blue)
            : date.millisecondsSinceEpoch ==
                    DateTime.now().startTime().millisecondsSinceEpoch
                ? Border.all(color: primary900)
                : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (type == 0) ...[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 16.h,
                width: 16.h,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: Radius.circular(2),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 16.h,
                width: 16.h,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                ),
              ),
            ),
          ],
          if (type == 1) ...[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 16.h,
                width: 16.h,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: Radius.circular(2),
                  ),
                ),
              ),
            ),
          ],
          if (type == 2) ...[
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 16.h,
                width: 16.h,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                ),
              ),
            ),
          ],
          Center(
            child: TextWidget(
              text: day.day.toString(),
              color: black,
              textStyle: textStyle14SemiBold,
            ),
          ),
        ],
      ),
    );
  }

  Widget overtimeItem(
    DateTime date,
    bool hasData,
  ) {
    return Container(
      height: 32.h,
      width: 32.h,
      decoration: BoxDecoration(
        color: hasData ? Colors.green : white,
        borderRadius: BorderRadius.circular(4),
        border: hasData
            ? null
            : date.millisecondsSinceEpoch ==
                    DateTime.now().startTime().millisecondsSinceEpoch
                ? Border.all(color: primary900)
                : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextWidget(
            text: day.day.toString(),
            color: hasData ? white : black,
            textStyle: textStyle14SemiBold,
          ),
        ],
      ),
    );
  }

  Widget lateSoonItem(
    DateTime date,
    bool hasData,
  ) {
    return Container(
      height: 32.h,
      width: 32.h,
      decoration: BoxDecoration(
          color: hasData ? primary900 : white,
          borderRadius: BorderRadius.circular(4),
          border: hasData
              ? null
              : date.millisecondsSinceEpoch ==
                      DateTime.now().startTime().millisecondsSinceEpoch
                  ? Border.all(color: primary900)
                  : null),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextWidget(
            text: day.day.toString(),
            color: hasData ? white : black,
            textStyle: textStyle14SemiBold,
          ),
        ],
      ),
    );
  }

  Widget normalDay(
    DateTime date,
  ) {
    return Container(
      height: 32.h,
      width: 32.h,
      decoration: BoxDecoration(
          color: white,
          border: date.millisecondsSinceEpoch ==
                  DateTime.now().startTime().millisecondsSinceEpoch
              ? Border.all(color: primary900)
              : null,
          borderRadius: BorderRadius.circular(4)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextWidget(
            text: day.day.toString(),
            color: black,
            textStyle: textStyle14SemiBold,
          ),
        ],
      ),
    );
  }
}
