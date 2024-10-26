import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trm/controller/location_controller.dart';
import 'http-helper.dart';

class GeolocatorServices {
  static Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return false;
      }
    }
    return true;
  }

  static Future getUserCurrentLocation(String userID) async {
    LocationController locationController = Get.find();
    var status = Permission.locationAlways;

    if (await status.isGranted) {
      final pos = await (Geolocator.getCurrentPosition());
      return pos;
    } else {
      await Geolocator.requestPermission();
      status = Permission.locationAlways;

      if (await status.isGranted) {
        final pos = await (Geolocator.getCurrentPosition());
        locationController.currentPositionLet = pos.latitude;
        locationController.currentPositionLon = pos.longitude;

        debugPrint(
            "==> live cordinatest ===> lat ${locationController.currentPositionLet} === log ==> ${locationController.currentPositionLon}");
        HttpHelper.shareLatLon(
            locationController.currentPositionLet.toString(),
            locationController.currentPositionLon.toString(),
            userID,
            pos.speed * 3.6);
      }
    }
  }

  static Future getCurrentLocation(String userID) async {
    LocationController locationController = Get.put(LocationController());
    var status = await Permission.location.status;

    if (status.isGranted) {
      final position = await (Geolocator.getCurrentPosition());
      locationController.currentPositionLet = position.latitude;
      locationController.currentPositionLon = position.longitude;
      HttpHelper.shareLatLon(
          locationController.currentPositionLet.toString(),
          locationController.currentPositionLon.toString(),
          userID,
          position.speed * 3.6);
      return position;
    } else {
      await Geolocator.requestPermission();
      if (status.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        locationController.currentPositionLet = position.latitude;
        locationController.currentPositionLon = position.longitude;
        HttpHelper.shareLatLon(
            locationController.currentPositionLet.toString(),
            locationController.currentPositionLon.toString(),
            userID,
            position.speed * 3.6);
      }
    }
  }
}
