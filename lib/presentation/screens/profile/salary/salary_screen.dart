import 'package:e_tmsc_app/data/models/salary_model.dart';
import 'package:e_tmsc_app/logic/controllers/home/home_client_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/presentation/widgets/loading/loading_circle.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SalaryScreen extends StatefulWidget {
  const SalaryScreen({super.key});

  @override
  State<SalaryScreen> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final HomeClientController controller = Get.find();
      controller.fetchSalary();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        leading: const KBackButton(),
        backgroundColor: primary900,
        centerTitle: true,
        title: TextWidget(
          text: 'Bảng lương',
          color: white,
          textStyle: textStyle17Bold,
        ),
      ),
      body: GetBuilder<HomeClientController>(
        builder: (controller) {
          return controller.isLoading
              ? const Center(child: LoadingCircle(color: primary900))
              : controller.salary.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppIcon.iconNotSalary,
                          scale: 1.2,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "BẢNG LƯƠNG CỦA BẠN TRỐNG!!!",
                              style: TextStyle(
                                color: black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DVNPoppins',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 30.h),
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: controller.salary.length,
                        itemBuilder: (context, index) {
                          return buildSalaryItem(
                            context,
                            controller.salary[index],
                            index == 0,
                          );
                        },
                      ),
                    );
        },
      ),
    );
  }

  Widget buildSalaryItem(
    BuildContext context,
    SalaryModel salary,
    bool isCurrent,
  ) =>
      IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            onTap: () =>
                context.pushNamed(AppRoute.salaryDetail.name, extra: salary),
            child: Ink(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: black.withOpacity(0.05)),
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
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AppIcon.calendarMoney,
                        color: primary900,
                        scale: 3,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text:
                                'Bảng lương tháng ${salary.mm} ${isCurrent ? '*' : ''}',
                            color: primary900,
                            textStyle: textStyle15SemiBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.black,
                  ),
                  0.verticalSpace,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                text: 'Kỳ lương',
                                color: black,
                                textStyle: textStyle15SemiBold,
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          TextWidget(
                            text: 'Tháng ${salary.mm}/${salary.yyyy}',
                            color: black,
                            textStyle: textStyle15SemiBold,
                          ),
                        ],
                      ),
                      6.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                text: 'Ngày tính công',
                                color: black,
                                textStyle: textStyle15SemiBold,
                              ),
                            ],
                          ),
                          TextWidget(
                            text: salary.range,
                            color: black,
                            textStyle: textStyle15SemiBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
