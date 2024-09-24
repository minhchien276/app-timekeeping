// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/data/models/timekeeping_model.dart';
import 'package:e_tmsc_app/data/models/typeofwork_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/dialog/image_dialog.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeAdminAppbar extends StatelessWidget {
  final bool hasSrcolled;
  final EmployeeModel? employee;
  final TypeOfWork? typeOfWork;
  final TimeKeeping? timeKeeping;

  const HomeAdminAppbar({
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
      expandedHeight: 80.h + (58 - safeAreaHeight),
      collapsedHeight: 80.h + (58 - safeAreaHeight),
      backgroundColor: primary900,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          padding: EdgeInsets.only(top: 45.h, left: 24.w, right: 24.w),
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
                            size: Size(54.h, 54.h),
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
              22.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
