// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_snackbar.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/services/service/auth_service.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';
import 'package:e_tmsc_app/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AuthController extends GetxController with StateMixin {
  final AuthService _authService;
  late final Rx<String?> codeResult;
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController emailSignUp;
  late final TextEditingController phoneSignUp;
  late final TextEditingController birthdaySignUp;
  late final TextEditingController passSignUp;
  late final TextEditingController passConfirmSignUp;
  late final FocusNode emailFocus;
  late final FocusNode passwordFocus;
  late final FocusNode emailSignUpFocus;
  late final FocusNode phoneSignUpFocus;
  late final FocusNode birthdaySignUpFocus;
  late final FocusNode passSignUpFocus;
  late final FocusNode passConfirmSignUpFocus;
  final Rx<bool> _isLoading = Rx(false);
  final _prefs = SharedPrefs();
  late DateTime birthdayPick = DateTime.now();

  Rx<EmployeeModel?> employee = Rx<EmployeeModel?>(null);

  AuthController(
    this._authService,
  );

  @override
  void onInit() {
    email = TextEditingController(text: "@tmsc-vn.com");
    password = TextEditingController();
    emailSignUp = TextEditingController(text: "@tmsc-vn.com");
    phoneSignUp = TextEditingController();
    birthdaySignUp = TextEditingController();
    passSignUp = TextEditingController();
    passConfirmSignUp = TextEditingController();

    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    emailSignUpFocus = FocusNode();
    phoneSignUpFocus = FocusNode();
    birthdaySignUpFocus = FocusNode();
    passSignUpFocus = FocusNode();
    passConfirmSignUpFocus = FocusNode();
    codeResult = Rx(null);
    super.onInit();
  }

  bool get isLoading => _isLoading.value;

  setLoading(bool isLoading) => _isLoading.value = isLoading;

  refeshData() {
    emailSignUp = TextEditingController(text: "@tmsc-vn.com");
    phoneSignUp = TextEditingController();
    birthdaySignUp = TextEditingController();
    passSignUp = TextEditingController();
    passConfirmSignUp = TextEditingController();
  }

  //get employee
  EmployeeModel? get getEmployee => employee.value;

  //set employee
  setEmployee(EmployeeModel e) => employee.value = e;

  //check login if has token
  Future logged(BuildContext context) async {
    String? token = _prefs.accessToken;
    await Future.delayed(const Duration(seconds: 1));
    if (token != null) {
      context.goNamed(AppRoute.home.name, extra: _prefs.role);
    } else {
      context.goNamed(AppRoute.login.name);
    }
  }

  changeBirth(DateTime value) {
    birthdaySignUp.text = '${value.day}-${value.month}-${value.year}';
    birthdayPick = value;
  }

  //login
  Future login(BuildContext context) async {
    try {
      String? validator = emailValidator(email.text.trim());
      if (validator == null) {
        setLoading(true);
        final res = await _authService.login(email: email.text);
        setLoading(false);
        if (res.isOk) {
          setEmployee(res.data);
          context.showSuccessMessage(res.status.responseMessage);
          context.goNamed(AppRoute.home.name, extra: _prefs.role);
        }
      } else {
        context.showErrorMessage(validator);
      }
    } catch (e) {
      setLoading(false);
      context.showErrorMessage(e.toString());
    }
  }
}
