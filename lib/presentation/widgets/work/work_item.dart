// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_down_button/pull_down_button.dart';

import 'package:e_tmsc_app/data/models/task_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/room/room_item.dart';
import 'package:e_tmsc_app/shared/enums/task_enum.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';

class WorkItem extends StatelessWidget {
  final TaskModel item;
  final TaskStatus status;
  const WorkItem({
    Key? key,
    required this.item,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PullDownButton(
      itemBuilder: (context) => List.generate(
        TaskStatus.values.length,
        (index) => PullDownMenuItem.selectable(
          selected: TaskStatus.values[index] == status,
          onTap: () {},
          title: TaskStatus.values[index].toName(),
        ),
      ),
      buttonBuilder: (context, showMenu) => GestureDetector(
        onTap: () =>
            context.pushNamed(AppRoute.workTaskDetail.name, extra: item),
        onLongPress: showMenu,
        child: Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
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
          padding: EdgeInsets.all(10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: item.title ?? '',
                textStyle: textStyle14SemiBold,
                color: grey700,
              ),
              4.verticalSpace,
              Row(
                children: [
                  if (item.expired != null) ...[
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: item.expiredColor(),
                      ),
                      child: TextWidget(
                        text: item.expired!.formatDateTime,
                        textStyle: textStyle14SemiBold,
                        color: white,
                      ),
                    ),
                    6.horizontalSpace,
                  ],
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.messenger_outline_rounded,
                        color: grey700,
                        size: 20.h,
                      ),
                      4.horizontalSpace,
                      TextWidget(
                        text: item.commentCount.toString(),
                        textStyle: textStyle14SemiBold,
                        color: grey700,
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (item.participants.isNotEmpty) ...[
                    buildParicipants(item.participants, limit: 2, size: 26.h),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
