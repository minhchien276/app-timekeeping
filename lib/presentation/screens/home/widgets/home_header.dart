import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 35.h),
      decoration: const BoxDecoration(
        color: primary900,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                AppIcon.avtIcon,
                scale: 3,
              ),
              12.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    text: 'Sơn sếch',
                    color: white,
                    textStyle: textStyle20Bold,
                  ),
                  TextWidget(
                    text: 'Welcome Back!',
                    color: white,
                    textStyle: textStyle14SemiBold,
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              AppIcon.notiIcon,
              scale: 3,
            ),
          ),
        ],
      ),
    );
  }
}
