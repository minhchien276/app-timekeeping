import 'package:e_tmsc_app/presentation/screens/calendar/calendar_dayoff.dart';
import 'package:e_tmsc_app/presentation/screens/calendar/calendar_online.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalendarAdmin extends StatefulWidget {
  const CalendarAdmin({super.key});

  @override
  State<CalendarAdmin> createState() => _CalendarAdminState();
}

class _CalendarAdminState extends State<CalendarAdmin> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: primary900,
          centerTitle: true,
          title: TextWidget(
            text: 'Lịch theo dõi',
            color: white,
            textStyle: textStyle17Bold,
          ),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 48.h),
            child: Stack(
              alignment: Alignment.center,
              children: [
                TabBar(
                  tabs: [
                    Tab(
                      child: TextWidget(
                        text: 'Đi làm',
                        color: white,
                        textStyle: textStyle15SemiBold,
                      ),
                    ),
                    Tab(
                      child: TextWidget(
                        text: 'Nghỉ phép',
                        color: white,
                        textStyle: textStyle15SemiBold,
                      ),
                    ),
                  ],
                  indicatorWeight: 2,
                  indicatorColor: white,
                  dividerColor: primary900,
                  dividerHeight: 2,
                ),
                Positioned(
                  child: Container(
                    width: 1,
                    height: 48.h,
                    color: white.withOpacity(0.2),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: 1.h,
                    color: white.withOpacity(0.2),
                  ),
                )
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            CalendarOnline(),
            CalendarDayoff(),
          ],
        ),
      ),
    );
  }
}
