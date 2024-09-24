// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:flutter/material.dart';

import 'package:e_tmsc_app/data/models/task_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WorkTaskDetail extends StatefulWidget {
  final TaskModel task;
  const WorkTaskDetail({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<WorkTaskDetail> createState() => _WorkTaskDetailState();
}

class _WorkTaskDetailState extends State<WorkTaskDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primary900,
        leading: const KBackButton(),
        centerTitle: true,
        title: TextWidget(
          text: "Task Detail",
          color: white,
          textStyle: textStyle17Bold,
          maxLines: 1,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            10.verticalSpace,
            TextWidget(
              text: widget.task.title ?? '',
              color: grey900,
              textStyle: textStyle20Bold,
              maxLines: 100,
            ),
            30.verticalSpace,
            _buildTitle(
              icon: const Icon(Icons.menu_open_outlined),
              title: 'Mô tả',
            ),
            4.verticalSpace,
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: TextWidget(
                text: widget.task.content ?? '',
                color: grey700,
                textStyle: textStyle14SemiBold,
              ),
            ),
            30.verticalSpace,
            _buildTitle(
              icon: const Icon(Icons.supervised_user_circle_outlined),
              title: 'Thành viên',
            ),
            _buildMember(widget.task.participants),
            30.verticalSpace,
            _buildTitle(
              icon: const Icon(Icons.comment_outlined),
              title: 'Bình luận',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMember(List<EmployeeModel> participants) {
    return Column(
      children: List.generate(
        participants.length,
        (index) => Container(
          margin: EdgeInsets.only(top: 10.h),
          child: Row(
            children: [
              networkImageWithCached(
                size: Size(40.h, 40.h),
                url: widget.task.participants[index].image,
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextWidget(
                            text:
                                widget.task.participants[index].fullname ?? '',
                            color: grey700,
                            textStyle: textStyle14SemiBold,
                          ),
                        ),
                        TextWidget(
                          text: '50%',
                          color: grey700,
                          textStyle: textStyle14SemiBold,
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    LinearPercentIndicator(
                      lineHeight: 12.h,
                      percent: 0.5,
                      padding: EdgeInsets.zero,
                      progressColor: Colors.green,
                      barRadius: Radius.circular(100.r),
                    ),
                  ],
                ),
              ),
              10.horizontalSpace,
              const Icon(Icons.more_horiz),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle({
    required Widget icon,
    required String title,
    Color? textColor,
  }) {
    return Row(
      children: [
        // icon,
        // 4.horizontalSpace,
        Expanded(
          child: TextWidget(
            text: title,
            color: textColor ?? grey700,
            textStyle: textStyle16Bold,
          ),
        ),
      ],
    );
  }
}
