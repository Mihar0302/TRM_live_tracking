import 'dart:async';

import 'package:background_location/background_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:trm/controller/global_controller.dart';
import 'package:trm/controller/location_controller.dart';
import 'package:trm/screen/history_widget.dart';
import 'package:trm/screen/home_widget.dart';
import 'package:trm/screen/profile_widget.dart';
import 'package:trm/utils/app_color.dart';
import 'package:trm/widget/custom_appbar.dart';
import 'package:trm/widget/custom_bottom_bar.dart';
import 'package:trm/widget/custom_loading_popup.dart';
import '../http/geolocator_services.dart';
import '../http/http-helper.dart';
import '../notification_data/push_notif_service.dart';
import '../utils/app_images.dart';
import '../widget/custom_btn.dart';
import '../widget/custom_error_popup.dart';
import '../widget/custom_search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalController global = Get.find();
  LocationController locationController = Get.put(LocationController());

  RxInt indexPage = 0.obs;
  RxString datr = "".obs;
  RxString speedStatus = "".obs;

  @override
  void didChangeDependencies() {
    Future.delayed(Duration(seconds: 0)).then((val) async {
      await Geolocator.requestPermission().then((v) {
        global.getTripApiCall();
        // GeolocatorServices.checkPermission();
        GeolocatorServices.getCurrentLocation(global.vDNumber.value);
        Timer.periodic(const Duration(seconds: 2), (Timer t) async {
          BackgroundLocation.startLocationService();
          final pos = await (Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high));
          if (pos.longitude.toString().isNotEmpty) {
            datr.value = pos.longitude.toString();
            HttpHelper.shareLatLon(
                pos.latitude.toString(),
                pos.longitude.toString(),
                global.vDNumber.value,
                pos.speed * 3.6);
            speedStatus.value = "${pos.speed * 3.6}";
            debugPrint("==> pos print ==>${speedStatus.value} ");
          }
        });
      });
    });

    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   global.getTripApiCall();
  //   // GeolocatorServices.checkPermission();
  //   GeolocatorServices.getUserCurrentLocation(global.vDNumber.value);
  //   // locationController.getCurrentLocation(global.vDNumber.value);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(
      () => CustomLoadingPopup(
        lodaing: global.getTripLoading.value,
        child: Scaffold(
            backgroundColor: AppColor.white,
            body: Column(
              children: [
                Obx(
                  () => CustomAppbar(
                      filter: indexPage.value == 0
                          ? true
                          : indexPage.value == 1
                              ? false
                              : indexPage.value == 2
                                  ? false
                                  : true,
                      changimg: false,
                      lable: indexPage.value == 0
                          ? "Home"
                          : indexPage.value == 1
                              ? "History"
                              : indexPage.value == 2
                                  ? "Profile"
                                  : "Home",
                      fun: () {
                        if (indexPage.value == 1) {
                          indexPage.value = 0;
                        } else {
                          if (indexPage.value == 2) {
                            indexPage.value = 1;
                          }
                        }
                      },
                      sizechange: 20,
                      funfilter: () {},
                      size: size),
                ),
                SizedBox(height: size.height * 0.02),
                Expanded(
                    child: indexPage.value == 0
                        ? HomeWidget(global: global, size: size)
                        : indexPage.value == 1
                            ? HistoryWidget(
                                size: size,
                                global: global,
                              )
                            : indexPage.value == 2
                                ? const ProfileWidget()
                                : Container()),
                Obx(
                  () => CustomBottomBar(
                      size: size,
                      funcOne: () {
                        indexPage.value = 0;

                        setState(() {});
                      },
                      funcTwo: () {
                        indexPage.value = 1;
                        setState(() {});
                      },
                      funcThree: () {
                        indexPage.value = 2;
                        setState(() {});
                      },
                      index: indexPage.value),
                )
              ],
            )),
      ),
    );
  }
}

void _checkPermission(Function onTap) async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.denied) {
    Methods.showAlertSnack("ERROR", "LOCATION_SERVICE_DENIED");
  } else if (permission == LocationPermission.deniedForever) {
    Methods.showAlertSnack("ERROR", "LOCATION_SERVICE_DENIED");
  } else {
    onTap();
  }
}
