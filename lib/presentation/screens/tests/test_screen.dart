// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/shared/enums/question_type.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'package:e_tmsc_app/data/models/test_model.dart';
import 'package:e_tmsc_app/logic/controllers/test/test_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/dialog/submit_dialog.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';

class TestScreen extends StatefulWidget {
  final TestModel testSelected;
  const TestScreen({
    Key? key,
    required this.testSelected,
  }) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> with WidgetsBindingObserver {
  int _pauseCount = 0;
  DateTime timeStart = DateTime.now();
  DateTime? timeEnd;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.paused) {
      _pauseCount++;
    }
  }

  void submit(TestController controller) {
    setState(() {
      timeEnd = DateTime.now();
    });
    controller.saveTest(
      context,
      startTime: timeStart,
      endTime: timeEnd,
      pause: _pauseCount,
      testSelected: widget.testSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: GetBuilder<TestController>(
          builder: (controller) {
            return Stack(
              children: [
                Column(
                  children: [
                    kToolbarHeight.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            20.horizontalSpace,
                            Image.asset(AppIcon.clock, scale: 3),
                            6.horizontalSpace,
                            Countdown(
                              seconds: widget.testSelected.timeLimit! * 60,
                              build: (BuildContext context, double time) =>
                                  Text(
                                time == 0
                                    ? 'Hết giờ'
                                    : Duration(seconds: time.toInt())
                                        .toString()
                                        .substring(2, 7),
                                style: textStyle15SemiBold.copyWith(
                                    color: (time > 30 || time == 0)
                                        ? black
                                        : Colors.red),
                              ),
                              interval: const Duration(milliseconds: 1000),
                              onFinished: () => submit(controller),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TextWidget(
                            text:
                                '${controller.currentIndex + 1}/${widget.testSelected.questions.length}',
                            color: grey500,
                            textStyle: textStyle15SemiBold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showSubmitDialog(
                              context,
                              message: 'Bạn có chắc chắn muốn nộp bài ?',
                              onSubmit: () => submit(controller),
                            );
                          },
                          child: TextWidget(
                            text: 'Nộp bài',
                            color: primary900,
                            textStyle: textStyle15SemiBold.copyWith(
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          PageView(
                            controller: controller.pageController,
                            children: List.generate(
                              widget.testSelected.questions.length,
                              (index) => TestBody(
                                question: widget.testSelected.questions[index],
                              ),
                            ),
                            onPageChanged: (value) {
                              setState(() {
                                controller.currentIndex = value;
                              });
                            },
                          ),
                          if (timeEnd != null) ...[
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.transparent,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Stack(
                    children: [
                      Container(
                        height: 60.h,
                        width: 390.w,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        decoration: BoxDecoration(
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.1),
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () =>
                                  controller.handleChangePagePressed(
                                      isNext: false,
                                      len:
                                          widget.testSelected.questions.length),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(AppIcon.previous1, scale: 3),
                                  10.horizontalSpace,
                                  TextWidget(
                                    text: 'Câu trước',
                                    color: primary900,
                                    textStyle: textStyle15SemiBold.copyWith(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  controller.handleChangePagePressed(
                                      isNext: true,
                                      len:
                                          widget.testSelected.questions.length),
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: 'Câu sau',
                                    color: primary900,
                                    textStyle: textStyle15SemiBold.copyWith(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  10.horizontalSpace,
                                  Image.asset(AppIcon.next1, scale: 3),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (timeEnd != null) ...[
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TestBody extends StatelessWidget {
  final QuestionModel question;
  const TestBody({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return question.type == QuestionType.choice
        ? TestCheckBox(data: question)
        : TestInput(data: question);
  }
}

class TestCheckBox extends StatefulWidget {
  final QuestionModel data;
  const TestCheckBox({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<TestCheckBox> createState() => _TestCheckBoxState();
}

class _TestCheckBoxState extends State<TestCheckBox> {
  click(int index) {
    setState(() {
      widget.data.answers[index].isSelected =
          !widget.data.answers[index].isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(top: 0),
        children: [
          if (widget.data.url != null) ...[
            networkImageWithCached(
                borderRadius: 6, size: Size(390.w, 0), url: widget.data.url),
            20.verticalSpace,
          ],
          TextWidget(
            text: widget.data.questionText,
            color: black,
            textStyle: textStyle16SemiBold,
            textAlign: TextAlign.left,
            maxLines: 100,
          ),
          24.verticalSpace,
          Column(
            children: List.generate(
              widget.data.answers.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () => click(index),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        widget.data.answers[index].isSelected
                            ? primary900
                            : const Color(0xffE6E6E6)),
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 18.w,
                      ),
                    ),
                    shadowColor: const WidgetStatePropertyAll(white),
                    foregroundColor: const WidgetStatePropertyAll(white),
                    surfaceTintColor: const WidgetStatePropertyAll(white),
                    elevation: const WidgetStatePropertyAll(0),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                          widget.data.answers[index].isSelected
                              ? AppIcon.checked
                              : AppIcon.unchecked,
                          scale: 3),
                      16.horizontalSpace,
                      Expanded(
                        child: TextWidget(
                          text: widget.data.answers[index].answerText,
                          color: widget.data.answers[index].isSelected
                              ? white
                              : black,
                          textStyle: textStyle15SemiBold.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TestInput extends StatefulWidget {
  final QuestionModel data;
  const TestInput({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<TestInput> createState() => _TestInputState();
}

class _TestInputState extends State<TestInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(top: 0),
        children: [
          if (widget.data.url != null) ...[
            networkImageWithCached(
                borderRadius: 6, size: Size(390.w, 0), url: widget.data.url),
            20.verticalSpace,
          ],
          TextWidget(
            text: widget.data.questionText,
            color: black,
            textStyle: textStyle16SemiBold,
            textAlign: TextAlign.left,
            maxLines: 100,
          ),
          24.verticalSpace,
          TextFormField(
            controller: widget.data.inputAnswer,
            maxLines: 10,
            cursorColor: primary900,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: primary900),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: primary900),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: primary900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
