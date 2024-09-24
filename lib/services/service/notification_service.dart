import 'package:e_tmsc_app/data/models/notification_model.dart';
import 'package:e_tmsc_app/services/models/api_notification.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';
import 'package:e_tmsc_app/services/networking/api_service.dart';
import 'package:e_tmsc_app/services/networking/api_url.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';

abstract class BaseNotificationService {
  Future<GetListNotificationResponse> getNotification(int page);

  Future<UpdateNotificationResponse> updateSeen(Map<String, dynamic> parms);

  Future<UpdateNotificationResponse> updateDeviceToken(String token);

  Future<GetNotificationResponse> getNotificationDetails(int? id);
}

class NotificationService implements BaseNotificationService {
  final _apiService = ApiService();
  NotificationService._();
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  final _prefs = SharedPrefs();

  @override
  Future<UpdateNotificationResponse> updateDeviceToken(String token) async {
    final response = await _apiService.patch(
      endpoint: '${ApiUrl.updateDeviceToken}/${_prefs.id}',
      body: {'device_token': token},
    );
    return UpdateNotificationResponse(
      status: ApiResponseStatus.fromMap(response.data),
    );
  }

  @override
  Future<GetListNotificationResponse> getNotification(int page) async {
    final response = await _apiService.get(
      endpoint: ApiUrl.getNotification,
      body: {'page': page},
    );
    return GetListNotificationResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<NotificationModel>.from(
                response.data['data'].map((e) => NotificationModel.fromMap(e)),
              )
            : []);
  }

  @override
  Future<UpdateNotificationResponse> updateSeen(
      Map<String, dynamic> parms) async {
    final response = await _apiService.patch(
      endpoint: ApiUrl.updateSeen,
      body: parms,
    );
    return UpdateNotificationResponse(
      status: ApiResponseStatus.fromMap(response.data),
    );
  }

  @override
  Future<GetNotificationResponse> getNotificationDetails(int? id) async {
    final response =
        await _apiService.get(endpoint: '${ApiUrl.getNotificationDetails}/$id');
    return GetNotificationResponse(
      status: ApiResponseStatus.fromMap(response.data),
      data: NotificationModel.fromMap(response.data['data']),
    );
  }
}
