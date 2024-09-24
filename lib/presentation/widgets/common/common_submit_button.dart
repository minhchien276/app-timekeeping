// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isLoading;
  final Size? size;
  final Color? bgColor;
  final double? border;
  final TextStyle? textStyle;
  final BorderSide borderSide;
  const SubmitButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.isLoading,
    this.size,
    this.bgColor,
    this.border,
    this.textStyle,
    this.borderSide = BorderSide.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(bgColor ?? primary900),
        fixedSize: WidgetStatePropertyAll(
          Size(size?.width ?? 390.w, size?.height ?? 50.h),
        ),
        shadowColor: const WidgetStatePropertyAll(white),
        foregroundColor: const WidgetStatePropertyAll(white),
        surfaceTintColor: const WidgetStatePropertyAll(white),
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(border ?? 8.r),
            side: borderSide,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            text: text,
            color: textStyle?.color ?? white,
            textStyle: textStyle ?? textStyle14SemiBold,
          ),
          if (isLoading) ...[
            8.horizontalSpace,
            SizedBox(
              height: 24.h,
              width: 24.h,
              child: const CircularProgressIndicator(color: white),
            ),
          ],
        ],
      ),
    );
  }
}
