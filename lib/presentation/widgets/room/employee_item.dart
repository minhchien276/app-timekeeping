import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildEmployeeCheckbox({
  required VoidCallback onAdd,
  required EmployeeModel employee,
  required bool checked,
}) {
  return InkWell(
    onTap: onAdd,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                networkImageWithCached(
                  size: Size(36.h, 36.h),
                  url: employee.image,
                  boxBorder: Border.all(color: primary900, width: 1),
                ),
                14.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: employee.fullname ?? '',
                        color: grey700,
                        textStyle: textStyle14SemiBold,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Checkbox(
            activeColor: primary900,
            side: const BorderSide(color: grey500, width: 2),
            tristate: true,
            value: checked,
            onChanged: (bool? value) => {},
          ),
        ],
      ),
    ),
  );
}

Widget buildEmployeeSelected({
  required VoidCallback onRemove,
  required EmployeeModel employee,
}) {
  return SizedBox(
    height: 80.h,
    width: 70.h,
    child: Column(
      children: [
        Stack(
          children: [
            networkImageWithCached(
              size: Size(50.h, 50.h),
              url: employee.image,
              borderRadius: 100,
              boxBorder: Border.all(color: primary900, width: 1),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: onRemove,
                child: Container(
                  decoration: BoxDecoration(
                      color: black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(100)),
                  padding: const EdgeInsets.all(2),
                  child: Icon(
                    Icons.close_rounded,
                    size: 12.h,
                    color: white,
                  ),
                ),
              ),
            ),
          ],
        ),
        6.verticalSpace,
        TextWidget(
          text: employee.lastName,
          color: black,
          textStyle: textStyle10,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
