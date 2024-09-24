import 'package:e_tmsc_app/logic/controllers/auth/auth_controller.dart';
import 'package:e_tmsc_app/services/service/auth_service.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(AuthService()));
  }
}
