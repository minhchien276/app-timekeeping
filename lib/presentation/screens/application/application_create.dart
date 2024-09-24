import 'package:e_tmsc_app/logic/controllers/application/application_controller.dart';
import 'package:e_tmsc_app/presentation/screens/application/widgets/application_calander_builder.dart';
import 'package:e_tmsc_app/presentation/screens/application/widgets/application_modal.dart';
import 'package:e_tmsc_app/presentation/screens/calendar/feedback/feedback_submit.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_loader_button.dart';
import 'package:e_tmsc_app/shared/enums/day_enum.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class ApplicationCreate extends StatefulWidget {
  const ApplicationCreate({super.key});

  @override
  State<ApplicationCreate> createState() => _ApplicationCreateState();
}

class _ApplicationCreateState extends State<ApplicationCreate> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ApplicationController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primary900,
        leading: const KBackButton(),
        centerTitle: true,
        title: TextWidget(
          text: 'Tạo đơn mới',
          color: white,
          textStyle: textStyle17Bold,
        ),
      ),
      body: GetBuilder<ApplicationController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                40.verticalSpace,
                InkWell(
                  onTap: () => showTypeDayOff(context),
                  child: Obx(
                    () => inputItem(
                      label: 'Tên loại đơn',
                      isPicker: true,
                      controller:
                          TextEditingController(text: controller.typeDayText),
                    ),
                  ),
                ),
                16.verticalSpace,
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 470.h,
                      padding: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        color: primary900,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "Chọn thời gian nghỉ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 15.w, right: 15.w, top: 50.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: primary900),
                      ),
                      child: TableCalendar(
                        daysOfWeekHeight: 20.h,
                        sixWeekMonthsEnforced: true,
                        rowHeight: 50.h,
                        locale: 'vi',
                        calendarFormat: CalendarFormat.month,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        focusedDay: controller.focusDay,
                        firstDay: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day),
                        lastDay: DateTime(
                            DateTime.now().year, DateTime.now().month + 2, 0),
                        headerStyle: tableHeaderStyle,
                        daysOfWeekStyle: DaysOfWeekStyle(
                          dowTextFormatter: (date, locale) {
                            return CalendarHandler.convertTitleWeekDay(
                                date.weekday);
                          },
                          decoration: const BoxDecoration(),
                          weekdayStyle: textStyle14SemiBold,
                          weekendStyle:
                              textStyle14SemiBold.copyWith(color: primary900),
                        ),
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, day, markedDates) {
                            return CalendarPickerBuilder(
                              day: day.startTime(),
                              type: controller.typeDayEnumSelected,
                            );
                          },
                          disabledBuilder: (context, day, markedDates) {
                            return SizedBox(
                              height: 32.h,
                              width: 32.h,
                              child: Center(
                                child: TextWidget(
                                  text: day.day.toString(),
                                  color: neutral500,
                                  textStyle: textStyle14SemiBold,
                                ),
                              ),
                            );
                          },
                        ),
                        calendarStyle: calendarStyle,
                        onDaySelected: (selectedDay, focusedDay) =>
                            controller.selectCalendarPicker(
                                context, selectedDay.startTime()),
                        availableGestures: AvailableGestures.horizontalSwipe,
                      ),
                    ),
                  ],
                ),
                16.verticalSpace,
                InkWell(
                  onTap: () => showReceivers(context),
                  child: inputItem(
                    label: 'Đơn gửi tới',
                    isPicker: true,
                    controller:
                        TextEditingController(text: controller.receiverText),
                  ),
                ),
                16.verticalSpace,
                // inputItem(
                //   label: 'Lý do',
                //   maxLines: 7,
                //   controller: controller.reason,
                //   focusNode: controller.reasonFocusNode,
                //   isPicker: false,
                // ),
                InkWell(
                  onTap: () => showReason(context),
                  child: inputItem(
                    label: 'Lý do',
                    isPicker: true,
                    controller:
                        TextEditingController(text: controller.reasonText),
                  ),
                ),
                16.verticalSpace,
                Obx(
                  () => LoaderButton(
                    onTap: () => controller.submitApplication(context),
                    text: 'Nộp đơn',
                    isLoading: controller.isLoading,
                    size: Size(double.maxFinite, 40.h),
                  ),
                ),
                100.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}
