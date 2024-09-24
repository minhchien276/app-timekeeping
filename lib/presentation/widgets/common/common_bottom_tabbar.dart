// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_tmsc_app/logic/controllers/application/approve_application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/application/my_application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/application/pending_application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/application/people_application_controller.dart';
import 'package:e_tmsc_app/logic/controllers/home/home_admin_controller.dart';
import 'package:e_tmsc_app/logic/controllers/home/home_client_controller.dart';
import 'package:e_tmsc_app/presentation/screens/home/widgets/home_string.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_dot.dart';
import 'package:e_tmsc_app/shared/enums/role_enum.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/internet_connection.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class MainBottomTabbar extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const MainBottomTabbar({
    Key? key,
    required this.navigationShell,
  }) : super(key: key);

  @override
  State<MainBottomTabbar> createState() => _MainBottomTabbarState();
}

class _MainBottomTabbarState extends State<MainBottomTabbar> {
  late int _activeIndex;

  final HomeClientController homeClientController = Get.find();
  final HomeAdminController homeAdminController = Get.find();
  final _prefs = SharedPrefs();
  late final InternetStatusListener connectionStatus;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      RequestStatusListener.getInstance().initialize(context);
      internetConnectionListener();
    });
    _activeIndex = widget.navigationShell.currentIndex;
    super.initState();
  }

  internetConnectionListener() async {
    connectionStatus = InternetStatusListener.getInstance();
    connectionStatus.checkConnection(ConnectivityResult.other);
    connectionStatus.connectionChange.listen((event) {
      if (event) {
        if (_prefs.role == RoleEnum.client) {
          homeClientController.refreshHome(context);
          final MyApplicationController myApplicationController = Get.find();
          final PeopleApplicationController peopleApplicationController =
              Get.find();
          myApplicationController.refreshing();
          peopleApplicationController.refreshing();
        } else {
          homeAdminController.refreshHome(context);
          final ApproveApplicationController approveApplicationController =
              Get.find();
          final PendingApplicationController pendingApplicationController =
              Get.find();
          approveApplicationController.refreshing();
          pendingApplicationController.refreshing();
        }
      }
      updateConnectivity(context, event, connectionStatus);
    });
  }

  void onPageChange(int index) {
    setState(() {
      _activeIndex = index;
    });
    widget.navigationShell.goBranch(index);
    if (_prefs.role == RoleEnum.client) {
      homeClientController.onChangePage(index);
    } else {
      homeAdminController.onChangePage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          if (_prefs.role == RoleEnum.client) {
            onPageChange(2);
          }
        },
        child: Container(
          height: 60.w,
          width: 60.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: primary900,
            gradient: const LinearGradient(
              colors: [
                Color(0xffFF8407),
                Color(0xffFFA244),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp,
            ),
            boxShadow: const [
              BoxShadow(
                color: primary500,
                blurRadius: 20,
                spreadRadius: 1,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: Image.asset(AppIcon.qrIcon, scale: 3.5),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomTabbar(),
    );
  }

  Widget _buildBottomTabbar() => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, -1),
            )
          ],
        ),
        child: BottomAppBar(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 50.h,
          notchMargin: 8,
          color: white,
          shadowColor: white,
          surfaceTintColor: white,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onPageChange(0),
                  child: bottomIcon(
                    icon: AppIcon.navIcon1,
                    text: HomeStrings.navBtn1,
                    isActive: _activeIndex == 0,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onPageChange(1),
                  child: bottomIcon(
                    icon: AppIcon.navIcon2,
                    text: HomeStrings.navBtn2,
                    isActive: _activeIndex == 1,
                  ),
                ),
              ),
              Expanded(
                child: bottomIcon(
                  text: HomeStrings.navBtn3,
                  isActive: _activeIndex == 2,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onPageChange(3),
                  child: bottomIcon(
                    icon: AppIcon.navIcon4,
                    text: HomeStrings.navBtn4,
                    isActive: _activeIndex == 3,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onPageChange(4),
                  child: bottomIcon(
                    icon: AppIcon.navIcon5,
                    text: HomeStrings.navBtn5,
                    isActive: _activeIndex == 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  Widget bottomIcon({
    String? icon,
    required String? text,
    required bool isActive,
  }) =>
      Container(
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            16.verticalSpace,
            if (icon != null)
              Image.asset(
                icon,
                scale: 3.5,
                color: isActive ? primary900 : neutral600,
              ),
            if (isActive) ...[4.verticalSpace, dot(6, color: primary900)]
          ],
        ),
      );
}
