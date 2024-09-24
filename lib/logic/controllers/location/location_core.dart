// ignore_for_file: use_build_context_synchronously
import 'package:e_tmsc_app/data/models/checkin_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationCore {
  final double myLatitude = 21.05089882512451;
  final double myLongtitude = 105.7962066302022;

  //permission location.
  Future<bool> permission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    // Permissions are denied forever, handle appropriately.
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  //get position.
  Future<Position> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      timeLimit: const Duration(seconds: 5),
    );
    return position;
  }

  //get distance between two position.
  Future<double> getDistance(
    Position position,
  ) async {
    return Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      myLatitude,
      myLongtitude,
    );
  }

  //get address
  Future<String> getAddressFromLatLang(
    Position position,
  ) async {
    List<Placemark> placemark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark place = placemark[0];
    return '${place.street}, ${place.name}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
  }

  Future<CheckInModel> getCheckIn(
    BuildContext context,
  ) async {
    Position position = await getPosition();
    String location = await getAddressFromLatLang(position);
    return CheckInModel(
      checkin: DateTime.now(),
      location: location,
      latitude: position.latitude.toString(),
      longtitude: position.longitude.toString(),
      createdAt: DateTime.now(),
    );
  }
}
