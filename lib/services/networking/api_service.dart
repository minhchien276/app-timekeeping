// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:e_tmsc_app/services/networking/base_service.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:e_tmsc_app/services/exceptions/app_exception.dart';
import 'package:e_tmsc_app/services/exceptions/app_exception_string.dart';
import 'package:e_tmsc_app/shared/typedef.dart';

class ApiService {
  final _baseService = BaseService.instance;
  ApiService._();
  static final ApiService _instance = ApiService._();
  factory ApiService() => _instance;

  Future<dynamic> get<T>({
    required String endpoint,
    JSON? body,
  }) async {
    try {
      final response = await _baseService.dio.get(endpoint, data: body);
      return response;
    } on DioException catch (e) {
      throw handleError(e.response);
    }
  }

  Future<dynamic> post<T>({
    required String endpoint,
    JSON? body,
  }) async {
    try {
      final response = await _baseService.dio.post(endpoint, data: body);
      return response;
    } on DioException catch (e) {
      throw handleError(e.response);
    }
  }

  Future<dynamic> patch<T>({
    required String endpoint,
    JSON? body,
  }) async {
    try {
      final response = await _baseService.dio.patch(endpoint, data: body);
      return response;
    } on DioException catch (e) {
      throw handleError(e.response);
    }
  }

  Future<dynamic> put<T>({
    required String endpoint,
    JSON? body,
  }) async {
    try {
      final response = await _baseService.dio.put(endpoint, data: body);
      return response;
    } on DioException catch (e) {
      throw handleError(e.response);
    }
  }

  Future<JSON?> delete<T>({
    required String endpoint,
    JSON? body,
  }) async {
    try {
      final response = await _baseService.dio.delete(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw handleError(e.response);
    }
  }

  dynamic handleError(Response? response) {
    if (response != null) {
      if (HttpStatus(response.statusCode).connectionError) {
        throw ConnectionErrorException(
            0, response.data['message'] ?? AppExceptionString.connectionError);
      } else if (HttpStatus(response.statusCode).connectionError) {
        throw UnauthorizedException(
            401, response.data['message'] ?? AppExceptionString.status401);
      } else if (HttpStatus(response.statusCode).isForbidden) {
        throw ForbiddenException(
            403, response.data['message'] ?? AppExceptionString.status403);
      } else if (HttpStatus(response.statusCode).isNotFound) {
        throw NotFoundException(
            404, response.data['message'] ?? AppExceptionString.status404);
      } else if (HttpStatus(response.statusCode).isServerError) {
        throw ServerErrorException(500, AppExceptionString.status500);
      } else {
        throw UnknownException(
            100, response.data['message'] ?? AppExceptionString.status);
      }
    } else {
      throw UnknownException(100, AppExceptionString.status);
    }
  }
}
