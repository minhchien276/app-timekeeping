import 'package:e_tmsc_app/logic/controllers/home/home_admin_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/dialog/image_dialog.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ProfileAdmin extends StatefulWidget {
  const ProfileAdmin({super.key});

  @override
  State<ProfileAdmin> createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary900,
      appBar: AppBar(
        backgroundColor: primary900,
        centerTitle: true,
        title: TextWidget(
          text: 'Menu',
          color: white,
          textStyle: textStyle17Bold,
        ),
      ),
      body: GetBuilder<HomeAdminController>(
        builder: (controller) {
          return ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () => showImageDialog(context,
                        image: controller.employee?.image),
                    child: networkImageWithCached(
                      size: Size(120.h, 120.h),
                      url: controller.employee?.image,
                      borderRadius: 100,
                      boxBorder: Border.all(
                        color: white,
                        width: 2,
                      ),
                    ),
                  ),
                ],
              ),
              18.verticalSpace,
              TextWidget(
                text:
                    '${controller.employee?.fullname ?? ''} - ${controller.employee?.departmentName ?? ''}',
                color: white,
                textStyle: textStyle22Bold,
                textAlign: TextAlign.center,
              ),
              TextWidget(
                text: controller.employee?.email ?? '',
                color: white,
                textStyle: textStyle15SemiBold,
                textAlign: TextAlign.center,
              ),
              30.verticalSpace,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  children: [
                    // buildItem(
                    //   title: 'Bảng lương của bạn',
                    //   subtitle: 'Xem chi tiết các bảng lương của bạn',
                    //   icon: AppIcon.calendarMoney,
                    //   onTap: () => context.pushNamed(AppRoute.salary.name),
                    // ),
                    // const Divider(height: 0, thickness: 1),
                    buildItem(
                      title: 'Danh sách nhân viên',
                      subtitle: 'Xem chi tiết danh sách nhân viên',
                      icon: AppIcon.profile,
                      onTap: () =>
                          context.pushNamed(AppRoute.profileEmployee.name),
                    ),
                    const Divider(height: 0, thickness: 1),
                    // buildItem(7
                    //   title: 'Book lịch phòng họp',
                    //   subtitle: 'Chọn thời gian họp Team',
                    //   icon: AppIcon.calendarStar,
                    //   onTap: () {},
                    // ),
                    // const Divider(height: 0, thickness: 1),
                    buildItem(
                      title: 'Tin tức hàng tháng',
                      subtitle: 'Tin tức cập nhật khi có sự kiện',
                      icon: AppIcon.news,
                      onTap: () => context.pushNamed(AppRoute.post.name,
                          extra: controller.blog),
                    ),
                    const Divider(height: 0, thickness: 1),
                    buildItem(
                      title: 'Quy trình quy định',
                      subtitle: 'Quy trình quy định của công ty',
                      icon: AppIcon.news,
                      onTap: () => context.pushNamed(
                        AppRoute.profileRule.name,
                      ),
                    ),
                    const Divider(height: 0, thickness: 1),
                    buildItem(
                      title: 'Kiểm tra kiến thức chuyên môn',
                      subtitle: 'Các team làm bài kiểm tra theo lịch',
                      icon: AppIcon.news,
                      onTap: () => context.pushNamed(
                        AppRoute.testAdminExams.name,
                      ),
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              // if (controller.employee?.hasLogout == false) ...[
              //   Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 24.w),
              //     child: ElevatedButton(
              //       onPressed: () {
              //         SharedPrefs().logout();
              //         context.goNamed(AppRoute.login.name);
              //       },
              //       style: ButtonStyle(
              //         backgroundColor: const WidgetStatePropertyAll(white),
              //         shape: WidgetStatePropertyAll(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(100.r),
              //           ),
              //         ),
              //         shadowColor: const WidgetStatePropertyAll(white),
              //         foregroundColor: const WidgetStatePropertyAll(white),
              //         surfaceTintColor: const WidgetStatePropertyAll(white),
              //         elevation: const WidgetStatePropertyAll(0),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           Image.asset(AppIcon.logoutIcon,
              //               scale: 3, color: primary900),
              //           8.horizontalSpace,
              //           TextWidget(
              //             text: 'Đăng xuất',
              //             color: primary900,
              //             textStyle: textStyle14SemiBold,
              //           ),
              //         ],
              //       ),
              //     ),
              //   )
              // ],
            ],
          );
        },
      ),
    );
  }

  Widget buildItem({
    required String title,
    required String subtitle,
    required String icon,
    required VoidCallback onTap,
  }) =>
      InkWell(
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: Image.asset(icon,
                        color: primary900, fit: BoxFit.contain),
                  ),
                  16.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: title,
                        color: black,
                        textStyle: textStyle15SemiBold,
                      ),
                      TextWidget(
                        text: subtitle,
                        color: black,
                        textStyle: textStyle10,
                      ),
                    ],
                  ),
                ],
              ),
              Image.asset(AppIcon.next, scale: 3),
            ],
          ),
        ),
      );
}
