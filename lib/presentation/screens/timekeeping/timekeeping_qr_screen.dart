// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:e_tmsc_app/logic/controllers/home/home_client_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/presentation/widgets/loading/loading_circle.dart';
import 'package:e_tmsc_app/shared/enums/check_enum.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';

class TimekeepingQrScreen extends StatefulWidget {
  final CheckEnum checkEnum;
  const TimekeepingQrScreen({
    Key? key,
    required this.checkEnum,
  }) : super(key: key);

  @override
  State<TimekeepingQrScreen> createState() => _TimekeepingQrScreenState();
}

class _TimekeepingQrScreenState extends State<TimekeepingQrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool check = false;
  bool? checkStatus;

  HomeClientController homeController = Get.find();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    homeController.isLoading;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Obx(
          () => Stack(
            alignment: Alignment.center,
            children: [
              buildQrView(context),
              Positioned(
                top: 150.h,
                left: 0,
                right: 0,
                child: TextWidget(
                  text: 'Quét mã tại đây\nĐảm bảo nguồn sáng để dễ thao tác  ',
                  color: white,
                  textStyle: textStyle15SemiBold,
                  textAlign: TextAlign.center,
                ),
              ),

              Positioned(
                height: 60,
                width: 60,
                child: homeController.isLoading
                    ? const LoadingCircle(width: 6)
                    : const SizedBox(),
              ),
              //if (checkStatus != null)
              Positioned(
                top: kToolbarHeight,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const KBackButton(),
                    TextWidget(
                      text: 'Chấm công',
                      color: white,
                      textStyle: textStyle17Bold,
                    ),
                    const SizedBox(
                      height: 40,
                      width: 40,
                    )
                  ],
                ),
              ),
              Positioned(
                height: 60,
                width: 60,
                bottom: 150.h,
                child: IconButton(
                  onPressed: () async {
                    await controller?.toggleFlash();
                    setState(() {});
                  },
                  icon: FutureBuilder(
                    future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      return Image.asset(
                        snapshot.data == true
                            ? AppIcon.flashOff
                            : AppIcon.flashOn,
                        color: white,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: white,
          borderRadius: 4,
          borderLength: 40,
          borderWidth: 8,
          cutOutSize: 300.w,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((data) async {
      if (data.code != null) {
        if (widget.checkEnum == CheckEnum.checkIn) {
          await homeController.handleCheckIn(context, data.code!);
        } else {
          await homeController.handleCheckOut(context, data.code!);
        }
      }
    });
  }
}
