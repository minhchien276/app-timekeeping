import 'package:e_tmsc_app/shared/extensions/context_extension.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<void> settingsDialog(BuildContext context) {
  return showDialog<void>(
    barrierColor: Colors.black45,
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1)),
        child: AlertDialog(
          backgroundColor: white,
          surfaceTintColor: white,
          elevation: 0,
          contentPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: SizedBox(
            height: 175,
            width: 200,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'Thông báo',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Bạn chưa cấp quyền chia sẻ vị trí, hãy bật cấp quyền để sử dụng ứng dụng',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: grey600,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                  color: grey300,
                ),
                Expanded(
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            customBorder: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                            onTap: () => Navigator.pop(context),
                            child: const SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Hủy',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: grey300,
                          width: 1,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              await Geolocator.openLocationSettings();
                            },
                            customBorder: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: const SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Cài đặt',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    color: Color(0xff6792FF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showSettingDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text("Thông báo"),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: const Text(
            'Hủy',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () => context.pop(),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text(
            "Cài đặt",
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            context.pop();
            Geolocator.openLocationSettings();
          },
        )
      ],
    ),
  );
}
