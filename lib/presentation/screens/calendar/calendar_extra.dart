import 'package:e_tmsc_app/logic/controllers/home/home_client_controller.dart';
import 'package:e_tmsc_app/presentation/screens/calendar/widgets/calendar_bottom_modal.dart';
import 'package:e_tmsc_app/presentation/screens/calendar/widgets/calendar_builder.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/shared/enums/day_enum.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarExtra extends StatelessWidget {
  const CalendarExtra({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeClientController>(
      builder: (controller) {
        return ListView(
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
                  TableCalendar(
                    rowHeight: 50.h,
                    locale: 'vi',
                    calendarFormat: CalendarFormat.month,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.now().subtract(const Duration(days: 30)),
                    lastDay: DateTime.now().add(const Duration(days: 30)),
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
                        return CalendarExtraBuilder(day: day.startTime());
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
                      final list = controller.overtime
                          .where((e) =>
                              e.dayOffDate?.millisecondsSinceEpoch ==
                              selectedDay.startTime().millisecondsSinceEpoch)
                          .toList();
                      showCalendarOTPicker(
                        context,
                        focusedDay,
                        list.isNotEmpty ? list.first : null,
                      );
                    },
                    availableGestures: AvailableGestures.horizontalSwipe,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Divider(color: neutral600),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                                text: 'Tổng giờ',
                                color: Colors.green,
                                textStyle: textStyle15SemiBold),
                            TextWidget(
                                text:
                                    '${controller.totalOvertime.toStringAsFixed(1)} Hrs',
                                color: black,
                                textStyle: textStyle15SemiBold),
                          ],
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
