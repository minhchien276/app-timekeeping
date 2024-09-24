// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoaderButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isLoading;
  final Size? size;
  final Color? color;
  final Color? textColor;
  const LoaderButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.isLoading,
    this.size,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(color ?? primary900),
        fixedSize: WidgetStatePropertyAll(
          Size(size?.width ?? 390, size?.height ?? 50.h),
        ),
        shadowColor: const WidgetStatePropertyAll(white),
        foregroundColor: const WidgetStatePropertyAll(white),
        surfaceTintColor: const WidgetStatePropertyAll(white),
        elevation: const WidgetStatePropertyAll(0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            text: text,
            color: textColor ?? white,
            textStyle: textStyle16Bold,
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
