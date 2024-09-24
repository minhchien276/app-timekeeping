import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showDateTimePicker(
  BuildContext context, {
  required Function(DateTime) onChange,
}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => Container(
      height: 300.h,
      padding: const EdgeInsets.only(top: 6.0),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: SafeArea(
        top: false,
        child: CupertinoDatePicker(
          initialDateTime: DateTime.now(),
          use24hFormat: true,
          onDateTimeChanged: onChange,
        ),
      ),
    ),
  );
}
