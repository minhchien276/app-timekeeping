// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/notification_model.dart';
import 'package:e_tmsc_app/presentation/screens/home/noti/noti_item.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotiType extends StatelessWidget {
  final DateTime date;
  final List<NotificationModel> notis;
  final bool isLast;
  final bool isLoading;
  const NotiType({
    Key? key,
    required this.date,
    required this.notis,
    required this.isLast,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 30.h),
          child: TextWidget(
            text: formatNotiDate(date),
            color: black,
            textStyle: textStyle12.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Column(
          children: List.generate(
            notis.length,
            (index) => NotiItem(
              notification: notis[index],
            ),
          ),
        ),
        isLast ? 20.verticalSpace : 0.verticalSpace,
        if (isLast && isLoading) ...[
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    backgroundColor: primary900,
                    strokeWidth: 4,
                  ),
                ),
                isLast ? 20.verticalSpace : 0.verticalSpace,
              ],
            ),
          ),
        ],
        isLast ? 20.verticalSpace : 0.verticalSpace,
      ],
    );
  }
}
