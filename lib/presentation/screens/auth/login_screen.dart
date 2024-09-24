// ignore_for_file: use_build_context_synchronously
import 'package:e_tmsc_app/logic/controllers/auth/auth_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_loader_button.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;
  bool isChecked = false;

  final AuthController controller = Get.find();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                60.verticalSpace,
                Image.asset(AppIcon.logoAppYellow),
                12.verticalSpace,
                TextWidget(
                  text: 'E-TMSC',
                  color: primary900,
                  textStyle: textStyle38Bold,
                ),
                36.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: black.withOpacity(0.05),
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                          offset: const Offset(
                            3.0, // Move to right 10  horizontally
                            3.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ]),
                  child: TextFormField(
                    controller: controller.email,
                    focusNode: controller.emailFocus,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle:
                          textStyle13.copyWith(color: const Color(0xff98A2B3)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: primary900),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: neutral200),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Image.asset(
                          AppIcon.mailLogin,
                          scale: 3.5,
                        ),
                      ),
                    ),
                    onTapOutside: (_) => controller.emailFocus.unfocus(),
                  ),
                ),
                24.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: black.withOpacity(0.05),
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                          offset: const Offset(
                            3.0, // Move to right 10  horizontally
                            3.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ]),
                  child: TextFormField(
                    obscureText: passwordVisible,
                    controller: controller.password,
                    focusNode: controller.passwordFocus,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Mật khẩu',
                      hintStyle:
                          textStyle13.copyWith(color: const Color(0xff98A2B3)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: primary900),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: neutral200),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Image.asset(
                          AppIcon.password,
                          scale: 1,
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w, right: 10.w),
                          child: passwordVisible
                              ? Image.asset(
                                  AppIcon.passWordNotShow,
                                  scale: 3.5,
                                  color: const Color(0xff98A2B3),
                                )
                              : Image.asset(
                                  AppIcon.passShow,
                                  scale: 3.5,
                                  color: const Color(0xff98A2B3),
                                ),
                        ),
                      ),
                    ),
                    onTapOutside: (_) => controller.passwordFocus.unfocus(),
                  ),
                ),
                12.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          side: const BorderSide(
                              color: Color(0xff98A2B3), width: 1.5),
                          activeColor: primary900,
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        TextWidget(
                          text: "Nhớ mật khẩu",
                          color: const Color(0xff98A2B3),
                          fontWeight: FontWeight.w500,
                          size: 12.sp,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: TextWidget(
                        text: "Quên mật khẩu?",
                        color: const Color(0xff98A2B3),
                        fontWeight: FontWeight.w500,
                        size: 12.sp,
                      ),
                    )
                  ],
                ),
                60.verticalSpace,
                Obx(
                  () => controller.isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          backgroundColor: primary900,
                          strokeWidth: 5,
                        )
                      : LoaderButton(
                          size: Size(double.maxFinite, 50.h),
                          onTap: () => controller.login(context),
                          text: 'Đăng nhập',
                          isLoading: controller.isLoading,
                        ),
                ),
                24.verticalSpace,
                RichText(
                  text: TextSpan(
                      text: "Bạn chưa có tài khoản?",
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff98A2B3)),
                      children: [
                        TextSpan(
                            text: ' Đăng ký ngay',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.pushNamed(AppRoute.signup.name);
                              },
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: primary900))
                      ]),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
