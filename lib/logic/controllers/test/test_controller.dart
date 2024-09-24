import 'package:e_tmsc_app/data/models/test_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_snackbar.dart';
import 'package:e_tmsc_app/presentation/widgets/dialog/submit_dialog.dart';
import 'package:e_tmsc_app/presentation/widgets/loading/loading.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/services/service/test_service.dart';
import 'package:e_tmsc_app/shared/enums/question_type.dart';
import 'package:e_tmsc_app/shared/typedef.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class TestController extends GetxController {
  final testService = TestService();
  final _loadingRx = Rx<bool>(false);
  final _testsRx = Rx<List<TestModel>>([]);
  final _testsAdminRx = Rx<List<TestModel>>([]);
  final _testsScoreRx = Rx<List<TestModel>>([]);

  PageController pageController = PageController();
  int currentIndex = 0;

  bool get isLoading => _loadingRx.value;
  List<TestModel> get tests => _testsRx.value;
  List<TestModel> get testsAdmin => _testsAdminRx.value;
  List<TestModel> get testsScore => _testsScoreRx.value;

  setLoading(bool value) {
    _loadingRx.value = value;
    update();
  }

  handleChangePagePressed({required bool isNext, required int len}) {
    int tmp = currentIndex;
    if (isNext) {
      if (currentIndex < len - 1) {
        currentIndex++;
      }
    } else {
      if (currentIndex != 0) {
        currentIndex--;
      }
    }
    if (tmp != currentIndex) {
      pageController.jumpToPage(currentIndex);
    }
  }

  getEmployeeTests() async {
    try {
      setLoading(true);
      final res = await testService.getEmployeeTests();
      if (res.isOk) {
        _testsRx.value = res.data;
      }
      setLoading(false);
    } catch (e) {
      setLoading(false);
      debugPrint('getEmployeeTests ${e.toString()}');
    }
  }

  getAdminTests() async {
    try {
      setLoading(true);
      final res = await testService.getAdminTests();
      if (res.isOk) {
        _testsAdminRx.value = res.data;
      }
      setLoading(false);
    } catch (e) {
      setLoading(false);
      debugPrint('getAdminTests ${e.toString()}');
    }
  }

  beginTest(BuildContext context, TestModel testSelected) async {
    try {
      if (testSelected.isExpired()) {
        context.pushNamed(AppRoute.testScore.name, extra: testSelected);
      } else {
        showSubmitDialog(
          context,
          message: 'Bạn đã đã sẵn sàng để làm bài ?',
          onSubmit: () async {
            Loading().show(context: context);
            final res =
                await testService.beginTest(testSelected.employeeTestId);
            Loading().hide();
            if (res.isOk) {
              context.pushNamed(AppRoute.test.name, extra: testSelected);
            }
          },
        );
      }
    } catch (e) {
      Loading().hide();
      context.showErrorMessage(e.toString());
    }
  }

  saveTest(
    BuildContext context, {
    required DateTime startTime,
    required int pause,
    DateTime? endTime,
    required TestModel testSelected,
  }) async {
    try {
      Loading().show(context: context);
      List<JSON> data = calculate(testSelected);
      final res = await testService.saveEmployeeTest({
        'testId': testSelected.testId,
        'employeeTestId': testSelected.employeeTestId,
        'pause': pause,
        'startTime': startTime.millisecondsSinceEpoch,
        'endTime': (endTime ?? DateTime.now()).millisecondsSinceEpoch,
        'data': data,
      });
      Loading().hide();
      if (res.isOk) {
        updateStatus(testSelected);
        context.showSuccessMessage(res.status.message);
        context.pop();
      }
    } catch (e) {
      Loading().hide();
      context.showErrorMessage(e.toString());
    }
  }

  getTestsScore(int testId) async {
    try {
      setLoading(true);
      final res = await testService.getTestsScore(testId);
      if (res.isOk) {
        _testsScoreRx.value = res.data;
        _testsScoreRx.value.sort((b, a) =>
            ((a.scoreChoice ?? 0) + (a.scoreEssay ?? 0))
                .compareTo(((b.scoreChoice ?? 0) + (b.scoreEssay ?? 0))));
      }
      setLoading(false);
    } catch (e) {
      setLoading(false);
      debugPrint('getTestsScore ${e.toString()}');
    }
  }

  updateStatus(TestModel testSelected) {
    testSelected.status = true;
    for (var test in _testsRx.value) {
      if (testSelected.testId == test.testId) {
        test.status = true;
      }
    }
    update();
  }

  List<JSON> calculate(TestModel testSelected) {
    List<JSON> data = [];
    for (var item in testSelected.questions) {
      if (item.type == QuestionType.choice) {
        int correctAnswerCount =
            item.answers.where((e) => e.isCorrect == true).length;
        double scorePerAnswer = item.marks / correctAnswerCount;
        int tmp = 0;
        List<int> selectedAnswerId = [];

        for (var answer in item.answers) {
          if (answer.isSelected) {
            if (answer.isCorrect == true) {
              tmp++;
            } else {
              tmp--;
            }
            selectedAnswerId.add(answer.answerId);
          }
        }
        //if false better true always 0
        double score = ((tmp < 0) ? 0 : tmp) * scorePerAnswer;
        data.add({
          'questionId': item.questionId,
          'type': item.type.parseId(),
          'selectedAnswerId': selectedAnswerId,
          'score': score.toStringAsFixed(1),
        });
      } else {
        data.add({
          'questionId': item.questionId,
          'type': item.type.parseId(),
          'inputAnswer': item.inputAnswer.text,
        });
      }
    }
    return data;
  }
}
