// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/shared/enums/role_enum.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:e_tmsc_app/data/models/timekeeping_model.dart';
import 'package:e_tmsc_app/presentation/screens/calendar/widgets/calendar_bottom_modal.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/shared/enums/day_enum.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';

class HomeContainer extends StatelessWidget {
  final DayEnum type;
  final List<TimeKeeping> days;
  final String? total;
  final bool disable;
  final String text;
  const HomeContainer({
    Key? key,
    required this.type,
    required this.days,
    this.total,
    this.disable = false,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => disable
          ? null
          : showPickerContainer(
              context,
              data: days,
              type: type,
            ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.1),
              blurRadius: 30,
              spreadRadius: 1,
              offset: const Offset(0, -1),
            )
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [
                  TextWidget(
                    text: total ?? days.length.toString(),
                    color: type.buildData().bgColor,
                    textStyle: textStyle38Bold,
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: TextWidget(
                      text: text,
                      color: neutral600,
                      textStyle: textStyle12,
                    ),
                  ),
                  Container(
                    height: 35.h,
                    width: 35.h,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: type.buildData().bgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(type.buildData().icon),
                  ),
                ],
              ),
            ),
            if (SharedPrefs().role == RoleEnum.client) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: 'Xem chi tiết',
                      color: neutral600,
                      textStyle: textStyle10,
                    ),
                    Image.asset(AppIcon.nextArrow, scale: 3),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
