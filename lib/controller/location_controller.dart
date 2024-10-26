// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../data/map_location_model.dart';
import '../http/http-helper.dart';

class LocationController extends GetxController {
  List<LatLng> latLngList = [];
  List<LatLng> latLngListPoints = [];

  RxString filterDate = "".obs;

  List<MapLocation> coordinetsList = [];

  List<Marker> markerList = [];
  double? currentPositionLet;
  double? currentPositionLon;
  Position position = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
      altitudeAccuracy: 0,
      headingAccuracy: 0);

  Position? currentPosition;

  LatLng? sourceLocation;

  getCurrentLocation() async {
    try {
      Geolocator.requestPermission();
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentPosition = position;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  LatLng userLocationCoordinates = const LatLng(0.0, 0.0);
}
