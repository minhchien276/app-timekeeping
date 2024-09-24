import 'package:e_tmsc_app/logic/controllers/application/application_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_submit_button.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

showTypeDayOff(BuildContext context) {
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
      return GetBuilder<ApplicationController>(
        builder: (controller) {
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
                  padding: EdgeInsets.symmetric(horizontal: 70.w),
                  height: 50.h,
                  decoration: const BoxDecoration(
                    color: primary900,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: TextWidget(
                      text: 'Vui lòng chọn loại đơn',
                      color: white,
                      textStyle: textStyle15SemiBold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 25.h,
                  ),
                  child: Column(
                    children: List.generate(
                      controller.typeDayOff.length,
                      (index) => InkWell(
                        onTap: () {
                          controller.selectTypeApplication(context, index);
                        },
                        child: selectedItem(
                          context: context,
                          title: controller.typeDayOff[index].title,
                          subTitle: controller.typeDayOff[index].subTitle,
                          isSelected: controller.typeDayOff[index].isChecked,
                          controller: controller,
                          index: index,
                          type: 1,
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
    },
    isScrollControlled: true,
  );
}

showReceivers(BuildContext context) {
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
      return GetBuilder<ApplicationController>(
        builder: (controller) {
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
                  padding: EdgeInsets.symmetric(horizontal: 70.w),
                  height: 50.h,
                  decoration: const BoxDecoration(
                    color: primary900,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: TextWidget(
                      text: 'Chọn người để gửi đơn',
                      color: white,
                      textStyle: textStyle15SemiBold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 400.h,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 25.h,
                    ),
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: controller.selectReceiver.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            controller.addReceiver(index);
                          },
                          child: selectedReceiver(
                            index: index,
                            title: controller
                                .selectReceiver[index].employee.fullname!,
                            subTitle: controller
                                .selectReceiver[index].employee.roleName!,
                            isSelected:
                                controller.selectReceiver[index].hasSelect,
                            controller: controller,
                            image:
                                controller.selectReceiver[index].employee.image,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
    isScrollControlled: true,
  );
}

showReason(BuildContext context) {
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
        return GetBuilder<ApplicationController>(builder: (controller) {
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
                  padding: EdgeInsets.symmetric(horizontal: 70.w),
                  height: 50.h,
                  decoration: const BoxDecoration(
                    color: primary900,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: TextWidget(
                      text: 'Vui lòng chọn lý do nghỉ phép',
                      color: white,
                      textStyle: textStyle15SemiBold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 400.h,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 25.h,
                    ),
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: controller.selectedReason.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            controller.addReason(index);
                          },
                          child: selectedReason(
                            index: index,
                            title:
                                controller.selectedReason[index].reason.title,
                            subTitle: controller
                                .selectedReason[index].reason.subTitle,
                            isSelected: controller
                                .selectedReason[index].reason.isChecked,
                            controller: controller,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      });
}

showDayoffPicker(
  BuildContext context,
  DateTime datePicker,
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
        child: GetBuilder<ApplicationController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 70.w),
                  height: 50.h,
                  decoration: const BoxDecoration(
                    color: primary900,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: TextWidget(
                      text: 'Vui lòng chọn loại nghỉ phép',
                      color: white,
                      textStyle: textStyle15SemiBold,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 25.h,
                    ),
                    child: Column(
                      children: List.generate(
                        controller.typeSessionDayOff.length,
                        (index) => InkWell(
                          onTap: () {
                            controller.selectSessionType(datePicker, index);
                          },
                          child: selectedItem(
                            context: context,
                            title: controller.typeSessionDayOff[index].title,
                            subTitle:
                                controller.typeSessionDayOff[index].subTitle,
                            isSelected:
                                controller.typeSessionDayOff[index].isChecked,
                            controller: controller,
                            index: index,
                            datePicker: datePicker,
                            type: 2,
                          ),
                        ),
                      ),
                    )),
              ],
            );
          },
        ),
      );
    },
    isScrollControlled: true,
  );
}

showOvertimePicker(
  BuildContext context,
  DateTime datePicker,
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
        child: GetBuilder<ApplicationController>(
          builder: (controller) {
            return Column(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Huỷ',
                        color: Colors.transparent,
                        textStyle: textStyle16Bold,
                      ),
                      TextWidget(
                        text: datePicker.formatWeekDayMonth,
                        color: white,
                        textStyle: textStyle16Bold,
                      ),
                      InkWell(
                        onTap: () =>
                            controller.removeOvertime(context, datePicker),
                        child: TextWidget(
                          text: 'Huỷ',
                          color: white,
                          textStyle: textStyle16Bold,
                        ),
                      ),
                    ],
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
                          InkWell(
                            onTap: () async {
                              TimeOfDay? begin = await buildCupertinoTimePicker(
                                context,
                                DateTime(
                                  datePicker.year,
                                  datePicker.month,
                                  datePicker.day,
                                  controller.timeBegin?.hour ?? 0,
                                  controller.timeBegin?.minute ?? 0,
                                ),
                                controller.timeEnd,
                                true,
                              );
                              controller.onChangeOvertime(begin, null);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.h),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: TextWidget(
                                text: controller.timeBeginText,
                                color: Colors.green,
                                textStyle: textStyle15SemiBold,
                              ),
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
                            text: controller.timeTotalText,
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
                          InkWell(
                            onTap: () async {
                              TimeOfDay? end = await buildCupertinoTimePicker(
                                context,
                                DateTime(
                                  datePicker.year,
                                  datePicker.month,
                                  datePicker.day,
                                  controller.timeEnd?.hour ?? 0,
                                  controller.timeEnd?.minute ?? 0,
                                ),
                                controller.timeBegin,
                                false,
                              );
                              controller.onChangeOvertime(null, end);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.h),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: TextWidget(
                                text: controller.timeEndText,
                                color: Colors.green,
                                textStyle: textStyle15SemiBold,
                              ),
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
                            text: controller.timeTotal,
                            color: black,
                            textStyle: textStyle15SemiBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                40.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: SubmitButton(
                    onTap: () => controller.timeBegin != null &&
                            controller.timeEnd != null
                        ? controller.addOvertime(context, datePicker)
                        : null,
                    text: 'XÁC NHẬN',
                    isLoading: false,
                    size: Size(390.w, 40.h),
                    bgColor: controller.timeBegin != null &&
                            controller.timeEnd != null
                        ? Colors.green
                        : neutral400,
                  ),
                ),
                40.verticalSpace,
              ],
            );
          },
        ),
      );
    },
    isScrollControlled: true,
  );
}

showGoLatePicker(
  BuildContext context,
  DateTime datePicker,
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
        child: GetBuilder<ApplicationController>(
          builder: (controller) {
            return Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    height: 50.h,
                    decoration: const BoxDecoration(
                      color: primary900,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: 'Huỷ',
                          color: Colors.transparent,
                          textStyle: textStyle16Bold,
                        ),
                        TextWidget(
                          text: datePicker.formatWeekDayMonth,
                          color: white,
                          textStyle: textStyle16Bold,
                        ),
                        InkWell(
                          onTap: () =>
                              controller.removeLate(context, datePicker),
                          child: TextWidget(
                            text: 'Huỷ',
                            color: white,
                            textStyle: textStyle16Bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: 'Giờ vào làm việc:',
                              color: neutral600,
                              textStyle: textStyle15SemiBold,
                            ),
                            InkWell(
                              onTap: () async {
                                TimeOfDay? time = await buildLateSoonTimePicker(
                                  context,
                                  DateTime(
                                    datePicker.year,
                                    datePicker.month,
                                    datePicker.day,
                                    controller.timeLate?.hour ?? 9,
                                    controller.timeLate?.minute ?? 0,
                                  ),
                                  const TimeOfDay(hour: 9, minute: 0),
                                  const TimeOfDay(hour: 10, minute: 0),
                                );
                                controller.onChangeLate(time);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6.h),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: TextWidget(
                                  text: controller.timeLateText,
                                  color: Colors.green,
                                  textStyle: textStyle15SemiBold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: SubmitButton(
                      onTap: () => controller.timeLate != null
                          ? controller.addLate(context, datePicker)
                          : null,
                      text: 'XÁC NHẬN',
                      isLoading: false,
                      size: Size(390.w, 40.h),
                      bgColor:
                          controller.timeLate != null ? primary900 : neutral400,
                    ),
                  ),
                  40.verticalSpace,
                ],
              ),
            );
          },
        ),
      );
    },
    isScrollControlled: true,
  );
}

showBackSoonPicker(
  BuildContext context,
  DateTime datePicker,
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
        child: GetBuilder<ApplicationController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  height: 50.h,
                  decoration: const BoxDecoration(
                    color: primary900,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Huỷ',
                        color: Colors.transparent,
                        textStyle: textStyle16Bold,
                      ),
                      TextWidget(
                        text: datePicker.formatWeekDayMonth,
                        color: white,
                        textStyle: textStyle16Bold,
                      ),
                      InkWell(
                        onTap: () => controller.removeSoon(context, datePicker),
                        child: TextWidget(
                          text: 'Huỷ',
                          color: white,
                          textStyle: textStyle16Bold,
                        ),
                      ),
                    ],
                  ),
                ),
                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: 'Giờ về sớm:',
                            color: neutral600,
                            textStyle: textStyle15SemiBold,
                          ),
                          InkWell(
                            onTap: () async {
                              TimeOfDay? time = await buildLateSoonTimePicker(
                                context,
                                DateTime(
                                  datePicker.year,
                                  datePicker.month,
                                  datePicker.day,
                                  controller.timeSoon?.hour ?? 16,
                                  controller.timeSoon?.minute ?? 30,
                                ),
                                const TimeOfDay(hour: 16, minute: 30),
                                const TimeOfDay(hour: 17, minute: 30),
                              );
                              controller.onChangeSoon(time);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.h),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: TextWidget(
                                text: controller.timeSoonText,
                                color: Colors.green,
                                textStyle: textStyle15SemiBold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: SubmitButton(
                    onTap: () => controller.timeSoon != null
                        ? controller.addSoon(context, datePicker)
                        : null,
                    text: 'XÁC NHẬN',
                    isLoading: false,
                    size: Size(390.w, 40.h),
                    bgColor:
                        controller.timeSoon != null ? primary900 : neutral400,
                  ),
                ),
                40.verticalSpace,
              ],
            );
          },
        ),
      );
    },
    isScrollControlled: true,
  );
}

Widget selectedItem({
  required BuildContext context,
  required String title,
  required String subTitle,
  required bool isSelected,
  required ApplicationController controller,
  required int index,
  required int type,
  DateTime? datePicker,
}) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.h),
                    height: 48.h,
                    width: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: isSelected ? primary900 : grey300,
                    ),
                    child: Image.asset(AppIcon.navIcon4, color: white),
                  ),
                  14.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: title,
                          color: isSelected ? primary900 : grey300,
                          textStyle: textStyle17Bold,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                        TextWidget(
                          text: subTitle,
                          color: isSelected ? black : grey300,
                          textStyle: textStyle12SemiBold,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Radio<bool>(
              activeColor: primary900,
              value: isSelected,
              groupValue: true,
              onChanged: (value) {
                if (type == 1) {
                  //chọn loại đơn từ
                  controller.selectTypeApplication(context, index);
                } else if (type == 2) {
                  //chọn loại ngày nghỉ
                  controller.selectSessionType(datePicker!, index);
                }
              },
            )
          ],
        ),
        Divider(height: 16.h, color: neutral600),
      ],
    );

Widget selectedReason(
        {required String title,
        required String subTitle,
        required ApplicationController controller,
        required bool isSelected,
        required int index}) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.h),
                    height: 48.h,
                    width: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: isSelected ? primary900 : grey300,
                    ),
                    child: Image.asset(AppIcon.reason, color: white),
                  ),
                  14.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: title,
                          color: isSelected ? primary900 : grey300,
                          textStyle: textStyle15Bold,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                        TextWidget(
                          text: subTitle,
                          color: isSelected ? black : grey300,
                          textStyle: textStyle12SemiBold,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Radio<bool>(
              activeColor: primary900,
              value: isSelected,
              groupValue: true,
              onChanged: (bool? value) => controller.addReason(index),
            )
          ],
        ),
        Divider(height: 16.h, color: neutral600),
      ],
    );

Widget selectedReceiver({
  required String title,
  required String subTitle,
  required bool isSelected,
  required int index,
  String? image,
  required ApplicationController controller,
}) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  networkImageWithCached(size: Size(48.h, 48.h), url: image),
                  14.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: title,
                          color: isSelected ? primary900 : grey300,
                          textStyle: textStyle17Bold,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                        TextWidget(
                          text: subTitle,
                          color: isSelected ? black : grey300,
                          textStyle: textStyle12SemiBold,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Checkbox(
              activeColor: primary900,
              tristate: true,
              value: isSelected,
              onChanged: (bool? value) => controller.addReceiver(index),
            ),
          ],
        ),
        Divider(height: 16.h, color: neutral600),
      ],
    );

Future<TimeOfDay?> buildCupertinoTimePicker(
  BuildContext context,
  DateTime init,
  TimeOfDay? limit,
  bool isBegin,
) async {
  TimeOfDay? selectedTime;

  await showModalBottomSheet(
    context: context,
    builder: (BuildContext builder) {
      return Container(
        height: MediaQuery.of(context).copyWith().size.height / 3,
        color: Colors.white,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (picked) {
            selectedTime = TimeOfDay.fromDateTime(
              DateTime(
                  init.year, init.month, init.day, picked.hour, picked.minute),
            );
          },
          use24hFormat: true,
          initialDateTime: init,
          maximumDate: isBegin
              ? limit != null
                  ? DateTime(
                      init.year, init.month, init.day, limit.hour, limit.minute)
                  : DateTime(init.year, init.month, init.day, 23, 59)
              : DateTime(init.year, init.month, init.day, 23, 59),
          minimumDate: !isBegin
              ? limit != null
                  ? DateTime(
                      init.year, init.month, init.day, limit.hour, limit.minute)
                  : DateTime(init.year, init.month, init.day, 17, 30)
              : DateTime(init.year, init.month, init.day, 0, 0),
        ),
      );
    },
  );

  return selectedTime;
}

Future<TimeOfDay?> buildLateSoonTimePicker(
  BuildContext context,
  DateTime init,
  TimeOfDay min,
  TimeOfDay max,
) async {
  TimeOfDay? selectedTime;

  await showModalBottomSheet(
    context: context,
    builder: (BuildContext builder) {
      return Container(
        height: MediaQuery.of(context).copyWith().size.height / 3,
        color: Colors.white,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (picked) {
            selectedTime = TimeOfDay.fromDateTime(
              DateTime(
                  init.year, init.month, init.day, picked.hour, picked.minute),
            );
          },
          use24hFormat: true,
          initialDateTime: init,
          maximumDate:
              DateTime(init.year, init.month, init.day, max.hour, max.minute),
          minimumDate:
              DateTime(init.year, init.month, init.day, min.hour, min.minute),
        ),
      );
    },
  );

  return selectedTime;
}
