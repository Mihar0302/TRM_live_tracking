import 'dart:async';
// import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:trm/controller/global_controller.dart';
import 'package:trm/screen/order_list_screen.dart';
import 'package:trm/utils/app_images.dart';
import 'package:trm/widget/custom_error_popup.dart';
import 'package:trm/widget/custom_loading_popup.dart';
import '../controller/location_controller.dart';
import '../http/geolocator_services.dart';
import '../http/http-helper.dart';
import '../utils/app_color.dart';
import '../widget/custom_btn.dart';
import '../widget/custom_search_field.dart';
import '../widget/empty_list.dart';

class HomeWidget extends StatefulWidget {
  final GlobalController global;
  final Size size;

  const HomeWidget({super.key, required this.global, required this.size});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  RxBool startTrip = false.obs;

  LocationController locationController = Get.put(LocationController());
  GlobalController global = Get.find();

  RxBool filterWidget = false.obs;
  RxString datr = "".obs;

  RxBool nullData = false.obs;
  List<String> orderIdList = [];
  List<LatLng> latLngList = [];
  RxString status = "".obs;

  TextEditingController search = TextEditingController();

  RxString date = "".obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomLoadingPopup(
        lodaing: widget.global.getTripLoading.value,
        child: widget.global.tripList.isNotEmpty
            ? Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomSearchField(
                          onChanged: (val) {},
                          hintText: "Search by Vehicle No and Date",
                          size: widget.size,
                          controller: search,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) => FilterWidget(
                                    size: widget.size,
                                    onClick: () {
                                      search.text =
                                          locationController.filterDate.value;
                                      setState(() {});
                                      Get.back();
                                    },
                                    locationController: locationController,
                                  ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: AppColor.greyColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(
                                widget.size.width * 0.025),
                          ),
                          child: Image.asset(
                            AppImages.filter,
                            height: widget.size.height * 0.025,
                            color: AppColor.greyColor,
                          ),
                        ),
                      ),
                      SizedBox(width: widget.size.width * 0.04),
                    ],
                  ),
                  SizedBox(height: widget.size.height * 0.02),
                  widget.global.tripList.isNotEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: widget.size.width * 0.05),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      height: 80,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffD1FFF8),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Image.asset(AppImages.complete,
                                          //     height: widget.size.height * 0.04,
                                          //     color: const Color(0xff00C35C)),
                                          Text(
                                            widget.global.tripList[0]
                                                        .statusCount !=
                                                    null
                                                ? "${widget.global.tripList[0].statusCount!.completed + widget.global.tripList[0].statusCount!.completedLate}"
                                                : "0",
                                            style: TextStyle(
                                              fontSize:
                                                  widget.size.height * 0.028,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Completed",
                                            style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: widget.size.height *
                                                    0.0182),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      height: 80,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffDCF8FF),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            widget.global.tripList[0]
                                                        .statusCount !=
                                                    null
                                                ? widget.global.tripList[0]
                                                    .statusCount!.failed
                                                    .toString()
                                                : "0",
                                            style: TextStyle(
                                              fontSize:
                                                  widget.size.height * 0.028,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Failed",
                                            style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: widget.size.height *
                                                    0.0182),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: widget.size.height * 0.01),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: widget.size.width * 0.05),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      height: 80,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffD1FFF8),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Image.asset(AppImages.complete,
                                          //     height: widget.size.height * 0.04,
                                          //     color: const Color(0xff00C35C)),
                                          Text(
                                            widget.global.tripList[0]
                                                        .statusCount !=
                                                    null
                                                ? widget.global.tripList[0]
                                                    .statusCount!.assigned
                                                    .toString()
                                                : "0",
                                            style: TextStyle(
                                              fontSize:
                                                  widget.size.height * 0.028,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Assigned",
                                            style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: widget.size.height *
                                                    0.0182),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      height: 80,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffDCF8FF),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Image.asset(AppImages.failed,
                                          //     height:
                                          //         widget.size.height * 0.04,
                                          //     color: const Color(0xff0098C5)),
                                          Text(
                                            widget.global.tripList[0]
                                                        .statusCount !=
                                                    null
                                                ? "${widget.global.tripList[0].statusCount!.arrived + widget.global.tripList[0].statusCount!.enroute}"
                                                : "0",
                                            style: TextStyle(
                                              fontSize:
                                                  widget.size.height * 0.028,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Arrived",
                                            style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: widget.size.height *
                                                    0.0182),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(height: widget.size.height * 0.03),
                  Expanded(
                    child: widget.global.tripList[0].data.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: widget.global.tripList[0].data.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, int i) {
                              GeolocatorServices.getCurrentLocation(
                                  widget.global.tripList[0].data[i].VUserName);
                              if (search.text.isEmpty) {
                                if (DateFormat("dd/MM/yyyy")
                                        .format(DateTime.now()) ==
                                    DateFormat("dd/MM/yyyy").format(
                                        DateTime.parse(widget.global.tripList[0]
                                            .data[i].date))) {
                                  return TripShowContainer(
                                      totalOrder:
                                          "${widget.global.tripList[0].data[i].orderList.length}",
                                      date: DateFormat("dd/MM/yyyy HH:mm")
                                          .format(DateTime.parse(widget.global
                                              .tripList[0].data[i].date)),
                                      vNo: widget.global.tripList[0].data[i]
                                          .registrationNo,
                                      onClick: () {
                                        Get.to(() => OrderListScreen(i: i));
                                      },
                                      size: widget.size);
                                }
                              } else if (widget
                                  .global.tripList[0].data[i].registrationNo
                                  .toString()
                                  .toLowerCase()
                                  .contains(search.text)) {
                                return TripShowContainer(
                                    totalOrder:
                                        "${widget.global.tripList[0].data[i].orderList.length}",
                                    date: DateFormat("dd/MM/yyyy HH:mm").format(
                                        DateTime.parse(widget
                                            .global.tripList[0].data[i].date)),
                                    vNo: widget.global.tripList[0].data[i]
                                        .registrationNo,
                                    onClick: () {
                                      Get.to(() => OrderListScreen(i: i));
                                    },
                                    size: widget.size);
                              } else if (DateFormat("dd/MM/yyyy")
                                  .format(DateTime.parse(
                                      widget.global.tripList[0].data[i].date))
                                  .contains(search.text)) {
                                return TripShowContainer(
                                    totalOrder:
                                        "${widget.global.tripList[0].data[i].orderList.length}",
                                    date: DateFormat("dd/MM/yyyy HH:mm").format(
                                        DateTime.parse(widget
                                            .global.tripList[0].data[i].date)),
                                    vNo: widget.global.tripList[0].data[i]
                                        .registrationNo,
                                    onClick: () {
                                      Get.to(() => OrderListScreen(i: i));
                                    },
                                    size: widget.size);
                              } else {
                                return Container();
                              }
                              return const EmptyActiveOrder(
                                  text: 'Today You have no order for delivery');
                            })
                        : const EmptyActiveOrder(
                            text: 'You have no order for delivery'),
                  ),
                ],
              )
            : const EmptyActiveOrder(text: 'You have no order for delivery'),
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
    Methods.showAlertSnack("ERROR".tr, "LOCATION_SERVICE_DENIED".tr);
  } else if (permission == LocationPermission.deniedForever) {
    // permissionAlert(context).show();
  } else {
    onTap();
  }
}

class StatusShow extends StatelessWidget {
  final String text;
  final Color color;
  final Size size;

  const StatusShow(
      {super.key, required this.text, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06, vertical: size.height * 0.002),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: color.withOpacity(0.2),
      ),
      child: Text(text,
          style: TextStyle(
            fontSize: size.height * 0.018,
            color: color,
          )),
    );
  }
}

class FilterWidget extends StatelessWidget {
  final Size size;
  final Function onClick;
  final LocationController locationController;

  const FilterWidget(
      {super.key,
      required this.size,
      required this.onClick,
      required this.locationController});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(AppImages.cancel, height: 25),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Text(
              "Filter",
              style: TextStyle(
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: size.height * 0.022),
            ),
          ),
          SizedBox(height: size.height * 0.025),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Date:",
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: size.height * 0.022,
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.018,
                  ),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.greyColor.withOpacity(0.15),
                          blurRadius: 16,
                          spreadRadius: 10,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15)),
                  child: Obx(
                    () => Row(
                      children: [
                        Text(locationController.filterDate.value.isNotEmpty
                            ? locationController.filterDate.value
                            : DateFormat("dd/MM/yyyy").format(
                                DateTime.parse(DateTime.now().toString()))),
                        SizedBox(width: size.width * 0.04),
                        InkWell(
                            onTap: () async {
                              locationController.filterDate.value = "";
                              final DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 365)),
                                lastDate: DateTime.now(),
                              );
                              locationController.filterDate.value =
                                  DateFormat("dd/MM/yyyy").format(newDate!);
                              debugPrint(
                                  "===> selete Date ===> ${locationController.filterDate.value}");
                            },
                            child: const Icon(Icons.date_range)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.03),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.05),
          Btn(
              size: size,
              title: "Filter",
              func: () {
                onClick();
              }),
          SizedBox(
            height: size.height * 0.03,
          ),
        ],
      ),
    );
  }
}

class TripShowContainer extends StatelessWidget {
  final String totalOrder;
  final String date;
  final String vNo;
  final Function onClick;
  final Size size;

  const TripShowContainer(
      {super.key,
      required this.totalOrder,
      required this.date,
      required this.vNo,
      required this.onClick,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.015),
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.04, vertical: size.height * 0.01),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TRIP",
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: size.height * 0.02),
              ),
              SizedBox(height: size.height * 0.01),
              Text("Date: $date",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: size.height * 0.017)),
              Text("Vehicle No: $vNo",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: size.height * 0.017)),
              SizedBox(height: size.height * 0.005),
              Text("Total Orders : $totalOrder",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: size.height * 0.019)),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          Row(
            children: [
              // Expanded(
              //   flex: 1,
              //   child: InkWell(
              //     onTap: () {
              //       Get.to(
              //           () => OrderListScreen(i: i));
              //     },
              //     child: Container(
              //       height: 45,
              //       width: 150,
              //       decoration: BoxDecoration(
              //           color: AppColor.white,
              //           border: Border.all(
              //               color: AppColor.greyColor
              //                   .withOpacity(0.5),
              //               width: 1),
              //           borderRadius:
              //               BorderRadius.circular(
              //                   14)),
              //       child: Column(
              //         mainAxisAlignment:
              //             MainAxisAlignment
              //                 .spaceAround,
              //         crossAxisAlignment:
              //             CrossAxisAlignment.center,
              //         children: [
              //           Text(
              //             "See Orders",
              //             style: TextStyle(
              //                 color:
              //                     AppColor.blackColor,
              //                 fontWeight:
              //                     FontWeight.w500,
              //                 fontSize:
              //                     widget.size.height *
              //                         0.02),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    onClick();
                    // orderIdList.clear();
                    // // locationController.markerList
                    // //     .clear();
                    // // locationController.latLngList
                    // //     .clear();
                    // // locationController.coordinetsList
                    // //     .clear();
                    // // locationController.markerList.add(
                    // //   Marker(
                    // //     point: LatLng(
                    // //         locationController
                    // //             .currentPosition!
                    // //             .latitude,
                    // //         locationController
                    // //             .currentPosition!
                    // //             .longitude),
                    // //     width: 80,
                    // //     height: 80,
                    // //     child: IconButton(
                    // //       onPressed: () {},
                    // //       icon: const Icon(
                    // //           Icons.location_on),
                    // //       color: Colors.green,
                    // //       iconSize: 45,
                    // //     ),
                    // //   ),
                    // // );
                    // // locationController.latLngList.add(
                    // //     LatLng(
                    // //         locationController
                    // //             .currentPosition!
                    // //             .latitude,
                    // //         locationController
                    // //             .currentPosition!
                    // //             .longitude));
                    // // locationController.coordinetsList
                    // //     .add(MapLocation(
                    // //         latitude: locationController
                    // //             .currentPositionLet!,
                    // //         longitude: locationController
                    // //             .currentPositionLon!));
                    // for (var a = 0;
                    //     a <
                    //         widget
                    //             .global
                    //             .tripList[0]
                    //             .data[i]
                    //             .orderList
                    //             .length;
                    //     ++a) {
                    //   orderIdList.add(widget
                    //       .global
                    //       .tripList[0]
                    //       .data[i]
                    //       .orderList[a]["t_id"]);
                    //
                    //   if (widget.global.tripList[0]
                    //           .data[i].status ==
                    //       "assigned") {
                    //     if (widget
                    //             .global
                    //             .tripList[0]
                    //             .data[i]
                    //             .orderList
                    //             .length ==
                    //         orderIdList.length) {
                    //       widget.global
                    //           .updateStatusApiCall(
                    //               orderIdList,
                    //               "enroute");
                    //     }
                    //   } else if (widget
                    //           .global
                    //           .tripList[0]
                    //           .data[i]
                    //           .status ==
                    //       "enroute") {
                    //     startTrip.value = true;
                    //     // debugPrint(
                    //     //     "===>latLngList location ====> ${locationController.latLngList.length}");
                    //     //
                    //     // print(
                    //     //     "===>marker location ====> ${locationController.markerList.length}");
                    //     // locationController
                    //     //     .coordinetsList
                    //     //     .add(MapLocation(
                    //     //         latitude: double.parse(widget
                    //     //                 .global
                    //     //                 .tripList[0]
                    //     //                 .data[i]
                    //     //                 .orderList[a]
                    //     //             ["t_trip_tolat"]),
                    //     //         longitude: double
                    //     //             .parse(widget
                    //     //                     .global
                    //     //                     .tripList[0]
                    //     //                     .data[i]
                    //     //                     .orderList[a]
                    //     //                 ["t_trip_tolog"])));
                    //     // locationController.markerList
                    //     //     .add(Marker(
                    //     //   point: LatLng(
                    //     //       double.parse(widget
                    //     //               .global
                    //     //               .tripList[0]
                    //     //               .data[i]
                    //     //               .orderList[a]
                    //     //           ["t_trip_tolat"]),
                    //     //       double.parse(widget
                    //     //               .global
                    //     //               .tripList[0]
                    //     //               .data[i]
                    //     //               .orderList[a]
                    //     //           ["t_trip_tolog"])),
                    //     //   width: 80,
                    //     //   height: 80,
                    //     //   child: IconButton(
                    //     //     onPressed: () {},
                    //     //     icon: const Icon(
                    //     //         Icons.location_on),
                    //     //     color: Colors.red,
                    //     //     iconSize: 45,
                    //     //   ),
                    //     // ));
                    //     // locationController.latLngList
                    //     //     .add(LatLng(
                    //     //         double.parse(widget
                    //     //                 .global
                    //     //                 .tripList[0]
                    //     //                 .data[i]
                    //     //                 .orderList[a]
                    //     //             ["t_trip_tolat"]),
                    //     //         double.parse(widget
                    //     //                 .global
                    //     //                 .tripList[0]
                    //     //                 .data[i]
                    //     //                 .orderList[a][
                    //     //             "t_trip_tolog"])));
                    //
                    //     // Get.to(() => MapWidget(
                    //     //     locations:
                    //     //         locationController
                    //     //             .coordinetsList,
                    //     //     id: global.userID.value,
                    //     //     globalController:
                    //     //         global));
                    //     Get.to(() =>
                    //         OrderListScreen(i: i));
                    //   }
                    // }
                  },
                  // onTap: () {
                  //   dat.clear();
                  //   for (var n = 0;
                  //       n <
                  //           widget.global.tripList[0]
                  //               .data[i].orderList.length;
                  //       n++) {
                  //     debugPrint(
                  //         "for loop ltd long ====> ${widget.global.tripList[0].data[i].orderList[n]["t_trip_tolat"]}");
                  //     dat.add(widget.global.tripList[0]
                  //         .data[i].orderList[n]["t_id"]);
                  //
                  //     if (widget.global.tripList[0].data[i]
                  //             .status ==
                  //         "assigned") {
                  //       debugPrint("===>assigned");
                  //       if (dat.isNotEmpty) {
                  //         widget.global.updateStatusApiCall(
                  //             dat, "enroute");
                  //       }
                  //     } else {
                  //       debugPrint("===>enroute");
                  //       if (widget.global.tripList[0]
                  //               .data[i].status ==
                  //           "enroute") {
                  //         startTrip.value = true;
                  //         locationController.latLngList
                  //             .clear();
                  //         locationController.markerList
                  //             .clear();
                  //         locationController.latLngList.add(
                  //             LatLng(
                  //                 locationController
                  //                     .sourceLocation!
                  //                     .latitude,
                  //                 locationController
                  //                     .sourceLocation!
                  //                     .longitude));
                  //         locationController.markerList.add(
                  //           Marker(
                  //             markerId: const MarkerId(
                  //                 "currentLocation"),
                  //             position: LatLng(
                  //                 locationController
                  //                     .currentPositionLet!,
                  //                 locationController
                  //                     .currentPositionLon!),
                  //           ),
                  //         );
                  //         locationController.markerList
                  //             .add(Marker(
                  //           markerId: MarkerId(widget
                  //               .global
                  //               .tripList[0]
                  //               .data[i]
                  //               .orderList[n]["t_id"]),
                  //           position: LatLng(
                  //             double.parse(widget
                  //                     .global
                  //                     .tripList[0]
                  //                     .data[i]
                  //                     .orderList[n]
                  //                 ["t_trip_tolat"]),
                  //             double.parse(widget
                  //                     .global
                  //                     .tripList[0]
                  //                     .data[i]
                  //                     .orderList[n]
                  //                 ["t_trip_tolog"]),
                  //           ),
                  //         ));
                  //         locationController.latLngList
                  //             .add(LatLng(
                  //           double.parse(widget
                  //                   .global
                  //                   .tripList[0]
                  //                   .data[i]
                  //                   .orderList[n]
                  //               ["t_trip_tolat"]),
                  //           double.parse(widget
                  //                   .global
                  //                   .tripList[0]
                  //                   .data[i]
                  //                   .orderList[n]
                  //               ["t_trip_tolog"]),
                  //         ));
                  //         debugPrint(
                  //             "==> latlnglist  ===>${locationController.latLngList} ");
                  //         debugPrint(
                  //             "==> marker  ===>${locationController.markerList} ");
                  //         _checkPermission(() {
                  //           debugPrint("==> daydsfygdjs");
                  //           Get.to(() => LiveMap(
                  //                 fromLat:
                  //                     locationController
                  //                         .sourceLocation!
                  //                         .latitude,
                  //                 fromLng:
                  //                     locationController
                  //                         .sourceLocation!
                  //                         .longitude,
                  //                 toLat: double.parse(widget
                  //                             .global
                  //                             .tripList[0]
                  //                             .data[i]
                  //                             .orderList[n][
                  //                         "t_trip_tolat"] ??
                  //                     ""),
                  //                 toLng: double.parse(widget
                  //                             .global
                  //                             .tripList[0]
                  //                             .data[i]
                  //                             .orderList[n][
                  //                         "t_trip_tolog"] ??
                  //                     ""),
                  //                 index: n,
                  //               ));
                  //         });
                  //       }
                  //     }
                  //   }
                  // },
                  child: Container(
                    height: 45,
                    width: 150,
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(14)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "See Orders",
                          style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.w500,
                              fontSize: size.height * 0.019),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
