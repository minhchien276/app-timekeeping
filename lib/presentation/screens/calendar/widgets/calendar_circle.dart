// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/shared/enums/day_enum.dart';
import 'package:flutter/material.dart';

import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';

class CalendarCircle extends StatelessWidget {
  final CalendarData data;
  final String text;
  final bool isToday;
  const CalendarCircle({
    Key? key,
    required this.data,
    required this.text,
    this.isToday = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isToday ? white : data.bgColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: isToday ? primary900 : white,
          width: 2,
        ),
      ),
      child: Center(
        child: TextWidget(
          text: text,
          fontWeight: FontWeight.w500,
          size: 14,
          color: isToday ? black : data.textColor,
        ),
      ),
    );
  }
}
