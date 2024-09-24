import 'package:e_tmsc_app/firebase_options.dart';
import 'package:e_tmsc_app/logic/controllers/app/app_binding.dart';
import 'package:e_tmsc_app/logic/controllers/themes/themes_controller.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/services/networking/base_service.dart';
import 'package:e_tmsc_app/services/notifications/fcm_notification_service.dart';
import 'package:e_tmsc_app/utils/app_string.dart';
import 'package:e_tmsc_app/utils/internet_connection.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';
import 'package:e_tmsc_app/utils/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await SharedPrefs().init();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await InternetStatusListener.getInstance().initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FcmNotificationService().initNotifications();
  BaseService.instance.initalize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemesController themeController = Get.put(ThemesController());

    return ScreenUtilInit(
      ensureScreenSize: true,
      designSize: const Size(390, 844),
      child: GetMaterialApp.router(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        locale: const Locale('vi', 'VN'),
        supportedLocales: const [Locale('en', ''), Locale('vi', '')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: getThemeMode(themeController.theme),
        routeInformationProvider: AppNavigator.router.routeInformationProvider,
        routeInformationParser: AppNavigator.router.routeInformationParser,
        routerDelegate: AppNavigator.router.routerDelegate,
        initialBinding: AppBinding(),
        builder: (context, child) {
          return MediaQuery.withNoTextScaling(
              child: child ?? const SizedBox.shrink());
        },
      ),
    );
  }

  ThemeMode getThemeMode(String type) {
    ThemeMode themeMode = ThemeMode.system;
    switch (type) {
      case "system":
        themeMode = ThemeMode.system;
        break;
      case "dark":
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.light;
        break;
    }
    return themeMode;
  }
}
