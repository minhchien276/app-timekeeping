// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/shared/enums/department_enum.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CalendarDepartment extends StatefulWidget {
  final DepartmentEnum department;
  final List<EmployeeModel> employees;
  final String detail;
  const CalendarDepartment({
    Key? key,
    required this.department,
    required this.employees,
    required this.detail,
  }) : super(key: key);

  @override
  State<CalendarDepartment> createState() => _CalendarDepartmentState();
}

class _CalendarDepartmentState extends State<CalendarDepartment>
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
    if (!isClick) {
      controller.forward(from: 0.0);
    } else {
      controller.reverse(from: 1.0);
    }
    setState(() {
      isClick = !isClick;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => widget.employees.isEmpty ? null : rotate(),
          child: Container(
            height: 60.h,
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 10.h, top: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: grey500,
                  width: 0.5,
                ),
              ),
            ),
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
                          text: 'Team ${widget.department.text()}',
                          color: black,
                          textStyle: textStyle15SemiBold,
                        ),
                        TextWidget(
                          text: '${widget.employees.length} ${widget.detail}',
                          color: black,
                          textStyle: textStyle10,
                        ),
                      ],
                    ),
                  ],
                ),
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.25).animate(controller),
                  child: Image.asset(AppIcon.next, scale: 3),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          height: isClick ? widget.employees.length * 51 : 0,
          alignment: isClick ? Alignment.bottomCenter : Alignment.topCenter,
          curve: Curves.fastOutSlowIn,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.employees.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => context.pushNamed(AppRoute.profileDetail.name,
                    extra: widget.employees[index]),
                child: SizedBox(
                  height: 50.h,
                  width: double.infinity,
                  child: Row(
                    children: [
                      networkImageWithCached(
                        size: Size(40.h, 40.h),
                        url: widget.employees[index].image,
                        borderRadius: 100,
                        boxBorder: Border.all(color: white, width: 2),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: TextWidget(
                          text: widget.employees[index].fullname ?? '',
                          color: Colors.black,
                          textStyle: textStyle14SemiBold,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
