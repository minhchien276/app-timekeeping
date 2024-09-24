// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/notification_model.dart';
import 'package:e_tmsc_app/logic/controllers/notification/notification_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotiItem extends StatelessWidget {
  final NotificationModel notification;
  const NotiItem({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.find();

    return GestureDetector(
      onTap: () => controller.handleNextDetail(context, notification),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Container(
          height: 100.h,
          margin: EdgeInsets.only(top: 16.h, bottom: 0),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
              color: notification.seen == 1 ? white : primary200,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: black.withOpacity(0.05)),
              boxShadow: [
                BoxShadow(
                  color: black.withOpacity(0.1),
                  blurRadius: 10.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset: const Offset(
                    5.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 10 Vertically
                  ),
                )
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              networkImageWithCached(
                size: Size(48.h, 48.h),
                url: notification.image,
                borderRadius: 100,
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(notification.senderName!,
                        style: textStyle15SemiBold.copyWith(color: black)),
                    SizedBox(
                      child: Text(
                          notification.text!.toString()[0].toUpperCase() +
                              notification.text!
                                  .toString()
                                  .substring(1)
                                  .toLowerCase(),
                          style: textStyle14Normal.copyWith(color: neutral600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
              16.horizontalSpace,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    text: formatHours(notification.createdAt),
                    color: neutral600,
                    textStyle: textStyle10,
                  ),
                  4.verticalSpace,
                  TextWidget(
                    text: notification.createdAt!.formatDayMonth,
                    color: neutral600,
                    textStyle: textStyle10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
