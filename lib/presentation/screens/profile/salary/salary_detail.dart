// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/salary_model.dart';
import 'package:e_tmsc_app/logic/controllers/home/home_client_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../utils/app_icon.dart';

class SalaryDetailScreen extends StatelessWidget {
  final SalaryModel salary;
  const SalaryDetailScreen({
    Key? key,
    required this.salary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: const KBackButton(),
        backgroundColor: primary900,
        title: TextWidget(
          text: 'Bảng lương',
          color: white,
          textStyle: textStyle17Bold,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<HomeClientController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: ListView(
              children: [
                30.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: primary300,
                        border: Border.all(color: primary300),
                        boxShadow: [
                          BoxShadow(
                            color: black.withOpacity(0.1),
                            blurRadius: 10.0, // soften the shadow
                            spreadRadius: 0.0, //extend the shadow
                            offset: const Offset(
                              5.0, // Move to right 10  horizontally
                              5.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(
                          16.r,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                AppIcon.calendarMoney,
                                color: primary900,
                                scale: 3,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              TextWidget(
                                text: "Bảng lương tháng ${salary.mm}",
                                color: black,
                                textStyle: textStyle17Bold,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: white,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 10.h),
                              child: Column(
                                children: List.generate(
                                  salary.items.length - 1,
                                  (index) => buildItem(salary.items[index]),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: white,
                            child: Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 10.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget(
                                    text: 'Tổng thực nhận',
                                    color: primary900,
                                    textStyle: textStyle17SemiBold,
                                  ),
                                  TextWidget(
                                    text: "${salary.items.last.number}đ" ?? '',
                                    color: const Color(0xff00D08C),
                                    textStyle: textStyle32Bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // SubmitButton(
                //   onTap: () {},
                //   text: 'Phản hồi',
                //   isLoading: false,
                //   bgColor: Colors.red,
                //   border: 80,
                // ),
                60.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildItem(SalaryItem item) => Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xffEBE9F1)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextWidget(
                        text: item.name ?? '',
                        color: black,
                        textStyle: textStyle15Normal,
                      ),
                    ],
                  ),
                  if (item.subTitle != null) ...[
                    TextWidget(
                      text: item.subTitle ?? '',
                      color: black,
                      textStyle: textStyle10,
                    ),
                  ],
                ],
              ),
            ),
            16.horizontalSpace,
            TextWidget(
                text: item.number ?? '',
                color: item.type.getColor(),
                textStyle: textStyle15SemiBold),
          ],
        ),
      );
}
