// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/application_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/shared/enums/user_enum.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/enums/role_enum.dart';
import '../../../../utils/app_icon.dart';
import '../../../../utils/shared_prefs.dart';

class ApplicationItem extends StatefulWidget {
  final ApplicationModel item;
  final UserEnum userEnum;
  const ApplicationItem({
    Key? key,
    required this.item,
    required this.userEnum,
  }) : super(key: key);

  @override
  State<ApplicationItem> createState() => _ApplicationItemState();
}

class _ApplicationItemState extends State<ApplicationItem> {
  late final SharedPreferences _prefs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.pushNamed(AppRoute.applicationDetail.name,
            extra: {'item': widget.item, "userEnum": widget.userEnum}),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(16),
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
              ]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset(AppIcon.navIcon4, scale: 2),
                        8.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                maxLines: 1,
                                text: widget.item.type!.getTitle(),
                                color: black,
                                textStyle: textStyle14SemiBold,
                              ),
                              TextWidget(
                                text: SharedPrefs().role == RoleEnum.admin
                                    ? "Chủ đơn: ${widget.item.employee!.fullname}"
                                    : widget.item.approveName != null
                                        ? "Người duyệt: ${widget.item.approveName}"
                                        : "Ngày gửi: ${widget.item.createdAt!.formatDate}",
                                color: black,
                                textStyle: textStyle11SemiBold,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    width: 75.w,
                    decoration: BoxDecoration(
                        color: widget.item.status!.buildData().textColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextWidget(
                        text: widget.item.status!.buildData().text,
                        color: Colors.white,
                        textStyle:
                            textStyle12.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
