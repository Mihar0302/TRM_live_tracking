import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:trm/controller/global_controller.dart';
import 'package:trm/controller/location_controller.dart';
import 'package:trm/widget/custom_appbar.dart';
import 'package:trm/widget/custom_error_popup.dart';
import 'package:trm/widget/custom_loading_popup.dart';
import '../data/map_location_model.dart';
import '../utils/app_color.dart';
import '../widget/custom_popup.dart';
import '../widget/empty_list.dart';
import 'home_widget.dart';
import 'order_details.dart';

class OrderListScreen extends StatefulWidget {
  final int i;

  const OrderListScreen({super.key, required this.i});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final GlobalController global = Get.find();
  LocationController locationController = Get.find();

  RxBool orderDone = false.obs;

  List<String> orderIdList = [];

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
              CustomAppbar(
                  lable: "Orders",
                  changimg: false,
                  fun: () {
                    Get.back();
                  },
                  sizechange: size.height * 0.02,
                  funfilter: () {},
                  size: size),
              SizedBox(height: size.height * 0.02),
              global.tripList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: global
                              .tripList[0].data[widget.i].orderList.length,
                          itemBuilder: (context, int i) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.05,
                                  vertical: size.height * 0.02),
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.04,
                                  vertical: size.height * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.greyColor.withOpacity(0.3),
                                    offset: const Offset(
                                      0.0,
                                      0.0,
                                    ),
                                    blurRadius: 15.0,
                                    spreadRadius: 0.5,
                                  ), //BoxShadow
                                  //BoxShadow
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.4,
                                        child: Text(
                                            "Order Id: ${global.tripList[0].data[widget.i].orderList[i]["t_order_id"]}",
                                            style: TextStyle(
                                              fontSize: size.height * 0.019,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Expanded(child: Container()),
                                      global.tripList[0].data[widget.i].orderList[i]
                                                  ["t_trip_status"] ==
                                              "assigned"
                                          ? StatusShow(
                                              text: global
                                                      .tripList[0]
                                                      .data[widget.i]
                                                      .orderList[i]
                                                  ["t_trip_status"],
                                              color: AppColor.pink,
                                              size: size)
                                          : global.tripList[0].data[widget.i].orderList[i]
                                                      ["t_trip_status"] ==
                                                  "enroute"
                                              ? StatusShow(
                                                  text: global
                                                          .tripList[0]
                                                          .data[widget.i]
                                                          .orderList[i]
                                                      ["t_trip_status"],
                                                  color: AppColor.primaryColor,
                                                  size: size)
                                              : global
                                                          .tripList[0]
                                                          .data[widget.i]
                                                          .orderList[i]["t_trip_status"] ==
                                                      "arrived"
                                                  ? StatusShow(
                                                      text: global
                                                              .tripList[0]
                                                              .data[widget.i]
                                                              .orderList[i]
                                                          ["t_trip_status"],
                                                      color: AppColor
                                                          .secondaryColor,
                                                      size: size,
                                                    )
                                                  : global.tripList[0].data[widget.i].orderList[i]["t_trip_status"] == "failed"
                                                      ? StatusShow(
                                                          text: global
                                                                  .tripList[0]
                                                                  .data[widget.i]
                                                                  .orderList[i]
                                                              ["t_trip_status"],
                                                          color: AppColor.red,
                                                          size: size,
                                                        )
                                                      : global.tripList[0].data[widget.i].orderList[i]["t_trip_status"] == "completed_late"
                                                          ? StatusShow(
                                                              text: global
                                                                      .tripList[0]
                                                                      .data[widget
                                                                          .i]
                                                                      .orderList[i]
                                                                  [
                                                                  "t_trip_status"],
                                                              color:
                                                                  AppColor.red,
                                                              size: size,
                                                            )
                                                          : StatusShow(
                                                              text: global
                                                                      .tripList[0]
                                                                      .data[widget
                                                                          .i]
                                                                      .orderList[i]
                                                                  [
                                                                  "t_trip_status"],
                                                              color: AppColor
                                                                  .green,
                                                              size: size,
                                                            ),
                                      SizedBox(width: size.width * 0.01)
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.002),
                                  Text(
                                      global.tripList[0].data[widget.i]
                                          .orderList[i]["t_start_date"],
                                      style: TextStyle(
                                          color: AppColor.greyColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: size.height * 0.017)),
                                  SizedBox(height: size.height * 0.015),
                                  Row(
                                    children: [
                                      Text("From: ",
                                          style: TextStyle(
                                            fontSize: size.height * 0.018,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      SizedBox(
                                        width: size.width * 0.6,
                                        child: Text(
                                            "${global.tripList[0].data[widget.i].orderList[i]["t_trip_fromlocation"]}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: size.height * 0.016,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.005),
                                  Row(
                                    children: [
                                      Text("To: ",
                                          style: TextStyle(
                                            fontSize: size.height * 0.018,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      SizedBox(
                                        width: size.width * 0.6,
                                        child: Text(
                                            "${global.tripList[0].data[widget.i].orderList[i]["t_trip_tolocation"]}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: size.height * 0.016,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  (global.tripList[0].data[widget.i]
                                                      .orderList[i]
                                                  ["t_trip_status"] ==
                                              "failed" ||
                                          global.tripList[0].data[widget.i]
                                                      .orderList[i]
                                                  ["t_trip_status"] ==
                                              "completed_late")
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  Get.to(() => OrderDetails(
                                                        startDate: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_start_date"],
                                                        endDate: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_end_date"],
                                                        fromLocation: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i][
                                                            "t_trip_fromlocation"],
                                                        toLocation: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i][
                                                            "t_trip_tolocation"],
                                                        totalDistance: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_totaldistance"],
                                                        loadingTotal: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_loading_t"],
                                                        unLoadingTotal: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_unloading_t"],
                                                        weight: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_weight"],
                                                        dimension: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_dimension"],
                                                        status: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_trip_status"],
                                                        trackingCode: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_trackingcode"],
                                                        registrationNo: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i][
                                                            "v_registration_no"],
                                                        comDate: "N/A",
                                                      ));
                                                },
                                                child: Container(
                                                  height: 45,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                      border: Border.all(
                                                          color: AppColor
                                                              .greyColor
                                                              .withOpacity(0.5),
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "See Details",
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .blackColor,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                size.height *
                                                                    0.02),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  Get.to(() => OrderDetails(
                                                        startDate: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_start_date"],
                                                        endDate: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_end_date"],
                                                        fromLocation: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i][
                                                            "t_trip_fromlocation"],
                                                        toLocation: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i][
                                                            "t_trip_tolocation"],
                                                        totalDistance: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_totaldistance"],
                                                        loadingTotal: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_loading_t"],
                                                        unLoadingTotal: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_unloading_t"],
                                                        weight: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_weight"],
                                                        dimension: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_dimension"],
                                                        status: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_trip_status"],
                                                        trackingCode: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i]
                                                            ["t_trackingcode"],
                                                        registrationNo: global
                                                                .tripList[0]
                                                                .data[widget.i]
                                                                .orderList[i][
                                                            "v_registration_no"],
                                                        comDate: "N/A",
                                                      ));
                                                },
                                                child: Container(
                                                  height: 45,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                      border: Border.all(
                                                          color: AppColor
                                                              .greyColor
                                                              .withOpacity(0.5),
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "See Details",
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .blackColor,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                size.height *
                                                                    0.02),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  orderIdList.clear();
                                                  orderIdList.add(global
                                                      .tripList[0]
                                                      .data[widget.i]
                                                      .orderList[i]["t_id"]);

                                                  if (global
                                                              .tripList[0]
                                                              .data[widget.i]
                                                              .orderList[i]
                                                          ["t_trip_status"] ==
                                                      "assigned") {
                                                    global.updateStatusApiCall(
                                                        orderIdList, "enroute");
                                                    global.getTripApiCall();
                                                    setState(() {});
                                                  } else if (global
                                                              .tripList[0]
                                                              .data[widget.i]
                                                              .orderList[i]
                                                          ["t_trip_status"] ==
                                                      "enroute") {
                                                    Get.find<
                                                            LocationController>()
                                                        .getCurrentLocation();
                                                    _checkPermission(() async {
                                                      if (await MapLauncher
                                                              .isMapAvailable(
                                                                  MapType
                                                                      .google) !=
                                                          null) {
                                                        MapLauncher.showDirections(
                                                            mapType:
                                                                MapType.google,
                                                            destination: Coords(
                                                                double.parse(global
                                                                        .tripList[0]
                                                                        .data[widget
                                                                            .i]
                                                                        .orderList[i]
                                                                    [
                                                                    "t_trip_tolat"]),
                                                                double.parse(global
                                                                    .tripList[0]
                                                                    .data[widget
                                                                        .i]
                                                                    .orderList[i]["t_trip_tolog"])));
                                                      }
                                                    });

                                                    // locationController
                                                    //     .coordinetsList
                                                    //     .clear();
                                                    // locationController
                                                    //     .coordinetsList
                                                    //     .add(MapLocation(
                                                    //         latitude:
                                                    //             locationController
                                                    //                 .currentPositionLet!,
                                                    //         longitude:
                                                    //             locationController
                                                    //                 .currentPositionLon!));
                                                    // locationController
                                                    //     .coordinetsList
                                                    //     .add(MapLocation(
                                                    //         latitude: double.parse(global
                                                    //                 .tripList[0]
                                                    //                 .data[widget.i]
                                                    //                 .orderList[i]
                                                    //             [
                                                    //             "t_trip_tolat"]),
                                                    //         longitude: double.parse(global
                                                    //                 .tripList[0]
                                                    //                 .data[widget.i]
                                                    //                 .orderList[i]
                                                    //             ["t_trip_tolog"])));

                                                    // Get.to(() => MapWidget(
                                                    //     locations:
                                                    //         locationController
                                                    //             .coordinetsList,
                                                    //     id: global.userID.value,
                                                    //     globalController:
                                                    //         global));
                                                  }
                                                },
                                                child: Container(
                                                  height: 45,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      color: global
                                                                      .tripList[0]
                                                                      .data[widget
                                                                          .i]
                                                                      .orderList[i]
                                                                  [
                                                                  "t_trip_status"] ==
                                                              "assigned"
                                                          ? const Color(
                                                                  0xffDCF8FF)
                                                              .withOpacity(0.4)
                                                          : AppColor.yellow
                                                              .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        global
                                                                        .tripList[0]
                                                                        .data[widget
                                                                            .i]
                                                                        .orderList[i]
                                                                    [
                                                                    "t_trip_status"] ==
                                                                "assigned"
                                                            ? "Start Order"
                                                            : "Get Direction",
                                                        style: TextStyle(
                                                            color: global
                                                                            .tripList[
                                                                                0]
                                                                            .data[widget
                                                                                .i]
                                                                            .orderList[i]
                                                                        [
                                                                        "t_trip_status"] ==
                                                                    "assigned"
                                                                ? const Color(
                                                                    0xff0098C5)
                                                                : const Color(
                                                                    0xffEBB01A),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                size.height *
                                                                    0.019),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  SizedBox(height: size.height * 0.005),
                                  global.tripList[0].data[widget.i].orderList[i]
                                              ["t_trip_status"] ==
                                          "enroute"
                                      ? SizedBox(height: size.height * 0.01)
                                      : Container(),
                                  global.tripList[0].data[widget.i].orderList[i]
                                              ["t_trip_status"] ==
                                          "enroute"
                                      ? Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  if (global
                                                              .tripList[0]
                                                              .data[widget.i]
                                                              .orderList[i]
                                                          ["t_trip_status"] ==
                                                      "enroute") {
                                                    global.updateStatusApiCall([
                                                      global
                                                          .tripList[0]
                                                          .data[widget.i]
                                                          .orderList[i]["t_id"]
                                                    ], "failed");
                                                    global.getTripApiCall();
                                                    setState(() {});
                                                  }
                                                },
                                                child: Container(
                                                  height: 45,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      color: global
                                                                      .tripList[0]
                                                                      .data[widget
                                                                          .i]
                                                                      .orderList[i]
                                                                  [
                                                                  "t_trip_status"] ==
                                                              "enroute"
                                                          ? AppColor.red
                                                              .withOpacity(0.4)
                                                          : AppColor.greyColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Failed",
                                                        style: TextStyle(
                                                            color: AppColor.red,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                size.height *
                                                                    0.02),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          CustomPopUpWidget(
                                                              text:
                                                                  "Are you sure you want to complete Order ?",
                                                              cancel: () {
                                                                Get.back();
                                                              },
                                                              done: () {
                                                                if (global
                                                                        .tripList[
                                                                            0]
                                                                        .data[widget
                                                                            .i]
                                                                        .orderList[i]["t_trip_status"] ==
                                                                    "enroute") {
                                                                  global
                                                                      .updateStatusApiCall([
                                                                    global
                                                                        .tripList[
                                                                            0]
                                                                        .data[widget
                                                                            .i]
                                                                        .orderList[i]["t_id"]
                                                                  ], "completed");
                                                                  global
                                                                      .getTripApiCall();
                                                                  setState(
                                                                      () {});
                                                                }
                                                                Get.back();
                                                                Get.back();
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        true,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        CustomPopUpWidget(
                                                                          cancel:
                                                                              () {},
                                                                          done:
                                                                              () {},
                                                                          size:
                                                                              size,
                                                                          image:
                                                                              true,
                                                                          text:
                                                                              "Order Completed Successfully!",
                                                                        ));
                                                                Future.delayed((const Duration(
                                                                        seconds:
                                                                            3)))
                                                                    .then((v) {
                                                                  Get.back();
                                                                });
                                                              },
                                                              size: size));
                                                },
                                                child: Container(
                                                  height: 45,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      color: global
                                                                      .tripList[0]
                                                                      .data[widget
                                                                          .i]
                                                                      .orderList[i]
                                                                  [
                                                                  "t_trip_status"] ==
                                                              "enroute"
                                                          ? const Color(
                                                              0xffD1FFF8)
                                                          : AppColor.greyColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        global
                                                                        .tripList[0]
                                                                        .data[widget
                                                                            .i]
                                                                        .orderList[i]
                                                                    [
                                                                    "t_trip_status"] ==
                                                                "enroute"
                                                            ? "Completed"
                                                            : "Get Direction",
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xff00C35C),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                size.height *
                                                                    0.019),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                            );
                          }),
                    )
                  : const EmptyActiveOrder(
                      text: 'You have no order for delivery'),
            ],
          ),
        ),
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
    Methods.showAlertSnack(
      "ERROR".tr,
      "LOCATION_SERVICE_DENIED".tr,
    );
  } else if (permission == LocationPermission.deniedForever) {
    // permissionAlert(context).show();
  } else {
    onTap();
  }
}
