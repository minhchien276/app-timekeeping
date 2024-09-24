// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:flutter/material.dart';

import 'package:e_tmsc_app/data/models/notification_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotiDetails extends StatelessWidget {
  final NotificationModel notification;
  const NotiDetails({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primary900,
        leading: const KBackButton(),
        centerTitle: true,
        title: TextWidget(
          text: 'Chi tiết thông báo',
          color: white,
          textStyle: textStyle17Bold,
        ),
        // ƒ
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            20.verticalSpace,
            TextWidget(
              text: notification.notiTitle ?? '',
              color: black,
              textStyle: textStyle17Bold,
            ),
            10.verticalSpace,
            TextWidget(
              text: notification.createdAt!.formatDateTime,
              color: black,
              textStyle: textStyle12,
              maxLines: 10,
            ),
            30.verticalSpace,
            TextWidget(
              text: notification.notiContent ?? '',
              color: black,
              textStyle: textStyle14SemiBold,
              maxLines: 1000,
            ),
          ],
        ),
      ),
    );
  }
}
