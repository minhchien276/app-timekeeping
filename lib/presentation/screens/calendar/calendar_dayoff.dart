import 'package:e_tmsc_app/logic/controllers/home/home_admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../../data/models/employee_model.dart';
import '../../../shared/extensions/datetime_extension.dart';
import '../../../utils/color.dart';
import '../../../utils/network_image.dart';
import '../../../utils/styles.dart';
import '../../widgets/common/common_custom_text.dart';

class CalendarDayoff extends StatefulWidget {
  const CalendarDayoff({super.key});

  @override
  State<CalendarDayoff> createState() => _CalendarDayoffState();
}

class _CalendarDayoffState extends State<CalendarDayoff>
    with TickerProviderStateMixin {
  // late AnimationController controller;
  bool isClick = false;
  final HomeAdminController controller = Get.find();

  // @override
  // void initState() {
  //   controller = AnimationController(
  //       vsync: this, duration: const Duration(milliseconds: 500));
  //   super.initState();
  // }
  //
  // void rotate() {
  //   setState(() {});
  //   if (isClick) {
  //     controller.forward(from: 0.0);
  //   } else {
  //     controller.reverse(from: 1.0);
  //   }
  //   isClick = !isClick;
  // }

  @override
  Widget build(BuildContext context) {
    return StickyGroupedListView<EmployeeModel, DateTime>(
      elements: controller.listEmployeeOff,
      order: StickyGroupedListOrder.DESC,
      groupBy: (EmployeeModel element) => DateTime(
        element.dayOffDate!.year,
        element.dayOffDate!.month,
        element.dayOffDate!.day,
      ),
      groupComparator: (DateTime value1, DateTime value2) =>
          value2.compareTo(value1),
      itemComparator: (EmployeeModel element1, EmployeeModel element2) =>
          element1.dayOffDate!.compareTo(element2.dayOffDate!),
      groupSeparatorBuilder: (EmployeeModel e) {
        return Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
          child: TextWidget(
            text: formatPostDateTime(e.dayOffDate!),
            color: primary900,
            textStyle: textStyle14.copyWith(fontWeight: FontWeight.bold),
          ),
        );
      },
      itemBuilder: (context, employee) {
        return Container(
          margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 10.h),
          padding:
              EdgeInsets.only(top: 10.h, left: 12.w, right: 12.w, bottom: 10.h),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(16.h),
            boxShadow: [
              BoxShadow(
                color: boxShadowColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 15,
                offset: const Offset(
                  0,
                  0,
                ),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  networkImageWithCached(
                    size: Size(40.h, 40.h),
                    url: employee.image!,
                    borderRadius: 100,
                    boxBorder: Border.all(color: primary900, width: 2),
                  ),
                  10.horizontalSpace,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: employee.fullname!,
                        color: black,
                        textStyle: textStyle13SemiBold,
                      ),
                      TextWidget(
                        text: employee.departmentName!,
                        color: black,
                        textStyle: textStyle11,
                      )
                    ],
                  )
                ],
              ),
              Container(
                width: 80.w,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: red)),
                child: Center(
                  child: TextWidget(
                    text: "Nghỉ phép",
                    color: red,
                    textStyle:
                        textStyle12.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
