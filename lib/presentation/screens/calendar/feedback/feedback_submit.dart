import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_loader_button.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedbackSubmitScreen extends StatefulWidget {
  const FeedbackSubmitScreen({super.key});

  @override
  State<FeedbackSubmitScreen> createState() => _FeedbackSubmitScreenState();
}

class _FeedbackSubmitScreenState extends State<FeedbackSubmitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primary900,
        leading: const KBackButton(),
        centerTitle: true,
        title: TextWidget(
          text: 'Phản hồi',
          color: white,
          textStyle: textStyle17Bold,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView(
          children: [
            70.verticalSpace,
            inputItem(
                label: 'Tên loại đơn', controller: TextEditingController()),
            16.verticalSpace,
            inputItem(
                label: 'Ngày bắt đầu (Giờ bắt đầu)',
                controller: TextEditingController()),
            16.verticalSpace,
            inputItem(
                label: 'Ngày kết thúc (Giờ kết thúc)',
                controller: TextEditingController()),
            16.verticalSpace,
            inputItem(label: 'Bộ phận', controller: TextEditingController()),
            16.verticalSpace,
            inputItem(
                label: 'Lí do',
                maxLines: 7,
                controller: TextEditingController()),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                    child: LoaderButton(
                  onTap: () {},
                  text: 'Huỷ bỏ',
                  isLoading: false,
                  size: Size(double.maxFinite, 40.h),
                  color: neutral200,
                  textColor: neutral600,
                )),
                8.horizontalSpace,
                Expanded(
                    child: LoaderButton(
                  onTap: () {},
                  text: 'Nộp đơn',
                  isLoading: false,
                  size: Size(double.maxFinite, 40.h),
                )),
              ],
            ),
            50.verticalSpace,
          ],
        ),
      ),
    );
  }
}

Widget inputItem({
  required String label,
  required TextEditingController controller,
  FocusNode? focusNode,
  int? maxLines,
  bool isPicker = false,
}) =>
    TextFormField(
      enabled: !isPicker,
      maxLines: maxLines,
      cursorColor: primary900,
      readOnly: isPicker,
      focusNode: focusNode,
      controller: controller,
      style: textStyle16SemiBold.copyWith(color: black),
      decoration: InputDecoration(
        label: TextWidget(
          text: label,
          color: black,
          textStyle: textStyle14SemiBold.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        suffixIcon: isPicker ? Image.asset(AppIcon.downIcon, scale: 2.5) : null,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: textStyle15SemiBold,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: primary900),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: primary900),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: primary900),
        ),
      ),
      onTapOutside: (_) => focusNode?.unfocus(),
      // onFieldSubmitted: (_) => _authController.loginWithInput(context),
    );
