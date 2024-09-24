import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/services/networking/api_url.dart';
import 'package:e_tmsc_app/utils/internet_connection.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class BaseService {
  BaseService._();
  static final _instance = BaseService._();
  static BaseService get instance => _instance;

  static const baseUrl = ApiUrl.baseUrl;
  final _prefs = SharedPrefs();

  late final Dio _dio;
  Dio get dio => _dio;

  initalize() {
    if (_prefs.accessToken != null) {
      _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: {'Authorization': 'Bearer ${_prefs.accessToken}'}));
    } else {
      _dio = Dio(BaseOptions(baseUrl: baseUrl));
    }

    _dio.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        options.connectTimeout = const Duration(milliseconds: 10000);
        options.receiveTimeout = const Duration(milliseconds: 10000);

        //check all
        if (_prefs.accessToken == null ||
            _prefs.timeExpired == null ||
            _prefs.refreshToken == null) {
          return handler.next(options);
        }

        final isExpired = DateTime.now()
            .isAfter(DateTime.fromMillisecondsSinceEpoch(_prefs.timeExpired!));

        //check time expired to refresh token
        if (isExpired) {
          try {
            final response =
                await dio.post(ApiUrl.refreshToken, data: _prefs.refreshToken);
            if (HttpStatus(response.statusCode).isOk) {
              if (response.data != null) {
                final expiredTime = DateTime.now()
                    .add(Duration(seconds: response.data[_prefs.expiresInKey]));
                _prefs.insertExpired(expiredTime.millisecondsSinceEpoch);
                _prefs.insertToken(response.data[_prefs.accessTokenKey]);
              }
            } else if (HttpStatus(response.statusCode).isForbidden) {
              _prefs.logout();
              AppNavigator.router.goNamed(AppRoute.login.name);
            }
          } on DioException catch (e) {
            return handler.reject(e, true);
          }
        } else {
          bool connected = InternetStatusListener.getInstance().hasConnection;
          if (connected) {
            return handler.next(options);
          } else {
            RequestStatusListener.getInstance().disconnect();
            return handler.reject(DioException.connectionError(
                requestOptions: RequestOptions(), reason: disconnnectMessage));
          }
        }
      },
      onResponse: (response, handler) async {
        debugPrint(response.requestOptions.path);
        if (response.requestOptions.path == ApiUrl.login) {
          await interceptor(response);
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        if (error.response != null) {
          if (HttpStatus(error.response!.statusCode).isForbidden) {
            _prefs.logout();
            AppNavigator.router.goNamed(AppRoute.login.name);
          }
        }
        return handler.next(error);
      },
    ));

    _dio.interceptors.add(
        PrettyDioLogger(request: true, requestBody: true, requestHeader: true));
  }

  interceptor(dynamic response) async {
    EmployeeModel e = EmployeeModel.fromJson(jsonEncode(response.data['data']));
    await _prefs.insertId(e.id!);
    await _prefs.insertRole(e.roleId!);
    await _prefs.insertToken(response.data[_prefs.accessTokenKey]);
    await _prefs.insertRefreshToken(response.data[_prefs.refreshTokenKey]);
    await _prefs.insertExpired(DateTime.now()
        .add(Duration(seconds: response.data[_prefs.expiresInKey]))
        .millisecondsSinceEpoch);
    await addToken();
  }

  addToken() {
    _dio.options = _dio.options
        .copyWith(headers: {'Authorization': 'Bearer ${_prefs.accessToken}'});
  }
}
