import 'package:e_tmsc_app/services/service/notification_service.dart';

class NotificationProvider {
  NotificationProvider._();
  static final NotificationProvider _instance = NotificationProvider._();
  factory NotificationProvider() => _instance;
  final service = NotificationService();

  getNotification(int page) async {
    final res = await service.getNotification(page);
    return res.isOk ? res.data : [];
  }
}
