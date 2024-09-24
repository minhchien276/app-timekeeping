import 'package:e_tmsc_app/logic/controllers/auth/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/go_routes.dart';
import '../../../utils/app_icon.dart';
import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../widgets/common/common_custom_text.dart';
import '../../widgets/common/common_loader_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passwordVisible = false;
  bool passConfirmVisible = false;

  final AuthController controller = Get.find();
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    passConfirmVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
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
                      controller: controller.phoneSignUp,
                      focusNode: controller.phoneSignUpFocus,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Số điện thoại',
                        hintStyle: textStyle13.copyWith(
                            color: const Color(0xff98A2B3)),
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
                            AppIcon.phone,
                            scale: 3,
                          ),
                        ),
                      ),
                      onTapOutside: (_) =>
                          controller.phoneSignUpFocus.unfocus(),
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
                      controller: controller.emailSignUp,
                      focusNode: controller.emailSignUpFocus,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: textStyle13.copyWith(
                            color: const Color(0xff98A2B3)),
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
                      onTapOutside: (_) =>
                          controller.emailSignUpFocus.unfocus(),
                    ),
                  ),
                  24.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) => Container(
                                height: 400.h,
                                color: CupertinoColors.systemBackground
                                    .resolveFrom(context),
                                child: CupertinoDatePicker(
                                  initialDateTime:
                                      controller.birthdaySignUp.text == ""
                                          ? DateTime.now()
                                          : controller.birthdayPick,
                                  mode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged: (DateTime value) =>
                                      controller.changeBirth(value),
                                ),
                              ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: neutral200),
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
                      child: GestureDetector(
                        child: TextFormField(
                          enabled: false,
                          readOnly: true,
                          controller: controller.birthdaySignUp,
                          focusNode: controller.birthdaySignUpFocus,
                          decoration: InputDecoration(
                            hintText: 'Năm sinh',
                            hintStyle: textStyle13.copyWith(
                                color: const Color(0xff98A2B3)),
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
                                AppIcon.birthday,
                                scale: 3.5,
                              ),
                            ),
                          ),
                          onTapOutside: (_) =>
                              controller.birthdaySignUpFocus.unfocus(),
                          onFieldSubmitted: (_) => controller.login(context),
                        ),
                      ),
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
                      controller: controller.passSignUp,
                      focusNode: controller.passSignUpFocus,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Mật khẩu',
                        hintStyle: textStyle13.copyWith(
                            color: const Color(0xff98A2B3)),
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
                      onTapOutside: (_) => controller.passSignUpFocus.unfocus(),
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
                      obscureText: passConfirmVisible,
                      controller: controller.passConfirmSignUp,
                      focusNode: controller.passConfirmSignUpFocus,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: 'Nhập lại mật khẩu',
                        hintStyle: textStyle13.copyWith(
                            color: const Color(0xff98A2B3)),
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
                                passConfirmVisible = !passConfirmVisible;
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: passConfirmVisible
                                ? Image.asset(AppIcon.passWordNotShow,
                                    scale: 3.5, color: const Color(0xff98A2B3))
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
                            text: 'Đăng ký',
                            isLoading: controller.isLoading,
                            onTap: () {},
                          ),
                  ),
                  24.verticalSpace,
                  RichText(
                    text: TextSpan(
                        text: "Bạn đã có tài khoản?",
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff98A2B3)),
                        children: [
                          TextSpan(
                              text: ' Đăng nhập',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pushNamed(AppRoute.login.name);
                                },
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: primary900))
                        ]),
                  ),
                  60.verticalSpace,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
