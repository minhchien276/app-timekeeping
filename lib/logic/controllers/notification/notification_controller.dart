import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/data/models/notification_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_snackbar.dart';
import 'package:e_tmsc_app/presentation/widgets/dialog/new_employee_dialog.dart';
import 'package:e_tmsc_app/presentation/widgets/loading/loading.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/services/service/application_service.dart';
import 'package:e_tmsc_app/services/service/blog_service.dart';
import 'package:e_tmsc_app/services/service/employee_service.dart';
import 'package:e_tmsc_app/services/service/notification_service.dart';
import 'package:e_tmsc_app/services/service/test_service.dart';
import 'package:e_tmsc_app/shared/enums/notification_enum.dart';
import 'package:e_tmsc_app/shared/enums/user_enum.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/fetch_api/fetch_utils.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

import '../../../utils/app_string.dart';
import '../../../utils/color.dart';

class NotificationController extends FetchUtils<NotificationModel> {
  NotificationController({
    required super.fetchApi,
    required super.size,
    super.isLoadmoreEnabled,
  });

  ScrollController get scrollController => scroll;
  final notiService = NotificationService();
  final appService = ApplicationService();
  final blogService = BlogService();
  final testService = TestService();
  final employeeService = EmployeeService();
  final _prefs = SharedPrefs();
  Map<DateTime, List<NotificationModel>> get mapped => _mapping();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetch();
    });
  }

  _mapping() {
    Map<DateTime, List<NotificationModel>> map = {};
    for (var e in data) {
      var key = e.createdAt!.startTime();
      if (map[key] != null) {
        map[key]!.add(e);
      } else {
        map[key] = [e];
      }
    }
    return map;
  }

  handleRefreshPressed() async => await refreshing();

  handleSeen(NotificationModel item) async {
    if (item.seen == 0) {
      final res = await notiService.updateSeen({
        'id': item.id,
        'receiverId': item.receiverId,
      });
      if (res.isOk) {
        for (var e in data) {
          if (item.id == e.id) {
            e.seen = 1;
          }
        }
        update(data);
      }
    }
  }

  handleNextDetail(
    BuildContext context,
    NotificationModel item,
  ) async {
    try {
      Loading().show(context: context);
      switch (item.type) {
        case NotificationType.salary:
          final res =
              await employeeService.getSalaryByNotification(item.applicationId);
          Loading().hide();
          if (res.isOk) {
            if (!context.mounted) return;
            context.pushNamed(AppRoute.salaryDetail.name, extra: res.data);
          }
          break;
        case NotificationType.newEmployee:
          final res =
              await employeeService.getEmployeeDetails(id: item.applicationId!);
          Loading().hide();
          if (res.isOk) {
            if (!context.mounted) return;
            showNewEmployeeDialog(context,
                e: EmployeeModel.fromMap(res.data['employee']));
          }
          break;
        case NotificationType.normal:
          Loading().hide();
          // context.pushNamed(
          //   AppRoute.notiDetails.name,
          //   extra: item,
          // );
          Dialogs.materialDialog(
              lottieBuilder: Lottie.asset(
                "assets/animations/animation.json",
                fit: BoxFit.contain,
              ),
              context: context,
              title: item.notiTitle,
              titleAlign: TextAlign.center,
              titleStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  fontFamily: AppStrings.fontFamily,
                  color: primary900),
              msg: item.notiContent,
              msgAlign: TextAlign.center,
              actions: [
                IconsButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  text: 'Đóng',
                  color: primary900,
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ]);
          break;
        case NotificationType.blog:
          final res = await blogService.getBlogDetail(item.applicationId!);
          Loading().hide();
          if (res.isOk) {
            if (!context.mounted) return;
            context.pushNamed(
              AppRoute.postDetail.name,
              extra: res.data,
            );
          }
          break;
        case NotificationType.application:
          final res =
              await appService.getApplicationDetail(item.applicationId!);
          Loading().hide();
          if (res.isOk) {
            if (!context.mounted) return;
            handleSeen(item);
            context.pushNamed(
              AppRoute.applicationDetail.name,
              extra: {
                'item': res.data,
                'userEnum': res.data.employee?.id == _prefs.id
                    ? UserEnum.my
                    : UserEnum.other
              },
            );
          }
          break;
        case NotificationType.testDetail:
          final res = await testService.getTestDetail(item.applicationId!);
          Loading().hide();
          if (res.isOk) {
            if (!context.mounted) return;
            handleSeen(item);
            if (res.isOk) {
              AppNavigator.router
                  .pushNamed(AppRoute.testDetail.name, extra: res.data);
            }
          }
          break;
        default:
          Loading().hide();
      }
    } catch (e) {
      Loading().hide();
      if (!context.mounted) return;
      context.showErrorMessage(e.toString());
      debugPrint('handleNextDetail: $e');
    }
  }
}
