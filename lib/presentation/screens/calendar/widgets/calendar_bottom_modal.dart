import 'dart:ui';

import 'package:e_tmsc_app/data/models/overtime_model.dart';
import 'package:e_tmsc_app/data/models/timekeeping_model.dart';
import 'package:e_tmsc_app/data/models/typeofwork_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/shared/enums/day_enum.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showPickerDay(
  BuildContext context, {
  required DateTime date,
  required TimeKeeping? timeKeeping,
  required TypeOfWork? typeOfWork,
}) {
  showModalBottomSheet(
    useRootNavigator: true,
    elevation: 0,
    backgroundColor: Colors.white.withOpacity(0),
    barrierColor: Colors.black.withOpacity(0.8),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    context: context,
    builder: (context) {
      return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              height: 50.h,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Center(
                child: TextWidget(
                  text: date.formatWeekDayMonth,
                  color: white,
                  textStyle: textStyle16Bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 25.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TextWidget(
                        text: 'Check In',
                        color: black,
                        textStyle: textStyle12,
                      ),
                      TextWidget(
                        text: formatHours(timeKeeping?.checkin?.checkin),
                        color: black,
                        textStyle: textStyle15SemiBold,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: primary900,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              AppIcon.loginIcon,
                              scale: 4,
                              color: white,
                            ),
                          ),
                          4.horizontalSpace,
                          TextWidget(
                            text: '------',
                            color: neutral600,
                            textStyle: textStyle15SemiBold,
                          ),
                          4.horizontalSpace,
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: primary900,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              AppIcon.workOutline,
                              scale: 4,
                              color: white,
                            ),
                          ),
                          4.horizontalSpace,
                          TextWidget(
                            text: '------',
                            color: neutral600,
                            textStyle: textStyle15SemiBold,
                          ),
                          4.horizontalSpace,
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: primary900,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              AppIcon.logoutIcon,
                              scale: 4,
                              color: white,
                            ),
                          ),
                        ],
                      ),
                      4.verticalSpace,
                      TextWidget(
                        text: CalendarHandler.buildPickerData(
                            timeKeeping, typeOfWork)[0],
                        color: black,
                        textStyle: textStyle12,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TextWidget(
                        text: 'Check Out',
                        color: black,
                        textStyle: textStyle12,
                      ),
                      TextWidget(
                        text: formatHours(timeKeeping?.checkout?.checkout),
                        color: black,
                        textStyle: textStyle15SemiBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: neutral200),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Tổng giờ hành chính:',
                        color: neutral600,
                        textStyle: textStyle15SemiBold,
                      ),
                      TextWidget(
                        text: CalendarHandler.buildPickerData(
                            timeKeeping, typeOfWork)[1],
                        color: black,
                        textStyle: textStyle15SemiBold,
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Đi muộn: ',
                        color: neutral600,
                        textStyle: textStyle15SemiBold,
                      ),
                      TextWidget(
                        text: CalendarHandler.buildPickerData(
                            timeKeeping, typeOfWork)[2],
                        color: black,
                        textStyle: textStyle15SemiBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            40.verticalSpace,
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 25.w),
            //   child: SubmitButton(
            //     onTap: () {
            //       context.pop();
            //       context.pushNamed(AppRoute.feedbackSubmit.path);
            //     },
            //     text: 'Ý KIẾN PHẢN HỒI',
            //     isLoading: false,
            //     size: Size(390.w, 40.h),
            //     bgColor: Colors.green,
            //   ),
            // ),
            // 40.verticalSpace,
          ],
        ),
      );
    },
    isScrollControlled: true,
  );
}

showCalendarOTPicker(
  BuildContext context,
  DateTime datePicker,
  OvertimeModel? overtimeModel,
) {
  showModalBottomSheet(
    elevation: 0,
    useRootNavigator: true,
    backgroundColor: Colors.white.withOpacity(0),
    barrierColor: Colors.black.withOpacity(0.4),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    context: context,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              width: double.infinity,
              height: 50.h,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Center(
                child: TextWidget(
                  text: datePicker.formatWeekDayMonth,
                  color: white,
                  textStyle: textStyle16Bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 25.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TextWidget(
                        text: 'Bắt đầu',
                        color: black,
                        textStyle: textStyle12,
                      ),
                      2.verticalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: TextWidget(
                          text: formatHours(overtimeModel?.startTime),
                          color: Colors.green,
                          textStyle: textStyle15SemiBold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: primary900,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              AppIcon.loginIcon,
                              scale: 4,
                              color: white,
                            ),
                          ),
                          4.horizontalSpace,
                          TextWidget(
                            text: '------',
                            color: neutral600,
                            textStyle: textStyle15SemiBold,
                          ),
                          4.horizontalSpace,
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: primary900,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              AppIcon.workOutline,
                              scale: 4,
                              color: white,
                            ),
                          ),
                          4.horizontalSpace,
                          TextWidget(
                            text: '------',
                            color: neutral600,
                            textStyle: textStyle15SemiBold,
                          ),
                          4.horizontalSpace,
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: primary900,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              AppIcon.logoutIcon,
                              scale: 4,
                              color: white,
                            ),
                          ),
                        ],
                      ),
                      4.verticalSpace,
                      TextWidget(
                        text: totalTimeTextByDate(
                          overtimeModel?.startTime,
                          overtimeModel?.endTime,
                        ),
                        color: black,
                        textStyle: textStyle12,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TextWidget(
                        text: 'Kết thúc',
                        color: black,
                        textStyle: textStyle12,
                      ),
                      2.verticalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: TextWidget(
                          text: formatHours(overtimeModel?.endTime),
                          color: Colors.green,
                          textStyle: textStyle15SemiBold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: neutral200),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Tổng giờ tăng ca:',
                        color: neutral600,
                        textStyle: textStyle15SemiBold,
                      ),
                      TextWidget(
                        text: overtimeModel != null
                            ? '${overtimeModel.hours}h'
                            : "0h",
                        color: black,
                        textStyle: textStyle15SemiBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            40.verticalSpace,
          ],
        ),
      );
    },
    isScrollControlled: true,
  );
}

showPickerContainer(
  BuildContext context, {
  required List<TimeKeeping> data,
  required DayEnum type,
}) {
  showModalBottomSheet(
    elevation: 0,
    useRootNavigator: true,
    backgroundColor: Colors.white.withOpacity(0),
    barrierColor: Colors.black.withOpacity(0.8),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    context: context,
    builder: (context) {
      if (data.isEmpty) {
        return Container(
          decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          height: 600.h,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 70.w),
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: type.buildData().bgColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: TextWidget(
                    text: type.buildData().text,
                    color: white,
                    textStyle: textStyle15SemiBold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 100.h),
                child: Column(
                  children: [
                    Image.asset(AppIcon.iconNotItem),
                    const TextWidget(
                      text: "Không có dữ liệu",
                      color: black,
                      fontWeight: FontWeight.w500,
                      size: 16,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return Container(
          decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          height: 600.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 70.w),
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: type.buildData().bgColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: TextWidget(
                    text: type.buildData().text,
                    color: white,
                    textStyle: textStyle15SemiBold,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 25.h,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextWidget(
                              text: 'Ngày',
                              color: black,
                              textStyle: textStyle14SemiBold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: TextWidget(
                              text: 'Check In',
                              color: black,
                              textStyle: textStyle14SemiBold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: TextWidget(
                              text: 'Check Out',
                              color: black,
                              textStyle: textStyle14SemiBold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: grey400),
                      Expanded(
                        child: ListView.builder(
                          primary: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return buildCheckInOutItem(data[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    },
    isScrollControlled: true,
  );
}

Widget buildCheckInOutItem(TimeKeeping timeKeeping) => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextWidget(
                text: timeKeeping.date!.formatDate,
                color: black,
                textStyle: textStyle12,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: TextWidget(
                text: formatHours(timeKeeping.checkin?.checkin),
                color: black,
                textStyle: textStyle12,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: TextWidget(
                text: formatHours(timeKeeping.checkout?.checkout),
                color: black,
                textStyle: textStyle12,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const Divider(color: grey400),
      ],
    );

// hiển thị hướng dẫn trong phần lịch
Future<void> showGuideCalendar(BuildContext context) {
  return showDialog<void>(
    barrierColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: AlertDialog(
          elevation: 0,
          contentPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          content: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.transparent),
              boxShadow: const [
                BoxShadow(
                  color: grey100,
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 40, width: 40),
                      TextWidget(
                        text: 'Chú thích lịch',
                        color: neutral700,
                        textStyle: textStyle17Bold,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Image.asset(AppIcon.close, scale: 3),
                      ),
                    ],
                  ),
                ),
                const Divider(color: grey200, height: 0),
                Column(
                  children: List.generate(
                    DayEnum.values.length - 1,
                    (index) => noteItem(DayEnum.values[index]),
                  ),
                ),
                10.verticalSpace,
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget noteItem(DayEnum dayEnum) => Container(
      padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 10.h),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 30.h,
            width: 30.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: dayEnum.buildData().bgColor,
              border: Border.all(color: dayEnum.buildData().borderColor),
            ),
            child: Center(
              child: TextWidget(
                text: '1',
                color: dayEnum.buildData().textColor,
                textStyle: textStyle16Bold,
              ),
            ),
          ),
          20.horizontalSpace,
          TextWidget(
            text: dayEnum.buildData().text,
            color: neutral700,
            textStyle: textStyle16Bold,
          ),
        ],
      ),
    );
