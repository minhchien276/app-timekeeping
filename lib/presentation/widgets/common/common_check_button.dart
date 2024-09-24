// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';

class CheckButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final bool isChecked;
  final bool disable;
  final Size? size;
  final Color? bgColor;
  final double? border;
  const CheckButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.isChecked,
    required this.disable,
    this.size,
    this.bgColor,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disable
          ? null
          : isChecked
              ? null
              : onTap,
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        backgroundColor: WidgetStatePropertyAll(disable
            ? neutral200
            : isChecked
                ? neutral200
                : primary900),
        fixedSize: WidgetStatePropertyAll(
          Size(size?.width ?? 390, size?.height ?? 50.h),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(border ?? 8.r),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            text: text,
            color: disable
                ? neutral600
                : isChecked
                    ? neutral600
                    : white,
            textStyle: textStyle16Bold,
          ),
          if (isChecked) ...[
            16.horizontalSpace,
            Image.asset(
              AppIcon.success,
              scale: 5,
              color: Colors.green,
            ),
          ],
        ],
      ),
    );
  }
}
