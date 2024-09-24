// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/test_model.dart';
import 'package:e_tmsc_app/logic/controllers/test/test_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_submit_button.dart';
import 'package:e_tmsc_app/shared/enums/question_type.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TestDetailScreen extends StatefulWidget {
  final TestModel testSelected;
  const TestDetailScreen({
    Key? key,
    required this.testSelected,
  }) : super(key: key);

  @override
  State<TestDetailScreen> createState() => _TestDetailScreenState();
}

class _TestDetailScreenState extends State<TestDetailScreen> {
  List<int> count(TestModel test) {
    int choiceCount = 0;
    int essayCount = 0;
    for (var e in test.questions) {
      if (e.type == QuestionType.choice) {
        choiceCount++;
      } else {
        essayCount++;
      }
    }
    return [choiceCount, essayCount];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: const KBackButton(),
        backgroundColor: white,
        centerTitle: true,
        title: TextWidget(
          text: 'Kiểm tra kiến thức chuyên môn',
          color: primary900,
          textStyle: textStyle17Bold,
        ),
      ),
      body: GetBuilder<TestController>(
        builder: (controller) {
          TestModel test = widget.testSelected;
          return Container(
            margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AppImage.testImage),
                25.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppIcon.book,
                          scale: 4,
                          color: primary900,
                        ),
                        6.horizontalSpace,
                        TextWidget(
                          text: '${test.questions.length} câu hỏi',
                          color: grey400,
                          textStyle: textStyle12,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          AppIcon.clock,
                          scale: 4,
                          color: primary900,
                        ),
                        6.horizontalSpace,
                        TextWidget(
                          text: '${test.timeLimit} phút',
                          color: grey400,
                          textStyle: textStyle12,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          AppIcon.expired,
                          scale: 4,
                          color: primary900,
                        ),
                        6.horizontalSpace,
                        TextWidget(
                          text: formatDateTimeSlash(test.expired),
                          color: grey400,
                          textStyle: textStyle12,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                20.verticalSpace,
                TextWidget(
                  text: test.title ?? '',
                  color: black,
                  textStyle: textStyle16Bold,
                ),
                10.verticalSpace,
                // if (test.description != null) ...[
                //   TextWidget(
                //     text: test.description ?? '',
                //     color: grey700,
                //     textStyle: textStyle14SemiBold.copyWith(
                //       fontWeight: FontWeight.w400,
                //     ),
                //     maxLines: 100,
                //   ),
                // ],
                TextWidget(
                  text:
                      'Bao gồm ${test.questions.length} câu hỏi, trong đó có ${count(test)[1]} câu tự luận và ${count(test)[0]} câu trắc nghiệm. Các nhân viên làm bài kiểm tra trong vòng ${test.timeLimit} phút, không được sử dụng tài liệu dưới bất kỳ hình thức nào.\nĐiểm số sẽ được cập nhật sau 2 tiếng !',
                  color: grey700,
                  textStyle: textStyle14SemiBold.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 100,
                ),
                60.verticalSpace,
                SubmitButton(
                  onTap: () =>
                      controller.beginTest(context, widget.testSelected),
                  text: test.isExpired() ? 'XEM ĐIỂM' : 'BẮT ĐẦU ',
                  isLoading: false,
                  size: const Size(390, 40),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
