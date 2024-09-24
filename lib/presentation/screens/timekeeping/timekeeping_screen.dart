import 'package:audioplayers/audioplayers.dart';
import 'package:e_tmsc_app/logic/controllers/home/home_client_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_check_button.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/dialog/settings_dialog.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/services/permission/permission.dart';
import 'package:e_tmsc_app/services/permission/permission_exception.dart';
import 'package:e_tmsc_app/shared/enums/check_enum.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class TimekeepingScreen extends StatefulWidget {
  const TimekeepingScreen({super.key});

  @override
  State<TimekeepingScreen> createState() => _TimekeepingScreenState();
}

class _TimekeepingScreenState extends State<TimekeepingScreen> {
  final player = AudioPlayer();

  void playSound() async {
    await player.play(AssetSource('sounds/ting.mp3'));
  }

  final PermissionService _permission = PermissionService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primary900,
        centerTitle: true,
        title: TextWidget(
          text: 'Chấm công',
          color: white,
          textStyle: textStyle17Bold,
        ),
      ),
      body: GetBuilder<HomeClientController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
            child: Column(
              children: [
                Image.asset(AppImage.timekeepingBg),
                8.verticalSpace,
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 21.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: grey100,
                        blurRadius: 4,
                        spreadRadius: 1,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      TextWidget(
                        text: 'Quét mã QR để check in & check out',
                        color: black,
                        textStyle: textStyle16Bold,
                      ),
                      24.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: CheckButton(
                              onTap: () async {
                                try {
                                  await _permission.permission(context);
                                  if (!context.mounted) return;
                                  context.pushNamed(AppRoute.timekeepingQr.name,
                                      extra: CheckEnum.checkIn);
                                } catch (e) {
                                  if (e is LocationDeniedException) {
                                    showSettingDialog(context, e.message);
                                  } else if (e is CameraDeniedException) {
                                    showSettingDialog(context, e.message);
                                  }
                                }
                              },
                              text: 'CHECK IN',
                              isChecked:
                                  controller.timeKeeping?.checkin != null,
                              disable: controller.timeKeeping == null,
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: CheckButton(
                              onTap: () async {
                                try {
                                  await _permission.permission(context);
                                  if (!context.mounted) return;
                                  context.pushNamed(AppRoute.timekeepingQr.name,
                                      extra: CheckEnum.checkOut);
                                } catch (e) {
                                  if (e is LocationDeniedException) {
                                    showSettingDialog(context, e.message);
                                  } else if (e is CameraDeniedException) {
                                    showSettingDialog(context, e.message);
                                  }
                                }
                              },
                              text: 'CHECK OUT',
                              isChecked:
                                  controller.timeKeeping?.checkout != null,
                              disable: controller.timeKeeping == null ||
                                  controller.timeKeeping?.checkin == null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
