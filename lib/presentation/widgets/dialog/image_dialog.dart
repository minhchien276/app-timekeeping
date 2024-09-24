import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showImageDialog(BuildContext context, {String? image}) {
  return showDialog<void>(
    barrierColor: Colors.black45,
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: white,
        surfaceTintColor: white,
        elevation: 0,
        contentPadding: EdgeInsets.zero,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
        content: networkImageWithCached(
          size: Size(300.h, 300.h),
          url: image,
          borderRadius: 1000,
          boxBorder: Border.all(color: white, width: 2),
        ),
      );
    },
  );
}
