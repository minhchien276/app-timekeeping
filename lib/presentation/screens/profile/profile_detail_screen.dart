// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/extensions/datetime_extension.dart';

class ProfileDetailScreen extends StatefulWidget {
  final EmployeeModel employee;
  const ProfileDetailScreen({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const KBackButton(),
        backgroundColor: primary900,
        centerTitle: true,
        title: TextWidget(
          text: 'Hồ sơ cá nhân',
          color: white,
          textStyle: textStyle17Bold,
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 210.h,
            decoration: BoxDecoration(
              color: primary900,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                networkImageWithCached(
                  size: Size(100.h, 100.h),
                  url: widget.employee.image,
                  borderRadius: 100,
                  boxBorder: Border.all(color: white, width: 2),
                ),
                18.verticalSpace,
                TextWidget(
                  text: widget.employee.fullname ?? '',
                  color: white,
                  textStyle: textStyle22Bold,
                ),
                TextWidget(
                  text: widget.employee.departmentName ?? '',
                  color: white,
                  textStyle: textStyle15SemiBold,
                ),
                26.verticalSpace,
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  20.verticalSpace,
                  item(
                      title: 'Email',
                      content: widget.employee.email ?? '',
                      isLast: false),
                  item(
                      title: 'Số điện thoại',
                      content: widget.employee.phone ?? '',
                      isLast: false),
                  item(
                      title: 'Ngày sinh nhật',
                      content: convertBirthday(widget.employee.birthday!) ?? '',
                      isLast: false),
                  item(
                      title: 'Ngày nghỉ phép còn lại',
                      content: '${widget.employee.dayOff} ngày',
                      isLast: true),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget item(
          {required String title,
          required String content,
          required bool isLast}) =>
      Container(
        height: 40.h,
        width: double.infinity,
        margin: EdgeInsets.only(top: 20.h),
        decoration: isLast
            ? const BoxDecoration()
            : const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: grey700, width: 0.5),
                ),
              ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: title,
                  color: black,
                  textStyle:
                      textStyle15SemiBold.copyWith(fontWeight: FontWeight.w500),
                ),
                Flexible(
                  child: TextWidget(
                    text: content,
                    color: black,
                    textStyle: textStyle15SemiBold.copyWith(
                        fontWeight: FontWeight.w700),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
