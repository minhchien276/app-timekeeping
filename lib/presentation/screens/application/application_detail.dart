// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_line/dotted_line.dart';
import 'package:e_tmsc_app/data/models/application_model.dart';
import 'package:e_tmsc_app/data/models/dayoff_model.dart';
import 'package:e_tmsc_app/data/models/early_late_model.dart';
import 'package:e_tmsc_app/data/models/overtime_model.dart';
import 'package:e_tmsc_app/logic/controllers/application/application_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_submit_button.dart';
import 'package:e_tmsc_app/presentation/widgets/dialog/submit_dialog.dart';
import 'package:e_tmsc_app/shared/enums/application_enum.dart';
import 'package:e_tmsc_app/shared/enums/type_day_enum.dart';
import 'package:e_tmsc_app/shared/enums/user_enum.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ApplicationDetail extends StatefulWidget {
  final Map<String, dynamic> parms;
  const ApplicationDetail({
    Key? key,
    required this.parms,
  }) : super(key: key);

  @override
  State<ApplicationDetail> createState() => _ApplicationDetailState();
}

class _ApplicationDetailState extends State<ApplicationDetail> {
  late ApplicationModel item;
  late UserEnum userEnum;

  @override
  void initState() {
    item = widget.parms['item'];
    userEnum = widget.parms['userEnum'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ApplicationController());
    final ApplicationController appController = Get.find();
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          leading: const KBackButton(),
          backgroundColor: primary900,
          centerTitle: true,
          title: TextWidget(
            text: 'Chi tiết đơn từ',
            color: white,
            textStyle: textStyle17Bold,
          ),
        ),
        body: Column(
          children: [
            30.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              margin: EdgeInsets.symmetric(horizontal: 24.w),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Image.asset(AppIcon.navIcon4, scale: 2),
                            12.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    maxLines: 1,
                                    text: item.type!.getTitle(),
                                    color: black,
                                    textStyle: textStyle15SemiBold,
                                  ),
                                  TextWidget(
                                    maxLines: 1,
                                    text:
                                        '${item.employee?.fullname ?? ''} - ${item.employee?.departmentName ?? ''}',
                                    color: black,
                                    textStyle: textStyle12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: item.status!.buildData().textColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: TextWidget(
                            text: item.status!.buildData().text,
                            color: Colors.white,
                            textStyle: textStyle12.copyWith(
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  const DottedLine(
                    direction: Axis.horizontal,
                    dashLength: 3,
                  ),
                  16.verticalSpace,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: primary900),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.h,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: primary900,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.r),
                                    ),
                                  ),
                                  child: Center(
                                    child: TextWidget(
                                      text: 'Ngày',
                                      color: white,
                                      textStyle: textStyle15SemiBold,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              const VerticalDivider(width: 1, color: white),
                              Expanded(
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: primary900,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16.r),
                                    ),
                                  ),
                                  child: Center(
                                    child: TextWidget(
                                      text: 'Thời gian',
                                      color: white,
                                      textStyle: textStyle15SemiBold,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        buildItems(item),
                      ],
                    ),
                  ),
                  16.verticalSpace,
                  RichText(
                    text: TextSpan(
                      text: 'Lý do: ',
                      style: textStyle15SemiBold.copyWith(
                        color: black,
                        fontWeight: FontWeight.w900,
                      ),
                      children: [
                        TextSpan(
                          text: item.content,
                          style: textStyle15SemiBold.copyWith(color: black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            if (userEnum != UserEnum.my &&
                item.status == ApplicationEnum.pending) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    Expanded(
                      child: SubmitButton(
                        onTap: () => showSubmitDialog(
                          context,
                          title: 'Từ chối đơn',
                          message: 'Bạn đã chắc chắn muốn từ chối đơn?',
                          onSubmit: () => appController.updateStatus(
                              context, ApplicationEnum.refuse, item),
                        ),
                        text: 'Từ chối',
                        isLoading: false,
                        border: 100,
                        bgColor: Colors.red,
                        size: Size(double.infinity, 46.h),
                      ),
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: SubmitButton(
                        onTap: () => showSubmitDialog(
                          context,
                          title: 'Duyệt đơn',
                          message: 'Bạn đã chắc chắn muốn duyệt đơn?',
                          onSubmit: () => appController.updateStatus(
                              context, ApplicationEnum.approved, item),
                        ),
                        text: 'Đã duyệt',
                        isLoading: false,
                        border: 100,
                        bgColor: Colors.green,
                        size: Size(double.infinity, 46.h),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildItems(ApplicationModel item) {
    switch (item.type) {
      case TypeDayEnum.dayOff:
      case TypeDayEnum.dayOffNotSalary:
        return SizedBox(
          height: 40.h * item.dayOff.length,
          child: ListView.builder(
            itemCount: item.dayOff.length,
            itemBuilder: (context, index) {
              DayoffModel day = item.dayOff[index];
              return dayItem(
                  day: day.dayOffDate!, time: day.session!.buildTitle());
            },
          ),
        );
      case TypeDayEnum.dayOvertime:
        return SizedBox(
          height: 40.h * item.overTime.length,
          child: ListView.builder(
            itemCount: item.overTime.length,
            itemBuilder: (context, index) {
              OvertimeModel day = item.overTime[index];
              return dayItem(
                  day: day.dayOffDate!,
                  time: twoOvertime(day.startTime, day.endTime));
            },
          ),
        );
      case TypeDayEnum.dayGoLate:
      case TypeDayEnum.dayBackSoon:
        return SizedBox(
          height: 40.h * item.earlyLate.length,
          child: ListView.builder(
            itemCount: item.earlyLate.length,
            itemBuilder: (context, index) {
              EarlyLateModel day = item.earlyLate[index];
              return dayItem(
                  day: day.dayOffDate!, time: formatHours(day.hours));
            },
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget dayItem({
    required DateTime day,
    required String time,
  }) =>
      SizedBox(
        height: 40.h,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: TextWidget(
                  text: day.formatDayMonthWeek,
                  color: black,
                  textStyle: textStyle15SemiBold,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const VerticalDivider(width: 1, color: primary900),
            Expanded(
              child: Center(
                child: TextWidget(
                  text: time,
                  color: black,
                  textStyle: textStyle15SemiBold,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
}
