import 'package:e_tmsc_app/logic/controllers/home/home_client_controller.dart';
import 'package:e_tmsc_app/presentation/screens/calendar/widgets/calendar_bottom_modal.dart';
import 'package:e_tmsc_app/presentation/screens/calendar/widgets/calendar_builder.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_snackbar.dart';
import 'package:e_tmsc_app/shared/enums/day_enum.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarNormal extends StatelessWidget {
  const CalendarNormal({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeClientController>(
      builder: (controller) {
        return RefreshIndicator(
          color: primary900,
          onRefresh: () =>
              controller.isLoading ? null : controller.refreshCalenlar(context),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              38.verticalSpace,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(14),
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
                    Stack(
                      children: [
                        TableCalendar(
                          daysOfWeekHeight: 20.h,
                          rowHeight: 50.h,
                          locale: 'vi',
                          calendarFormat: CalendarFormat.month,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          focusedDay: DateTime.now(),
                          firstDay:
                              DateTime.now().subtract(const Duration(days: 62)),
                          lastDay: DateTime.now(),
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
                              return CalendarNormalBuilder(
                                  day: day.startTime());
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
                          onDaySelected: (selectedDay, focusedDay) async {
                            if (selectedDay.startTime().millisecondsSinceEpoch <
                                DateTime.now().millisecondsSinceEpoch) {
                              final list = controller.days
                                  .where((e) =>
                                      e.date?.millisecondsSinceEpoch ==
                                      selectedDay
                                          .startTime()
                                          .millisecondsSinceEpoch)
                                  .toList();

                              showPickerDay(
                                context,
                                date: selectedDay.startTime(),
                                timeKeeping:
                                    list.isNotEmpty ? list.first : null,
                                typeOfWork: controller.typeOfWork,
                              );
                            } else {
                              context.showErrorMessage(
                                  'Chỉ xem được quá khứ và hiện tại');
                            }
                          },
                          availableGestures: AvailableGestures.horizontalSwipe,
                        ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            icon: Image.asset(AppIcon.note, scale: 3),
                            onPressed: () => showGuideCalendar(context),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Divider(color: neutral600),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  text: DateTime.now().formatWeekDayMonth,
                                  color: black,
                                  textStyle: textStyle17Bold),
                              8.verticalSpace,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Check In: ',
                                      style: textStyle14SemiBold.copyWith(
                                          color: black),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${formatHours(controller.timeKeeping?.checkin?.checkin)} AM',
                                          style: textStyle14SemiBold.copyWith(
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const TextWidget(
                                      text: 'Tổng giờ', color: Colors.red),
                                ],
                              ),
                              4.verticalSpace,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Check Out: ',
                                      style: textStyle14SemiBold.copyWith(
                                          color: black),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${formatHours(controller.timeKeeping?.checkout?.checkout)} PM',
                                          style: textStyle14SemiBold.copyWith(
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextWidget(
                                      text: CalendarHandler.buildPickerData(
                                          controller.timeKeeping,
                                          controller.typeOfWork)[1],
                                      color: black),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    20.verticalSpace,
                  ],
                ),
              ),
              24.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: TextWidget(
                  text: 'Lịch biểu của bạn',
                  color: black,
                  textStyle: textStyle15SemiBold,
                ),
              ),
              12.verticalSpace,
              GestureDetector(
                onTap: () {
                  showPickerContainer(
                    context,
                    data: controller.calendar.daysOfWork,
                    type: DayEnum.success,
                  );
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
                              "${controller.totalAllWorkday()}",
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
                      "Số ngày công",
                      style: textStyle14Bold.copyWith(color: Colors.white),
                    ),
                    subtitle: Text(
                      "Xem chi tiết",
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
                        scale: 3.5,
                      ),
                    ),
                  ),
                ),
              ),
              18.verticalSpace,
              GestureDetector(
                onTap: () {
                  showPickerContainer(
                    context,
                    data: controller.calendar.daysOfLate,
                    type: DayEnum.lated,
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: redBold,
                      boxShadow: [
                        BoxShadow(
                          color: redBold.withOpacity(0.6),
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
                              "${controller.calendar.daysOfLate.length}",
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
                      "Số ngày đi muộn",
                      style: textStyle14Bold.copyWith(color: Colors.white),
                    ),
                    subtitle: Text(
                      "Xem chi tiết",
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
                    ),
                  ),
                ),
              ),
              18.verticalSpace,
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.6),
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
                              "${controller.employee?.dayOff}",
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
                      "Số ngày phép",
                      style: textStyle14Bold.copyWith(color: Colors.white),
                    ),
                    subtitle: Text(
                      "Xem chi tiết",
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
                        color: Colors.blue,
                        scale: 3.5,
                      ),
                    ),
                  ),
                ),
              ),
              18.verticalSpace,
              GestureDetector(
                onTap: () {
                  showPickerContainer(
                    context,
                    data: controller.calendar.daysOfMissing,
                    type: DayEnum.missing,
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: primary900,
                      boxShadow: [
                        BoxShadow(
                          color: primary900.withOpacity(0.6),
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
                                "${controller.calendar.daysOfMissing.length}",
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
                        "Số ngày quên công",
                        style: textStyle14Bold.copyWith(color: Colors.white),
                      ),
                      subtitle: Text(
                        "Xem chi tiết",
                        style: textStyle11.copyWith(color: Colors.white),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.w),
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          AppIcon.timekeepingFail,
                          color: primary900,
                          scale: 3.5,
                        ),
                      )),
                ),
              ),
              60.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
