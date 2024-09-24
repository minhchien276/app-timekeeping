// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/data/models/timekeeping_model.dart';
import 'package:e_tmsc_app/data/models/typeofwork_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/dialog/image_dialog.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeClientAppbar extends StatelessWidget {
  final bool hasSrcolled;
  final EmployeeModel? employee;
  final TypeOfWork? typeOfWork;
  final TimeKeeping? timeKeeping;

  const HomeClientAppbar({
    Key? key,
    required this.hasSrcolled,
    this.employee,
    this.typeOfWork,
    this.timeKeeping,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double safeAreaHeight = MediaQuery.of(context).padding.top;
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 180.h + (58 - safeAreaHeight),
      backgroundColor: primary900,
      title: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: hasSrcolled ? 1.0 : 0.0,
        child: Padding(
          padding:
              EdgeInsets.only(left: 8.w, right: 8.w, top: 20.h, bottom: 20.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          showImageDialog(context, image: employee?.image),
                      child: networkImageWithCached(
                        size: Size(45.h, 45.h),
                        url: employee?.image,
                        borderRadius: 100,
                        boxBorder: Border.all(color: white, width: 2),
                      ),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: employee?.fullname ?? "",
                            color: white,
                            textStyle: textStyle17Bold,
                            maxLines: 1,
                          ),
                          TextWidget(
                            text: employee?.departmentName ?? "",
                            color: white,
                            textStyle: textStyle14SemiBold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => context.pushNamed(AppRoute.noti.name),
                icon: Image.asset(
                  AppIcon.notiIcon,
                  scale: 2.5,
                ),
              ),
            ],
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          padding: EdgeInsets.only(top: 40.h, left: 24.w, right: 24.w),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              showImageDialog(context, image: employee?.image),
                          child: networkImageWithCached(
                            size: Size(45.h, 45.h),
                            url: employee?.image,
                            borderRadius: 100,
                            boxBorder: Border.all(color: white, width: 2),
                          ),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(
                                text: employee?.fullname ?? "",
                                color: white,
                                textStyle: textStyle17Bold,
                                maxLines: 1,
                              ),
                              TextWidget(
                                text: employee?.departmentName ?? "",
                                color: white,
                                textStyle: textStyle14SemiBold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.pushNamed(AppRoute.noti.name),
                    icon: Image.asset(
                      AppIcon.notiIcon,
                      scale: 3,
                    ),
                  ),
                ],
              ),
              22.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: DateTime.now().formatWeekDayMonth,
                    color: white,
                    textStyle: textStyle15SemiBold,
                  ),
                  TextWidget(
                    text:
                        '${typeOfWork?.timeIn?.format(context) ?? ''} - ${typeOfWork?.timeOut?.format(context) ?? ''}'
                        '',
                    color: white,
                    textStyle: textStyle12SemiBold,
                  ),
                ],
              ),
              16.verticalSpace,
              const Divider(height: 0, color: white),
              16.verticalSpace,
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 21, vertical: 8),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        TextWidget(
                          text: 'GIỜ ĐẾN',
                          color: neutral600,
                          textStyle: textStyle10,
                        ),
                        TextWidget(
                          text: formatCheckTime(timeKeeping?.checkin?.checkin),
                          color: greenColor,
                          textStyle: textStyle17Bold,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(AppIcon.loginIcon,
                            scale: 3, color: primary900),
                        26.horizontalSpace,
                        TextWidget(
                          text: '--------',
                          color: black,
                          textStyle: textStyle17Bold,
                        ),
                        26.horizontalSpace,
                        Image.asset(AppIcon.logoutIcon,
                            scale: 3, color: primary900),
                      ],
                    ),
                    Column(
                      children: [
                        TextWidget(
                          text: 'GIỜ VỀ',
                          color: neutral600,
                          textStyle: textStyle10,
                        ),
                        TextWidget(
                          text:
                              formatCheckTime(timeKeeping?.checkout?.checkout),
                          color: Colors.red,
                          textStyle: textStyle17Bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
