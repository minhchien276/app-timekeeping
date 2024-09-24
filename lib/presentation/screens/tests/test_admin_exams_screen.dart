import 'package:e_tmsc_app/data/models/test_model.dart';
import 'package:e_tmsc_app/logic/controllers/test/test_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/presentation/widgets/loading/loading_circle.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class TestAdminExamsScreen extends StatefulWidget {
  const TestAdminExamsScreen({super.key});

  @override
  State<TestAdminExamsScreen> createState() => _TestAdminExamsScreenState();
}

class _TestAdminExamsScreenState extends State<TestAdminExamsScreen> {
  final TestController testController = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      testController.getAdminTests();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const KBackButton(),
        backgroundColor: primary900,
        centerTitle: true,
        title: TextWidget(
          text: 'Kiểm tra kiến thức chuyên môn',
          color: white,
          textStyle: textStyle17Bold,
          maxLines: 1,
        ),
      ),
      body: GetBuilder<TestController>(
        builder: (controller) {
          return controller.isLoading
              ? const Center(child: LoadingCircle(color: primary900))
              : controller.tests.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppIcon.iconNotItem,
                          scale: 1.2,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "KHÔNG CÓ BÀI KIỂM TRA NÀO!!!",
                              style: TextStyle(
                                color: black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))
                  : Container(
                      margin:
                          EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: controller.testsAdmin.length,
                        itemBuilder: (context, index) {
                          final test = controller.testsAdmin[index];
                          return _item(
                            item: test,
                            onTap: () => context.pushNamed(
                                AppRoute.testDetail.name,
                                extra: test),
                          );
                        },
                      ),
                    );
        },
      ),
    );
  }

  _item({
    required TestModel item,
    required VoidCallback onTap,
  }) =>
      Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Ink(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.1),
                    blurRadius: 30,
                    spreadRadius: 1,
                    offset: const Offset(0, -1),
                  )
                ],
              ),
              child: Row(
                children: [
                  Image.asset(AppIcon.book, scale: 3),
                  16.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: item.title ?? '',
                          color: black,
                          textStyle: textStyle15SemiBold,
                          maxLines: 5,
                        ),
                        4.verticalSpace,
                        RichText(
                          text: TextSpan(
                            text: item.description ?? '',
                            style: textStyle10.copyWith(color: black),
                            children: [
                              TextSpan(
                                text: formatDateSlash(item.createdAt),
                                style: textStyle10.copyWith(color: grey400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.horizontalSpace,
                  Image.asset(AppIcon.next, scale: 3),
                ],
              ),
            ),
          ),
          12.verticalSpace,
        ],
      );
}
