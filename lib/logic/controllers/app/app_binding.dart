import 'package:e_tmsc_app/logic/controllers/application/approve_application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/application/my_application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/application/pending_application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/application/people_application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/auth/auth_controller.dart';
import 'package:e_tmsc_app/logic/controllers/home/home_admin_controller.dart';
import 'package:e_tmsc_app/logic/controllers/home/home_client_controller.dart';
import 'package:e_tmsc_app/logic/controllers/test/test_controller.dart';
import 'package:e_tmsc_app/logic/controllers/work/word_detail_controller.dart';
import 'package:e_tmsc_app/logic/controllers/work/work_controller.dart';
import 'package:e_tmsc_app/logic/controllers/work/work_room_approve_controller.dart';
import 'package:e_tmsc_app/logic/controllers/work/work_room_pending_controller.dart';
import 'package:e_tmsc_app/services/networking/api_service.dart';
import 'package:e_tmsc_app/services/service/application_service.dart';
import 'package:e_tmsc_app/services/service/auth_service.dart';
import 'package:e_tmsc_app/services/service/work_service.dart';
import 'package:e_tmsc_app/shared/enums/role_enum.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  final _prefs = SharedPrefs();

  @override
  void dependencies() {
    Get.put(ApiService(), permanent: true);
    Get.put(AuthController(AuthService()));
    Get.put(TestController());
    Get.lazyPut(() => HomeClientController());
    Get.lazyPut(() => HomeAdminController());
    Get.put(WorkController());
    Get.put(WorkDetailController());
    Get.put(MyApplicationController(
      fetchApi: (int page) async => _prefs.role == RoleEnum.client
          ? await ApplicationService()
              .getApplicationById(page)
              .then((value) => value.data)
          : [],
      size: 20,
      isLoadmoreEnabled: true,
    ));

    Get.put(PeopleApplicationController(
      fetchApi: (int page) async => _prefs.role == RoleEnum.client
          ? await ApplicationService()
              .getPeopleApplication(page)
              .then((value) => value.data)
          : [],
      size: 20,
      isLoadmoreEnabled: true,
    ));
    Get.put(ApproveApplicationController(
      fetchApi: (int page) async => _prefs.role == RoleEnum.admin
          ? await ApplicationService()
              .getApproveApplication(page)
              .then((value) => value.data)
          : [],
      size: 20,
      isLoadmoreEnabled: true,
    ));

    Get.put(PendingApplicationController(
      fetchApi: (int page) async => _prefs.role == RoleEnum.admin
          ? await ApplicationService()
              .getPendingApplication(page)
              .then((value) => value.data)
          : [],
      size: 20,
      isLoadmoreEnabled: true,
    ));

    Get.put(WorkRoomApproveController(
      fetchApi: (int page) async =>
          await WorkService().getRoomApproved(page).then((value) => value.data),
      size: 10,
      isLoadmoreEnabled: true,
    ));

    Get.put(WorkRoomPendingController(
      fetchApi: (int page) async =>
          await WorkService().getRoomPending(page).then((value) => value.data),
      size: 10,
      isLoadmoreEnabled: true,
    ));
  }
}
