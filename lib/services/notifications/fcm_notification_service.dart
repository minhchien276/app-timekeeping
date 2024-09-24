import 'dart:convert';
import 'dart:io';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/services/service/application_service.dart';
import 'package:e_tmsc_app/services/service/blog_service.dart';
import 'package:e_tmsc_app/services/service/employee_service.dart';
import 'package:e_tmsc_app/services/service/notification_service.dart';
import 'package:e_tmsc_app/services/service/test_service.dart';
import 'package:e_tmsc_app/shared/enums/notification_enum.dart';
import 'package:e_tmsc_app/shared/enums/role_enum.dart';
import 'package:e_tmsc_app/shared/enums/user_enum.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class FcmNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final _prefs = SharedPrefs();

  static const _androidChannel = AndroidNotificationChannel(
    'high_important_channel',
    'high_important_channel_name',
    importance: Importance.max,
    enableVibration: true,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('killpop'),
  );

  initNotifications() async {
    await _messaging.requestPermission();
    String? fcm = await _messaging.getToken();
    _prefs.setFCM(fcm ?? '');
    //firebaseInit();
    await initPushNotification();
    //await initLocalNotifications();
  }

  //register topic
  registerTopic() async {
    if (Platform.isIOS) {
      String? apnsToken = await _messaging.getAPNSToken();
      if (apnsToken != null) {
        await _messaging.subscribeToTopic('members-v2');
      } else {
        await Future<void>.delayed(
          const Duration(
            seconds: 3,
          ),
        );
        apnsToken = await _messaging.getAPNSToken();
        if (apnsToken != null) {
          await _messaging.subscribeToTopic('members-v2');
        }
      }
    } else {
      await _messaging.subscribeToTopic('members-v2');
    }
  }

  Future initPushNotification() async {
    try {
      await _messaging.setForegroundNotificationPresentationOptions(
        sound: true,
        badge: true,
        alert: true,
      );
      _messaging.getInitialMessage().then((message) =>
          Future.delayed(const Duration(seconds: 1))
              .then((value) => handleMessage(message)));
      FirebaseMessaging.onMessageOpenedApp.listen((message) =>
          Future.delayed(const Duration(seconds: 1))
              .then((value) => handleMessage(message)));
      FirebaseMessaging.onMessage.listen((message) {
        final notification = message.notification;
        if (notification == null) return;
        if (Platform.isAndroid) {
          _flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                _androidChannel.id,
                _androidChannel.name,
                playSound: true,
                importance: Importance.max,
                priority: Priority.high,
                vibrationPattern: Int64List.fromList([0, 1000]),
                sound: const RawResourceAndroidNotificationSound('killpop'),
              ),
              iOS: const DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
                sound: 'killpop.wav',
              ),
            ),
            payload: jsonEncode(message.toMap()),
          );
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> initLocalNotifications() async {
    try {
      var androidInitialize =
          const AndroidInitializationSettings('mipmap/ic_logo');
      const DarwinInitializationSettings initializationSettingsDarwin =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestSoundPermission: true,
        defaultPresentAlert: true,
        defaultPresentSound: true,
      );
      var initializationsSettings = InitializationSettings(
        android: androidInitialize,
        iOS: initializationSettingsDarwin,
      );
      await _flutterLocalNotificationsPlugin.initialize(initializationsSettings,
          onDidReceiveNotificationResponse: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
        handleMessage(message);
      });

      final platform = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await platform?.createNotificationChannel(_androidChannel);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //request permission for notification
  Future<void> requestNotificationPermission() async {
    final bool isNotificationPermissionGranted =
        await Permission.notification.isGranted;

    if (!isNotificationPermissionGranted) {
      await Permission.notification.request();
    }

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  //handle message
  handleMessage(RemoteMessage? message) {
    if (message != null) {
      final navigator = NotificationNavigation();
      int? id = int.tryParse(message.data["id"] ?? 0);
      NotificationType type = NotificationType.toEnum(
          message.data["type"].toString().toLowerCase());
      switch (type) {
        case NotificationType.blog:
          navigator.handleNextBlogDetail(id);
          break;
        case NotificationType.application:
          navigator.handleNextApplicationDetail(id);
          break;
        case NotificationType.salary:
          navigator.handleNextSalary(id);
          break;
        case NotificationType.testDetail:
          navigator.handleNextTestDetail(id);
          break;
        case NotificationType.normal:
          navigator.handleNextNotiDetail(id);
          break;

        default:
      }
    }
    debugPrint('handleMessage');
    debugPrint(message.toString());
  }

  //handle background message
  Future<void> handleBackgroundMessage(RemoteMessage? message) async {
    if (message != null) {
      AppNavigator.router.pushNamed(AppRoute.noti.path);
    }
    debugPrint('handleBackgroundMessage');
    debugPrint(message.toString());
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      if (Platform.isAndroid) {
        //initLocalNotifications();
        showNotification(message);
      } else {
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      _androidChannel.id.toString(),
      _androidChannel.name.toString(),
      channelDescription: 'channelDescription',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('killpop'),
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'killpop.mp3',
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title.toString(),
      message.notification?.body.toString(),
      notificationDetails,
    );
  }
}

class NotificationNavigation {
  final appService = ApplicationService();
  final blogService = BlogService();
  final _prefs = SharedPrefs();
  final testService = TestService();
  final employeeService = EmployeeService();
  final notiService = NotificationService();

  handleNextApplicationDetail(
    int? notificationId,
  ) async {
    try {
      if (notificationId != null) {
        final res = await appService.getApplicationDetail(notificationId);
        if (res.isOk) {
          AppNavigator.router.pushNamed(
            AppRoute.applicationDetail.name,
            extra: {
              'item': res.data,
              'userEnum': res.data.employee?.id == _prefs.id
                  ? UserEnum.my
                  : UserEnum.other
            },
          );
        }
      }
    } catch (e) {
      debugPrint('handleNextApplicationDetail: $e');
    }
  }

  handleNextBlogDetail(
    int? id,
  ) async {
    try {
      if (id != null && id != 0) {
        final res = await blogService.getBlogDetail(id);
        if (res.isOk) {
          AppNavigator.router.pushNamed(
            AppRoute.postDetail.name,
            extra: res.data,
          );
        }
      }
    } catch (e) {
      debugPrint('handleNextBlogDetail: $e');
    }
  }

  handleNextSalary(int? id) async {
    if (_prefs.role == RoleEnum.client) {
      final res = await employeeService.getSalaryByNotification(id);
      if (res.isOk) {
        AppNavigator.router
            .pushNamed(AppRoute.salaryDetail.name, extra: res.data);
      }
    }
  }

  handleNextTestDetail(int? employeeTestId) async {
    try {
      if (_prefs.role == RoleEnum.client) {
        if (employeeTestId != null && employeeTestId != 0) {
          final res = await testService.getTestDetail(employeeTestId);
          if (res.isOk) {
            AppNavigator.router
                .pushNamed(AppRoute.testDetail.name, extra: res.data);
          }
        }
      }
    } catch (e) {
      debugPrint('handleNextTestDetail $e');
    }
  }

  handleNextNotiDetail(int? notiId) async {
    try {
      final res = await notiService.getNotificationDetails(notiId);
      if (res.isOk) {
        AppNavigator.router
            .pushNamed(AppRoute.notiDetails.name, extra: res.data);
      }
    } catch (e) {
      debugPrint('handleNextNotiDetail $e');
    }
  }
}
