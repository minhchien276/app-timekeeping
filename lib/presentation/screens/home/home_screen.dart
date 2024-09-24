// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/logic/controllers/home/home_admin_controller.dart';
import 'package:e_tmsc_app/presentation/screens/home/home_admin.dart';
import 'package:e_tmsc_app/presentation/screens/home/home_client.dart';
import 'package:e_tmsc_app/services/notifications/fcm_notification_service.dart';
import 'package:e_tmsc_app/services/notifications/local_notification_service.dart';
import 'package:e_tmsc_app/shared/enums/role_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final RoleEnum role;
  const HomeScreen({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final HomeAdminController homeAdminController = Get.find();

  @override
  void initState() {
    FcmNotificationService().registerTopic();
    LocalNotificatonService().scheduleDailyNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.role == RoleEnum.client
        ? const HomeClient()
        : const HomeAdmin();
  }
}
