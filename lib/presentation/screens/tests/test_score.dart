// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/test_model.dart';
import 'package:e_tmsc_app/logic/controllers/test/test_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TestScore extends StatefulWidget {
  final TestModel testSelected;
  const TestScore({
    Key? key,
    required this.testSelected,
  }) : super(key: key);

  @override
  State<TestScore> createState() => _TestScoreState();
}

class _TestScoreState extends State<TestScore> {
  final TestController testController = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      testController.getTestsScore(widget.testSelected.testId);
    });
    super.initState();
  }

  String formatScore(num? value) {
    return value == null ? '-' : value.toStringAsFixed(1).toString();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TestController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: const KBackButton(),
            backgroundColor: primary900,
            centerTitle: true,
            title: TextWidget(
              text: widget.testSelected.title ?? '',
              color: white,
              textStyle: textStyle17Bold,
              maxLines: 1,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: primary900,
                    border: Border.all(
                      color: grey200,
                    ),
                  ),
                  height: 40.h,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'STT',
                          style: textStyle10.copyWith(
                              color: white, fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const VerticalDivider(color: grey200),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'HỌ TÊN',
                          style: textStyle10.copyWith(
                              color: white, fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const VerticalDivider(color: grey200),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'TN',
                          style: textStyle10.copyWith(
                              color: white, fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const VerticalDivider(color: grey200),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'TL',
                          style: textStyle10.copyWith(
                              color: white, fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const VerticalDivider(color: grey200),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'TỔNG',
                          style: textStyle10.copyWith(
                              color: white, fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const VerticalDivider(color: grey200),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'LỖI',
                          style: textStyle10.copyWith(
                              color: white, fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: List.generate(
                    controller.testsScore.length,
                    (index) => Container(
                      decoration: BoxDecoration(
                        border: const Border(
                          bottom: BorderSide(color: grey200),
                          left: BorderSide(color: grey200),
                          right: BorderSide(color: grey200),
                        ),
                        color: index % 2 != 0 ? primary200 : white,
                      ),
                      height: 50.h,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              (index + 1).toString(),
                              style: textStyle10.copyWith(
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const VerticalDivider(color: grey200),
                          Expanded(
                            flex: 3,
                            child: Text(
                              controller.testsScore[index].fullname ?? '',
                              style: textStyle10.copyWith(
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const VerticalDivider(color: grey200),
                          Expanded(
                            flex: 1,
                            child: Text(
                              formatScore(
                                  controller.testsScore[index].scoreChoice),
                              style: textStyle10.copyWith(
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const VerticalDivider(color: grey200),
                          Expanded(
                            flex: 1,
                            child: Text(
                              formatScore(
                                  controller.testsScore[index].scoreEssay),
                              style: textStyle10.copyWith(
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const VerticalDivider(color: grey200),
                          Expanded(
                            flex: 1,
                            child: Text(
                              formatScore(((controller
                                          .testsScore[index].scoreEssay ??
                                      0) +
                                  (controller.testsScore[index].scoreChoice ??
                                      0))),
                              style: textStyle10.copyWith(
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const VerticalDivider(color: grey200),
                          Expanded(
                            flex: 1,
                            child: Text(
                              (controller.testsScore[index].pause ?? '-')
                                  .toString(),
                              style: textStyle10.copyWith(
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                60.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
