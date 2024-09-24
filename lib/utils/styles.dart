import 'package:e_tmsc_app/utils/app_string.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

final textStyle38Bold = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontWeight: FontWeight.bold,
  letterSpacing: -2,
  fontSize: 38.sp,
);

final textStyle32Bold = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 32.sp,
);

final textStyle26Bold = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 26.sp,
);

final textStyle24Bold = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 24.sp,
);

final textStyle22Bold = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 22.sp,
);

final textStyle20Bold = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 20.sp,
);

final textStyle17Bold = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 17.sp,
);

final textStyle17 = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontWeight: FontWeight.w500,
  fontSize: 17.sp,
);

final textStyle17SemiBold = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 17.sp);

final textStyle16Bold = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 16.sp,
);

final textStyle16SemiBold = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontWeight: FontWeight.w600,
  fontSize: 16.sp,
);

final textStyle15ExtraBold = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 15.sp);

final textStyle15Bold = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 15.sp,
    fontWeight: FontWeight.w600);

final textStyle15SemiBold = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontWeight: FontWeight.w600,
  fontSize: 15.sp,
);

final textStyle15Normal = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontWeight: FontWeight.w500,
  fontSize: 15.sp,
);

final textStyle15SemiBoldGray = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 15.sp,
    color: greyBold);

final textStyle14Bold = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 14.sp,
);

final textStyle14SemiBold = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontWeight: FontWeight.w500,
  fontSize: 14.sp,
);

final textStyle14Normal = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp);

final textStyle14 =
    TextStyle(fontFamily: AppStrings.fontFamily, fontSize: 14.sp);

final textStyle13SemiBold = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppStrings.fontFamily,
    fontSize: 13.sp);

final textStyle13 =
    TextStyle(fontFamily: AppStrings.fontFamily, fontSize: 13.sp);

final textStyle12SemiBold = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontWeight: FontWeight.w600,
  fontSize: 12.sp,
);

final textStyle12 = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontSize: 12.sp,
);

final textStyle11 = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontSize: 11.sp,
);

final textStyle11Bold = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.w700);

final textStyle11SemiBold = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.w600);

final textStyle10SemiBold = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 10.sp,
    fontWeight: FontWeight.w600);

final textStyle10 = TextStyle(
  fontFamily: AppStrings.fontFamily,
  fontSize: 10.sp,
);

final tableHeaderStyle = HeaderStyle(
  titleTextFormatter: (date, _) => 'Tháng ${date.month}',
  formatButtonVisible: false,
  titleCentered: true,
  headerPadding: EdgeInsets.symmetric(vertical: 12.h),
  headerMargin: EdgeInsets.symmetric(horizontal: 17.w),
  decoration: const BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(14),
      topRight: Radius.circular(14),
    ),
    border: Border(
      bottom: BorderSide(color: Color(0xffBDBDBD)),
    ),
  ),
  leftChevronIcon: Container(
    decoration: BoxDecoration(
      color: primary200,
      borderRadius: BorderRadius.circular(4),
    ),
    child: const Icon(
      Icons.keyboard_arrow_left,
      color: primary900,
    ),
  ),
  rightChevronIcon: Container(
    decoration: BoxDecoration(
      color: primary200,
      borderRadius: BorderRadius.circular(4),
    ),
    child: const Icon(
      Icons.keyboard_arrow_right,
      color: primary900,
    ),
  ),
  rightChevronPadding: const EdgeInsets.only(right: 50),
  leftChevronPadding: const EdgeInsets.only(left: 50),
  titleTextStyle: textStyle17Bold,
);

final calendarStyle = CalendarStyle(
  tablePadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
  defaultTextStyle: textStyle14SemiBold,
  rowDecoration: const BoxDecoration(
    color: white,
  ),
  weekendTextStyle: textStyle14SemiBold.copyWith(color: primary900),
  todayDecoration: const BoxDecoration(
    color: Colors.transparent,
    shape: BoxShape.circle,
  ),
);
