import 'package:e_tmsc_app/logic/controllers/home/home_admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/go_routes.dart';
import '../../../utils/app_icon.dart';
import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../widgets/common/common_custom_text.dart';

class CalendarOnline extends StatefulWidget {
  const CalendarOnline({super.key});

  @override
  State<CalendarOnline> createState() => _CalendarOnlineState();
}

class _CalendarOnlineState extends State<CalendarOnline>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool isClick = false;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    super.initState();
  }

  void rotate() {
    setState(() {});
    if (isClick) {
      controller.forward(from: 0.0);
    } else {
      controller.reverse(from: 1.0);
    }
    isClick = !isClick;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeAdminController>(
      builder: (controller) {
        final keys = controller.employeeOnline.keys.toList();
        final values = controller.employeeOnline.values.toList();
        return Container(
          height: double.infinity,
          margin: EdgeInsets.only(
              left: 24.w, right: 24.w, bottom: 110.h, top: 20.h),
          padding:
              EdgeInsets.only(top: 10.h, left: 12.w, right: 12.w, bottom: 10.h),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: black.withOpacity(0.05)),
            boxShadow: [
              BoxShadow(
                color: black.withOpacity(0.1),
                blurRadius: 10.0, // soften the shadow
                spreadRadius: 0.0, //extend the shadow
                offset: const Offset(
                  3.0, // Move to right 10  horizontally
                  3.0, // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: controller.employeeOnline.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoute.listEmployeeOnlineDetail.name,
                      extra: {
                        'departmentName': keys[index].text(),
                        'employee': values[index]
                      });
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                  decoration: index != controller.employeeOnline.length - 1
                      ? const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: grey500,
                              width: 0.5,
                            ),
                          ),
                        )
                      : const BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AppIcon.group, scale: 3),
                          16.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: 'Team ${keys[index].text()}',
                                color: black,
                                textStyle: textStyle15SemiBold,
                              ),
                              TextWidget(
                                text: '${values[index].length} nhân sự đi làm',
                                color: black,
                                textStyle: textStyle10,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Image.asset(AppIcon.next, scale: 3)
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
