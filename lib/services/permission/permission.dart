import 'package:e_tmsc_app/services/permission/permission_exception.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  //permission location.
  Future<void>  permission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationDeniedException(
          "Bạn chưa cấp quyền chia sẻ vị trí, hãy bật cấp quyền để sử dụng ứng dụng");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationDeniedException(
            "Bạn chưa cấp quyền chia sẻ vị trí, hãy bật cấp quyền để sử dụng ứng dụng");
      }
    }

    // Permissions are denied forever, handle appropriately.
    if (permission == LocationPermission.deniedForever) {
      throw LocationDeniedException(
          "Bạn chưa cấp quyền chia sẻ vị trí, hãy bật cấp quyền để sử dụng ứng dụng");
    }

    //camera permisson
    PermissionStatus cameraStatus = await Permission.camera.status;

    if (!cameraStatus.isGranted) {
      cameraStatus = await Permission.camera.request();
    }

    if (!cameraStatus.isGranted) {
      throw CameraDeniedException(
          'Bạn chưa cấp quyền sử dụng camera, hãy bật cấp quyền để sử dụng ứng dụng');
    }
  }
}
