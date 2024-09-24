import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

import '../../../shared/extensions/datetime_extension.dart';
import '../../../utils/app_string.dart';

void showNewEmployeeDialog(
  BuildContext context, {
  String? title,
  required EmployeeModel e,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: white,
      shadowColor: white,
      surfaceTintColor: white,
      title: title != null ? Text(title) : null,
      content: Stack(
        children: [
          Container(
            height: 140.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primary900,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              16.verticalSpace,
              networkImageWithCached(
                size: Size(150.h, 150.h),
                url: e.image,
                borderRadius: 100,
                boxBorder: Border.all(color: Colors.white, width: 2),
              ),
              10.verticalSpace,
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                        text: e.fullname ?? '',
                        color: grey900,
                        textStyle: textStyle15SemiBold),
                    const Divider(color: grey300),
                    TextWidget(
                        text: convertBirthday(e.birthday!) ?? '',
                        color: grey900,
                        textStyle: textStyle15SemiBold),
                    const Divider(color: grey300),
                    TextWidget(
                        text: e.departmentName ?? '',
                        color: grey900,
                        textStyle: textStyle15SemiBold),
                  ],
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ],
      ),
    ),
  );
}

// void showBirthdayDialog(
//   BuildContext context, {
//   String? title,
//   required EmployeeModel e,
// }) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) => AlertDialog(
//       contentPadding: EdgeInsets.zero,
//       backgroundColor: white,
//       shadowColor: white,
//       surfaceTintColor: white,
//       title: title != null ? Text(title) : null,
//       content: Stack(
//         children: [
//           Container(
//             height: 140.h,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: primary900,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(16.r),
//                 topRight: Radius.circular(16.r),
//               ),
//             ),
//           ),
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               16.verticalSpace,
//               networkImageWithCached(
//                 size: Size(200.h, 200.h),
//                 url: e.image,
//                 borderRadius: 100,
//                 boxBorder: Border.all(color: primary900, width: 20),
//               ),
//               10.verticalSpace,
//               const Divider(color: grey200),
//               TextWidget(
//                   text: e.fullname ?? '',
//                   color: grey900,
//                   textStyle: textStyle16Bold),
//               const Divider(color: grey200),
//               TextWidget(
//                   text: e.age, color: grey900, textStyle: textStyle16Bold),
//               Lottie.asset('assets/animations/happy_birthday2.json',
//                   height: 200.h),
//               16.verticalSpace,
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

void showBirthdayDialog(
  BuildContext context, {
  String? title,
  required EmployeeModel e,
}) {
  Dialogs.materialDialog(
      lottieBuilder: Lottie.asset(
        "assets/animations/happy_birthday2.json",
        fit: BoxFit.contain,
      ),
      context: context,
      title: "Chúc mừng sinh nhật",
      titleAlign: TextAlign.center,
      titleStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          fontFamily: AppStrings.fontFamily,
          color: primary900),
      msgStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontFamily: AppStrings.fontFamily),
      msg: e.fullname ?? '',
      msgAlign: TextAlign.center,
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          text: 'Đóng',
          color: primary900,
          textStyle: const TextStyle(color: Colors.white),
        ),
      ]);
}
