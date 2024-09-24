// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:e_tmsc_app/presentation/widgets/common/common_check_button.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/styles.dart';

class DisconnectWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const DisconnectWidget({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        150.verticalSpace,
        Image.asset(AppImage.disconnect),
        20.verticalSpace,
        TextWidget(
          text: 'Đã có lỗi xảy ra',
          color: Colors.black,
          textStyle: textStyle16Bold,
        ),
        20.verticalSpace,
        CheckButton(
          onTap: onTap,
          text: 'THỬ LẠI',
          isChecked: false,
          disable: false,
          size: Size(120.w, 50.h),
        ),
      ],
    );
  }
}
