import 'dart:convert';

import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/services/models/api_auth.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';
import 'package:e_tmsc_app/services/networking/api_service.dart';
import 'package:e_tmsc_app/services/networking/api_url.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';

abstract class BaseAuthService {
  Future<LoginResponse> login({required String email});

  Future<EmployeeModel?> refreshToken();

  Future logout();
}

class AuthService implements BaseAuthService {
  final _apiService = ApiService();
  final _prefs = SharedPrefs();
  AuthService._();
  static final AuthService _instance = AuthService._();
  factory AuthService() => _instance;

  @override
  Future<LoginResponse> login({required String email}) async {
    final response = await _apiService.post(
      endpoint: ApiUrl.login,
      body: {'email': email, 'device_token': _prefs.fcm},
    );
    return LoginResponse(
      status: ApiResponseStatus.fromMap(response.data),
      data: EmployeeModel.fromJson(jsonEncode(response.data['data'])),
    );
  }

  @override
  Future<EmployeeModel?> refreshToken() async {
    final response = await _apiService.post(
      endpoint: ApiUrl.refreshToken,
      body: {'refresh_token': SharedPrefs().refreshToken},
    );
    if (response != null) {
      EmployeeModel e =
          EmployeeModel.fromJson(jsonEncode(response.data['data']));
      await _prefs.insertId(e.id!);
      await _prefs.insertToken(response[_prefs.accessTokenKey]);
      await _prefs.insertRefreshToken(response[_prefs.refreshTokenKey]);
      await _prefs.insertExpired(DateTime.now()
          .add(Duration(seconds: response[_prefs.expiresInKey]))
          .millisecondsSinceEpoch);
      return e;
    }
    return null;
  }

  @override
  Future logout() async {
    await _apiService.post(endpoint: ApiUrl.logout);
  }
}
