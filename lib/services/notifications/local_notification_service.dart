// ignore_for_file: depend_on_referenced_packages
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificatonService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(
      android: androidInitialize,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
    );
  }

  void scheduleDailyNotifications() async {
    try {
      FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();
      await initialize(flutterLocalNotificationsPlugin);
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'etmsc',
        'channel_name',
        playSound: true,
        sound: RawResourceAndroidNotificationSound('notification'),
        importance: Importance.max,
        priority: Priority.high,
      );

      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: DarwinNotificationDetails(sound: 'notification.mp3'),
      );

      // Schedule morning notification
      await showBigTextNotification(
        id: 0,
        title: 'Nhắc nhở',
        body: 'Bạn đã chấm công chưa?',
        payload: null,
        fln: fln,
        scheduledTime: nextInstanceAM(),
        platformChannelSpecifics: platformChannelSpecifics,
      );

      // Schedule evening notification
      await showBigTextNotification(
        id: 1,
        title: 'Nhắc nhở',
        body: 'Bạn hãy nhớ chấm công và vệ sinh chỗ ngồi trước khi ra về!',
        payload: null,
        fln: fln,
        scheduledTime: nextInstanceCleanPM(),
        platformChannelSpecifics: platformChannelSpecifics,
      );

      fln.cancel(2);
      fln.cancel(3);

      // Schedule uniform notification
      // await showBigTextNotification(
      //   id: 2,
      //   title: 'Nhắc nhở',
      //   body: 'Bạn hãy nhớ mặc đồng phục vào sáng nay nhé!',
      //   payload: null,
      //   fln: fln,
      //   scheduledTime: nextInstanceThursday1AM(),
      //   platformChannelSpecifics: platformChannelSpecifics,
      // );

      // Schedule clean office
      // await showBigTextNotification(
      //   id: 3,
      //   title: 'Nhắc nhở',
      //   body: 'Các team vệ sinh chỗ ngồi trước khi ra về. Đẩy ghế vào bàn.',
      //   payload: null,
      //   fln: fln,
      //   scheduledTime: nextInstanceCleanPM(),
      //   platformChannelSpecifics: platformChannelSpecifics,
      // );
    } catch (e) {
      rethrow;
    }
  }

  static Future showBigTextNotification({
    required int id,
    required String title,
    required String body,
    required var payload,
    required FlutterLocalNotificationsPlugin fln,
    required tz.TZDateTime scheduledTime,
    required NotificationDetails platformChannelSpecifics,
  }) async {
    try {
      // Check if the scheduled day is Sunday
      if (scheduledTime.weekday == 7) {
        // If it's Sunday, don't show the notification
        return;
      }
      await fln.zonedSchedule(
        id,
        title,
        body,
        scheduledTime,
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: payload,
      );
    } catch (e) {
      rethrow;
    }
  }

  // thông báo 8:55 hàng ngày
  static tz.TZDateTime nextInstanceAM() {
    tz.initializeTimeZones();
    final location = tz.getLocation('Asia/Ho_Chi_Minh');
    final now = tz.TZDateTime.now(location);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(location, now.year, now.month, now.day, 8, 30);
    // tz.TZDateTime scheduledDate = tz.TZDateTime(location, now.year, now.month,
    //     now.day, now.hour, now.minute, now.second + 5);
    return scheduledDate;
  }

  static tz.TZDateTime nextInstancePM() {
    tz.initializeTimeZones();
    final location = tz.getLocation('Asia/Ho_Chi_Minh');
    final now = tz.TZDateTime.now(location);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(location, now.year, now.month, now.day, 17);
    return scheduledDate;
  }

  static tz.TZDateTime nextInstanceCleanPM() {
    tz.initializeTimeZones();
    final location = tz.getLocation('Asia/Ho_Chi_Minh');
    final now = tz.TZDateTime.now(location);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(location, now.year, now.month, now.day, 16, 50);
    return scheduledDate;
  }

  static tz.TZDateTime nextInstanceThursday1AM() {
    tz.initializeTimeZones();
    final location = tz.getLocation('Asia/Ho_Chi_Minh');
    final now = tz.TZDateTime.now(location);
    tz.TZDateTime nextThursday = now;
    while (nextThursday.weekday != 4) {
      nextThursday = nextThursday.add(const Duration(days: 1));
    }
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        location, nextThursday.year, nextThursday.month, nextThursday.day, 1);
    return scheduledDate;
  }
}
