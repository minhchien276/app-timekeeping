// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? hintText;
  final VoidCallback? onRemove;
  final bool canRemove;
  final Color? borderColor;
  final double? borderRadius;
  final int? minLines;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.hintText,
    this.onRemove,
    this.canRemove = false,
    this.borderColor,
    this.borderRadius = 12,
    this.minLines = 1,
    this.fillColor,
    this.contentPadding,
    this.prefixIcon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      minLines: minLines,
      maxLines: null,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: fillColor == null ? false : true,
        contentPadding:
            contentPadding ?? EdgeInsets.symmetric(horizontal: 10.w),
        hintText: hintText,
        hintStyle: textStyle14SemiBold,
        constraints: BoxConstraints(maxHeight: 1000.h),
        prefixIcon: prefixIcon,
        suffixIcon: canRemove
            ? IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.close),
              )
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
            borderSide: BorderSide(color: borderColor ?? white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
            borderSide: BorderSide(color: borderColor ?? white)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
            borderSide: BorderSide(color: borderColor ?? white)),
      ),
      style: textStyle14SemiBold,
    );
  }
}
