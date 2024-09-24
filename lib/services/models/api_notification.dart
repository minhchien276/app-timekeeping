import 'package:e_tmsc_app/data/models/notification_model.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';

class GetListNotificationResponse extends ApiResponse<List<NotificationModel>> {
  GetListNotificationResponse({required super.status, required super.data});
}

class UpdateNotificationResponse extends ApiResponse<bool> {
  UpdateNotificationResponse({required super.status, super.data = true});
}

class GetNotificationResponse extends ApiResponse<NotificationModel> {
  GetNotificationResponse({required super.status, required super.data});
}
