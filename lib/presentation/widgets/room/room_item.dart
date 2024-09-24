// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/data/models/room_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/shared/enums/room_enum.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:e_tmsc_app/utils/styles.dart';

class RoomItem extends StatelessWidget {
  final RoomModel room;
  final RoomStatus status;
  final VoidCallback? onTap;
  const RoomItem({
    Key? key,
    required this.room,
    required this.status,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          height: status == RoomStatus.approve ? 180.h : 150.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.horizontalSpace,
              Container(
                height: 60.h,
                width: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    colors: groupImageColor(room.twoCharName()),
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: TextWidget(
                    text: room.twoCharName(),
                    color: white,
                    textStyle: textStyle22Bold,
                  ),
                ),
              ),
              20.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: room.name,
                      color: grey700,
                      textStyle: textStyle17Bold,
                      maxLines: 1,
                    ),
                    Divider(
                      height: 20.h,
                      color: grey300,
                      thickness: 0.4,
                    ),
                    Expanded(child: buildParicipants(room.participants)),
                    Divider(
                      height: 20.h,
                      color: grey300,
                      thickness: 0.4,
                    ),
                    if (status == RoomStatus.pending) ...[
                      TextWidget(
                          text: 'Đã mời tham gia: ${timeLeft(room.createdAt)}',
                          color: grey500,
                          textStyle: textStyle12SemiBold)
                    ],
                    if (status == RoomStatus.approve) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.done,
                                color: Colors.green,
                              ),
                              4.horizontalSpace,
                              TextWidget(
                                text: (room.tasksCompleted ?? 0).toString(),
                                color: grey700,
                                textStyle: textStyle14SemiBold,
                              )
                            ],
                          ),
                          20.horizontalSpace,
                          Row(
                            children: [
                              const Icon(
                                Icons.pending_outlined,
                                color: primary900,
                              ),
                              4.horizontalSpace,
                              TextWidget(
                                text: (room.tasksPending ?? 0).toString(),
                                color: grey700,
                                textStyle: textStyle14SemiBold,
                              )
                            ],
                          ),
                          20.horizontalSpace,
                          Row(
                            children: [
                              const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              4.horizontalSpace,
                              TextWidget(
                                text: (room.tasksCanceled ?? 0).toString(),
                                color: grey700,
                                textStyle: textStyle14SemiBold,
                              )
                            ],
                          ),
                        ],
                      ),
                      4.verticalSpace,
                      TextWidget(
                          text: 'Đã cập nhật: ${timeLeft(room.updatedAt)}',
                          color: grey500,
                          textStyle: textStyle12SemiBold)
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildParicipants(
  List<EmployeeModel> participants, {
  int limit = 5,
  double? size,
}) {
  final limited = participants.length < limit ? participants.length : limit;
  final vSize = size ?? 36.h;
  return SizedBox(
    height: vSize + 2.h,
    width: size == null
        ? (limited + 1) * 30.w
        : (participants.length == limited
            ? limited * 30.w
            : (limited + 1) * 30.w),
    child: Stack(
      children: List.generate(
        participants.length > limited ? (limited + 1) : participants.length,
        (index) => index == limited
            ? Positioned(
                left: limit * 30.w,
                top: 0,
                child: SizedBox(
                  height: vSize,
                  width: vSize,
                  child: Center(
                    child: TextWidget(
                      text: '+${participants.length - limit}',
                      color: grey700,
                      textStyle: textStyle15SemiBold,
                    ),
                  ),
                ),
              )
            : Positioned(
                left: index * 30.w,
                child: networkImageWithCached(
                  size: Size(vSize, vSize),
                  url: participants[index].image,
                  boxBorder: Border.all(color: primary900, width: 1),
                ),
              ),
      ),
    ),
  );
}
