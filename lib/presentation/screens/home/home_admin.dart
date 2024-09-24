// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/logic/controllers/home/home_admin_controller.dart';
import 'package:e_tmsc_app/presentation/screens/home/post/post_home.dart';
import 'package:e_tmsc_app/presentation/screens/home/widgets/home_admin_appbar.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/dialog/new_employee_dialog.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/app_icon.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  late ScrollController _scrollController;
  final HomeAdminController homeAdminController = Get.find();
  bool hasScrolled = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      homeAdminController.refreshHome(context);
    });
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          hasScrolled = _scrollController.hasClients &&
              _scrollController.offset > (100 - kToolbarHeight);
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeAdminController>(
      builder: (controller) {
        return NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, index) {
            return [
              HomeAdminAppbar(
                hasSrcolled: hasScrolled,
                employee: controller.employee,
                typeOfWork: controller.typeOfWork,
                timeKeeping: controller.timeKeeping,
              ),
            ];
          },
          body: ListView(
            children: [
              if (controller.employee?.isBirthday == true) ...[
                Lottie.asset('assets/animations/happy_birthday2.json',
                    height: 200.h),
              ],
              if (controller.employeeOnboard.isNotEmpty) ...[
                // 20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Chào mừng thành viên mới',
                        color: black,
                        textStyle: textStyle15ExtraBold,
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(left: 24.w),
                  child: SizedBox(
                    height: 80.h,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: controller.employeeOnboard.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final e = controller.employeeOnboard[index];
                        return InkWell(
                          onTap: () => showNewEmployeeDialog(context,
                              e: controller.employeeOnboard[index]),
                          child: SizedBox(
                            height: 65.h,
                            width: 120.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                networkImageWithCached(
                                  size: Size(40.h, 40.h),
                                  url: e.image,
                                  borderRadius: 100,
                                  boxBorder:
                                      Border.all(color: primary900, width: 1),
                                ),
                                6.verticalSpace,
                                Expanded(
                                  child: TextWidget(
                                    text: e.fullname ?? '',
                                    color: black,
                                    textStyle: textStyle10,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ] else
                ...[],
              if (controller.employeeBirthday.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Hôm nay là sinh nhật của',
                        color: black,
                        textStyle: textStyle15ExtraBold,
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(left: 24.w),
                  child: SizedBox(
                    height: 80.h,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: controller.employeeBirthday.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final e = controller.employeeBirthday[index];
                        return InkWell(
                          onTap: () => showBirthdayDialog(context,
                              e: controller.employeeBirthday[index]),
                          child: SizedBox(
                            height: 65.h,
                            width: 120.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                networkImageWithCached(
                                  size: Size(40.h, 40.h),
                                  url: e.image,
                                  borderRadius: 100,
                                  boxBorder:
                                      Border.all(color: primary900, width: 1),
                                ),
                                6.verticalSpace,
                                Expanded(
                                  child: TextWidget(
                                    text: e.fullname ?? '',
                                    color: black,
                                    textStyle: textStyle10,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: 'Tin tức hàng ngày',
                      color: black,
                      textStyle: textStyle15ExtraBold,
                    ),
                    InkWell(
                      onTap: () => context.pushNamed(
                        AppRoute.post.name,
                        extra: controller.blog,
                      ),
                      child: TextWidget(
                        text: 'Xem thêm',
                        color: primary900,
                        textStyle: textStyle12SemiBold,
                      ),
                    ),
                  ],
                ),
              ),
              24.verticalSpace,
              if (controller.blog.isNotEmpty) ...[
                SizedBox(
                  height: 230.h,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: controller.blog.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return PostHome(
                        isFirst: index == 0,
                        blog: controller.blog[index],
                      );
                    },
                  ),
                ),
                24.verticalSpace,
              ] else ...[
                const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    backgroundColor: primary900,
                    strokeWidth: 5,
                  ),
                ),
                20.verticalSpace,
              ],
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: TextWidget(
                  text: 'Tổng quan nhân sự',
                  color: black,
                  textStyle: textStyle15SemiBold,
                ),
              ),
              12.verticalSpace,
              GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoute.listEmployeeOnline.name);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: green,
                      boxShadow: [
                        BoxShadow(
                          color: green.withOpacity(0.6),
                          blurRadius: 10.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                          offset: const Offset(
                            3.0, // Move to right 10  horizontally
                            3.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ]),
                  child: ListTile(
                    horizontalTitleGap: 10.w,
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 60.w,
                          child: Center(
                            child: Text(
                              "${controller.totalEmployeeOnline}",
                              style:
                                  textStyle26Bold.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          height: 35.w,
                          child: const VerticalDivider(
                            color: white,
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      "Nhân viên đi làm",
                      style: textStyle14Bold.copyWith(color: Colors.white),
                    ),
                    subtitle: Text(
                      "Xem thêm",
                      style: textStyle11.copyWith(color: Colors.white),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.w),
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        AppIcon.timekeepingSuccess,
                        color: green,
                        scale: 3,
                      ),
                    ),
                  ),
                ),
              ),
              16.verticalSpace,
              GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoute.listEmployeeOff.name);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: redBold,
                  ),
                  child: ListTile(
                      horizontalTitleGap: 10.w,
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 60.w,
                            child: Center(
                              child: Text(
                                "${controller.totalEmployeeDayoff}",
                                style: textStyle26Bold.copyWith(
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            height: 35.w,
                            child: const VerticalDivider(
                              color: white,
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        "Nhân viên nghỉ phép",
                        style: textStyle14Bold.copyWith(color: Colors.white),
                      ),
                      subtitle: Text(
                        "Xem thêm",
                        style: textStyle11.copyWith(color: Colors.white),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.w),
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          AppIcon.goLate,
                          color: redBold,
                          scale: 3,
                        ),
                      )),
                ),
              ),
              16.verticalSpace,
              GestureDetector(
                onTap: () async {
                  context.pushNamed(AppRoute.listApplicationPending.name);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: blue,
                  ),
                  child: ListTile(
                    horizontalTitleGap: 10.w,
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 60.w,
                          child: Center(
                            child: Text(
                              "${controller.pendingCount}",
                              style:
                                  textStyle26Bold.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          height: 35.w,
                          child: const VerticalDivider(
                            color: white,
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      "Đơn cần duyệt",
                      style: textStyle14Bold.copyWith(color: Colors.white),
                    ),
                    subtitle: Text(
                      "Xem thêm",
                      style: textStyle11.copyWith(color: Colors.white),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.w),
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        AppIcon.dayoff,
                        color: blue,
                        scale: 3,
                      ),
                    ),
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
