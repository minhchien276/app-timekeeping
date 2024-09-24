// ignore_for_file: use_build_context_synchronously

import 'package:e_tmsc_app/logic/controllers/auth/auth_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController controller = Get.find();

  @override
  void initState() {
    controller.logged(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: primary900,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppIcon.logoAppSplash, scale: 3),
            24.verticalSpace,
            TextWidget(
              text: 'E-TMSC',
              color: white,
              textStyle: textStyle38Bold,
            ),
          ],
        ),
      ),
    );
  }
}
