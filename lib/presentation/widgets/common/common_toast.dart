import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension SnackbarExtension on BuildContext {
  void showToast(String text, {int? seconds}) {
    FToast fToast = FToast();
    fToast.init(this);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withOpacity(0.7),
      ),
      child: TextWidget(
        text: text,
        fontWeight: FontWeight.w500,
        color: white,
        textStyle: textStyle12.copyWith(fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: seconds ?? 2),
    );
  }
}

void showToastWithoutContext(String text, {int? seconds}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.black.withOpacity(0.7),
      textColor: Colors.white,
      fontSize: 12);
}
