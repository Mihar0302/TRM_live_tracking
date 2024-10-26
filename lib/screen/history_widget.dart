import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trm/controller/global_controller.dart';
import 'package:trm/utils/app_color.dart';
import 'package:trm/widget/custom_loading_popup.dart';
import 'package:trm/widget/custom_search_field.dart';
import '../data/trip_model.dart';
import '../widget/empty_list.dart';
import 'home_widget.dart';
import 'order_details.dart';

class HistoryWidget extends StatefulWidget {
  final Size size;
  final GlobalController global;

  const HistoryWidget({super.key, required this.size, required this.global});

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  RxBool dataNull = false.obs;
  RxInt index = 0.obs;
  List<Data> dataList = [];
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    widget.global.orderGetApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          CustomLoadingPopup(
            lodaing: widget.global.orderLoading.value,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearchField(size: widget.size, controller: search),
                  SizedBox(height: widget.size.height * 0.017),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: widget.size.width * 0.04),
                    child: Text("Order History",
                        style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: widget.size.height * 0.02,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  widget.global.orderList.isNotEmpty
                      ? ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.global.orderList[0].data.length,
                      itemBuilder: (context, int i) {
                        if (widget.global.orderList[0].data[i]
                        ["t_trip_status"] ==
                            "completed" ||
                            widget.global.orderList[0].data[i]
                            ["t_trip_status"] ==
                                "completed_late" ||
                            widget.global.orderList[0].data[i]
                            ["t_trip_status"] ==
                                "failed") {
                          if (search.text.isEmpty) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: widget.size.width * 0.05,
                                  vertical: widget.size.height * 0.015),
                              margin: EdgeInsets.symmetric(
                                  horizontal: widget.size.width * 0.04,
                                  vertical: widget.size.height * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    AppColor.greyColor.withOpacity(0.3),
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
                                      Text(
                                          "Order Id: ${widget.global
                                              .orderList[0].data[i]["t_id"]}",
                                          style: TextStyle(
                                            fontSize:
                                            widget.size.height * 0.019,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Expanded(child: Container()),
                                      widget.global.orderList[0].data[i]
                                      ["t_trip_status"] ==
                                          "completed"
                                          ? StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]["t_trip_status"],
                                          color: AppColor.green,
                                          size: widget.size)
                                          : widget.global.orderList[0].data[i]
                                      ["t_trip_status"] ==
                                          "completed_late"
                                          ? StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]
                                          ["t_trip_status"],
                                          color: AppColor.blue,
                                          size: widget.size)
                                          : widget.global.orderList[0].data[i]
                                      ["t_trip_status"] ==
                                          "failed"
                                          ? StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]["t_trip_status"],
                                          color: AppColor.red,
                                          size: widget.size)
                                          : StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]["t_trip_status"],
                                          color: AppColor.green,
                                          size: widget.size),
                                      SizedBox(
                                          width: widget.size.width * 0.01)
                                    ],
                                  ),
                                  SizedBox(
                                      height: widget.size.height * 0.002),
                                  Text(DateFormat("dd/MM/yyyy HH:mm").format(
                                      DateTime.parse(
                                          widget.global.orderList[0].data[i]
                                          ["t_completed"])),

                                      style: TextStyle(
                                          color: AppColor.greyColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                          widget.size.height * 0.017)),
                                  SizedBox(
                                      height: widget.size.height * 0.015),
                                  Row(
                                    children: [
                                      Text("From: ",
                                          style: TextStyle(
                                            fontSize:
                                            widget.size.height * 0.018,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      SizedBox(
                                        width: widget.size.width * 0.6,
                                        child: Text(
                                            "${widget.global.orderList[0]
                                                .data[i]["t_trip_fromlocation"]}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize:
                                              widget.size.height * 0.016,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: widget.size.height * 0.005),
                                  Row(
                                    children: [
                                      Text("To: ",
                                          style: TextStyle(
                                            fontSize:
                                            widget.size.height * 0.018,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      SizedBox(
                                        width: widget.size.width * 0.6,
                                        child: Text(
                                            "${widget.global.orderList[0]
                                                .data[i]["t_trip_tolocation"]}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize:
                                              widget.size.height * 0.016,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: widget.size.height * 0.015),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() =>
                                              OrderDetails(
                                                startDate: DateFormat(
                                                    "dd/MM/yyyy HH:mm").format(
                                                    DateTime.parse(widget
                                                        .global
                                                        .orderList[0]
                                                        .data[i]["t_start_date"])),
                                                endDate: DateFormat(
                                                    "dd/MM/yyyy HH:mm").format(
                                                    DateTime.parse(widget
                                                        .global
                                                        .orderList[0]
                                                        .data[i]["t_end_date"])),
                                                fromLocation: widget.global
                                                    .orderList[0].data[i]
                                                ["t_trip_fromlocation"],
                                                toLocation: widget.global
                                                    .orderList[0].data[i]
                                                ["t_trip_tolocation"],
                                                totalDistance: widget.global
                                                    .orderList[0].data[i]
                                                ["t_totaldistance"],
                                                loadingTotal: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_loading_t"],
                                                unLoadingTotal: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_unloading_t"],
                                                weight: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_weight"],
                                                dimension: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_dimension"],
                                                status: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_trip_status"],
                                                trackingCode: widget.global
                                                    .orderList[0].data[i]
                                                ["t_trackingcode"],
                                                registrationNo: widget.global
                                                    .orderList[0].data[i]
                                                ["v_registration_no"],
                                                comDate: "${DateFormat(
                                                    "dd/MM/yyyy HH:mm").format(
                                                    DateTime.parse(
                                                        widget.global
                                                            .orderList[0]
                                                            .data[i]
                                                        ["t_completed"]))}",
                                              ));
                                        },
                                        child: Text(
                                          "See Details",
                                          style: TextStyle(
                                              color: AppColor.primaryColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                              widget.size.height * 0.02),
                                        ),
                                      ),
                                      Icon(Icons.keyboard_arrow_right,
                                          color: AppColor.primaryColor),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          } else if (widget.global.orderList[0].data[i]
                          ["t_trip_status"].toString().contains(search.text)) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: widget.size.width * 0.05,
                                  vertical: widget.size.height * 0.015),
                              margin: EdgeInsets.symmetric(
                                  horizontal: widget.size.width * 0.04,
                                  vertical: widget.size.height * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    AppColor.greyColor.withOpacity(0.3),
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
                                      Text(
                                          "Order Id: ${widget.global
                                              .orderList[0].data[i]["t_id"]}",
                                          style: TextStyle(
                                            fontSize:
                                            widget.size.height * 0.019,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Expanded(child: Container()),
                                      widget.global.orderList[0].data[i]
                                      ["t_trip_status"] ==
                                          "completed"
                                          ? StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]["t_trip_status"],
                                          color: AppColor.green,
                                          size: widget.size)
                                          : widget.global.orderList[0].data[i]
                                      ["t_trip_status"] ==
                                          "completed_late"
                                          ? StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]
                                          ["t_trip_status"],
                                          color: AppColor.blue,
                                          size: widget.size)
                                          : widget.global.orderList[0].data[i]
                                      ["t_trip_status"] ==
                                          "failed"
                                          ? StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]["t_trip_status"],
                                          color: AppColor.red,
                                          size: widget.size)
                                          : StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]["t_trip_status"],
                                          color: AppColor.green,
                                          size: widget.size),
                                      SizedBox(
                                          width: widget.size.width * 0.01)
                                    ],
                                  ),
                                  SizedBox(
                                      height: widget.size.height * 0.002),
                                  Text(DateFormat("dd/MM/yyyy HH:mm").format(
                                      DateTime.parse(
                                          widget.global.orderList[0].data[i]
                                          ["t_completed"])),
                                      style: TextStyle(
                                          color: AppColor.greyColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                          widget.size.height * 0.017)),
                                  SizedBox(
                                      height: widget.size.height * 0.015),
                                  Row(
                                    children: [
                                      Text("From: ",
                                          style: TextStyle(
                                            fontSize:
                                            widget.size.height * 0.018,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      SizedBox(
                                        width: widget.size.width * 0.6,
                                        child: Text(
                                            "${widget.global.orderList[0]
                                                .data[i]["t_trip_fromlocation"]}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize:
                                              widget.size.height * 0.016,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: widget.size.height * 0.005),
                                  Row(
                                    children: [
                                      Text("To: ",
                                          style: TextStyle(
                                            fontSize:
                                            widget.size.height * 0.018,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      SizedBox(
                                        width: widget.size.width * 0.6,
                                        child: Text(
                                            "${widget.global.orderList[0]
                                                .data[i]["t_trip_tolocation"]}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize:
                                              widget.size.height * 0.016,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: widget.size.height * 0.015),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() =>
                                              OrderDetails(
                                                startDate: DateFormat(
                                                    "dd/MM/yyyy HH:mm").format(
                                                    DateTime.parse(widget
                                                        .global
                                                        .orderList[0]
                                                        .data[i]["t_start_date"])),
                                                endDate: DateFormat(
                                                    "dd/MM/yyyy HH:mm").format(
                                                    DateTime.parse(widget
                                                        .global
                                                        .orderList[0]
                                                        .data[i]["t_end_date"])),
                                                fromLocation: widget.global
                                                    .orderList[0].data[i]
                                                ["t_trip_fromlocation"],
                                                toLocation: widget.global
                                                    .orderList[0].data[i]
                                                ["t_trip_tolocation"],
                                                totalDistance: widget.global
                                                    .orderList[0].data[i]
                                                ["t_totaldistance"],
                                                loadingTotal: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_loading_t"],
                                                unLoadingTotal: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_unloading_t"],
                                                weight: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_weight"],
                                                dimension: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_dimension"],
                                                status: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_trip_status"],
                                                trackingCode: widget.global
                                                    .orderList[0].data[i]
                                                ["t_trackingcode"],
                                                registrationNo: widget.global
                                                    .orderList[0].data[i]
                                                ["v_registration_no"],
                                                comDate: DateFormat(
                                                    "dd/MM/yyyy HH:mm").format(
                                                    DateTime.parse(
                                                        widget.global
                                                            .orderList[0]
                                                            .data[i]
                                                        ["t_completed"])),
                                              ));
                                        },
                                        child: Text(
                                          "See Details",
                                          style: TextStyle(
                                              color: AppColor.primaryColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                              widget.size.height * 0.02),
                                        ),
                                      ),
                                      Icon(Icons.keyboard_arrow_right,
                                          color: AppColor.primaryColor),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          } else if (widget.global.orderList[0].data[i]
                          ["t_id"].toString().contains(search.text)) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: widget.size.width * 0.05,
                                  vertical: widget.size.height * 0.015),
                              margin: EdgeInsets.symmetric(
                                  horizontal: widget.size.width * 0.04,
                                  vertical: widget.size.height * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    AppColor.greyColor.withOpacity(0.3),
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
                                      Text(
                                          "Order Id: ${widget.global
                                              .orderList[0].data[i]["t_id"]}",
                                          style: TextStyle(
                                            fontSize:
                                            widget.size.height * 0.019,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Expanded(child: Container()),
                                      widget.global.orderList[0].data[i]
                                      ["t_trip_status"] ==
                                          "completed"
                                          ? StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]["t_trip_status"],
                                          color: AppColor.green,
                                          size: widget.size)
                                          : widget.global.orderList[0].data[i]
                                      ["t_trip_status"] ==
                                          "completed_late"
                                          ? StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]
                                          ["t_trip_status"],
                                          color: AppColor.blue,
                                          size: widget.size)
                                          : widget.global.orderList[0].data[i]
                                      ["t_trip_status"] ==
                                          "failed"
                                          ? StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]["t_trip_status"],
                                          color: AppColor.red,
                                          size: widget.size)
                                          : StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]["t_trip_status"],
                                          color: AppColor.green,
                                          size: widget.size),
                                      SizedBox(
                                          width: widget.size.width * 0.01)
                                    ],
                                  ),
                                  SizedBox(
                                      height: widget.size.height * 0.002),
                                  Text("${DateFormat("dd/MM/yyyy HH:mm").format(
                                      DateTime.parse(
                                          widget.global.orderList[0].data[i]
                                          ["t_completed"]))}",
                                      style: TextStyle(
                                          color: AppColor.greyColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                          widget.size.height * 0.017)),
                                  SizedBox(
                                      height: widget.size.height * 0.015),
                                  Row(
                                    children: [
                                      Text("From: ",
                                          style: TextStyle(
                                            fontSize:
                                            widget.size.height * 0.018,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      SizedBox(
                                        width: widget.size.width * 0.6,
                                        child: Text(
                                            "${widget.global.orderList[0]
                                                .data[i]["t_trip_fromlocation"]}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize:
                                              widget.size.height * 0.016,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: widget.size.height * 0.005),
                                  Row(
                                    children: [
                                      Text("To: ",
                                          style: TextStyle(
                                            fontSize:
                                            widget.size.height * 0.018,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      SizedBox(
                                        width: widget.size.width * 0.6,
                                        child: Text(
                                            "${widget.global.orderList[0]
                                                .data[i]["t_trip_tolocation"]}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize:
                                              widget.size.height * 0.016,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: widget.size.height * 0.015),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() =>
                                              OrderDetails(
                                                startDate: DateFormat(
                                                    "dd/MM/yyyy HH:mm").format(
                                                    DateTime.parse(widget
                                                        .global
                                                        .orderList[0]
                                                        .data[i]["t_start_date"])),
                                                endDate: DateFormat(
                                                    "dd/MM/yyyy HH:mm").format(
                                                    DateTime.parse(widget
                                                        .global
                                                        .orderList[0]
                                                        .data[i]["t_end_date"])),
                                                fromLocation: widget.global
                                                    .orderList[0].data[i]
                                                ["t_trip_fromlocation"],
                                                toLocation: widget.global
                                                    .orderList[0].data[i]
                                                ["t_trip_tolocation"],
                                                totalDistance: widget.global
                                                    .orderList[0].data[i]
                                                ["t_totaldistance"],
                                                loadingTotal: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_loading_t"],
                                                unLoadingTotal: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_unloading_t"],
                                                weight: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_weight"],
                                                dimension: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_dimension"],
                                                status: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_trip_status"],
                                                trackingCode: widget.global
                                                    .orderList[0].data[i]
                                                ["t_trackingcode"],
                                                registrationNo: widget.global
                                                    .orderList[0].data[i]
                                                ["v_registration_no"],
                                                comDate: DateFormat(
                                                    "dd/MM/yyyy HH:mm").format(
                                                    DateTime.parse(
                                                        widget.global
                                                            .orderList[0]
                                                            .data[i]
                                                        ["t_completed"])),
                                              ));
                                        },
                                        child: Text(
                                          "See Details",
                                          style: TextStyle(
                                              color: AppColor.primaryColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                              widget.size.height * 0.02),
                                        ),
                                      ),
                                      Icon(Icons.keyboard_arrow_right,
                                          color: AppColor.primaryColor),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          } else if (widget.global.orderList[0].data[i]
                          ["t_start_date"].toString().contains(search.text)) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: widget.size.width * 0.05,
                                  vertical: widget.size.height * 0.015),
                              margin: EdgeInsets.symmetric(
                                  horizontal: widget.size.width * 0.04,
                                  vertical: widget.size.height * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    AppColor.greyColor.withOpacity(0.3),
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
                                      Text(
                                          "Order Id: ${widget.global
                                              .orderList[0].data[i]["t_id"]}",
                                          style: TextStyle(
                                            fontSize:
                                            widget.size.height * 0.019,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Expanded(child: Container()),
                                      widget.global.orderList[0].data[i]
                                      ["t_trip_status"] ==
                                          "completed"
                                          ? StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]["t_trip_status"],
                                          color: AppColor.green,
                                          size: widget.size)
                                          : widget.global.orderList[0].data[i]
                                      ["t_trip_status"] ==
                                          "completed_late"
                                          ? StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]
                                          ["t_trip_status"],
                                          color: AppColor.blue,
                                          size: widget.size)
                                          : widget.global.orderList[0].data[i]
                                      ["t_trip_status"] ==
                                          "failed"
                                          ? StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]["t_trip_status"],
                                          color: AppColor.red,
                                          size: widget.size)
                                          : StatusShow(
                                          text: widget.global.orderList[0]
                                              .data[i]["t_trip_status"],
                                          color: AppColor.green,
                                          size: widget.size),
                                      SizedBox(
                                          width: widget.size.width * 0.01)
                                    ],
                                  ),
                                  SizedBox(
                                      height: widget.size.height * 0.002),
                                  Text(DateFormat("dd/MM/yyyy HH:mm").format(
                                      DateTime.parse(
                                          widget.global.orderList[0].data[i]
                                          ["t_completed"])),
                                      style: TextStyle(
                                          color: AppColor.greyColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                          widget.size.height * 0.017)),
                                  SizedBox(
                                      height: widget.size.height * 0.015),
                                  Row(
                                    children: [
                                      Text("From: ",
                                          style: TextStyle(
                                            fontSize:
                                            widget.size.height * 0.018,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      SizedBox(
                                        width: widget.size.width * 0.6,
                                        child: Text(
                                            "${widget.global.orderList[0]
                                                .data[i]["t_trip_fromlocation"]}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize:
                                              widget.size.height * 0.016,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: widget.size.height * 0.005),
                                  Row(
                                    children: [
                                      Text("To: ",
                                          style: TextStyle(
                                            fontSize:
                                            widget.size.height * 0.018,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      SizedBox(
                                        width: widget.size.width * 0.6,
                                        child: Text(
                                            "${widget.global.orderList[0]
                                                .data[i]["t_trip_tolocation"]}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize:
                                              widget.size.height * 0.016,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: widget.size.height * 0.015),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() =>
                                              OrderDetails(
                                                startDate: DateFormat(
                                                    "dd/MM/yyyy HH:mm").format(
                                                    DateTime.parse(widget
                                                        .global
                                                        .orderList[0]
                                                        .data[i]["t_start_date"])),
                                                endDate: DateFormat(
                                                    "dd/MM/yyyy HH:mm").format(
                                                    DateTime.parse(widget
                                                        .global
                                                        .orderList[0]
                                                        .data[i]["t_end_date"])),
                                                fromLocation: widget.global
                                                    .orderList[0].data[i]
                                                ["t_trip_fromlocation"],
                                                toLocation: widget.global
                                                    .orderList[0].data[i]
                                                ["t_trip_tolocation"],
                                                totalDistance: widget.global
                                                    .orderList[0].data[i]
                                                ["t_totaldistance"],
                                                loadingTotal: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_loading_t"],
                                                unLoadingTotal: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_unloading_t"],
                                                weight: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_weight"],
                                                dimension: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_dimension"],
                                                status: widget
                                                    .global
                                                    .orderList[0]
                                                    .data[i]["t_trip_status"],
                                                trackingCode: widget.global
                                                    .orderList[0].data[i]
                                                ["t_trackingcode"],
                                                registrationNo: widget.global
                                                    .orderList[0].data[i]
                                                ["v_registration_no"],
                                                comDate: DateFormat(
                                                    "dd/MM/yyyy HH:mm").format(
                                                    DateTime.parse(
                                                        widget.global
                                                            .orderList[0]
                                                            .data[i]
                                                        ["t_completed"])),
                                              ));
                                        },
                                        child: Text(
                                          "See Details",
                                          style: TextStyle(
                                              color: AppColor.primaryColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                              widget.size.height * 0.02),
                                        ),
                                      ),
                                      Icon(Icons.keyboard_arrow_right,
                                          color: AppColor.primaryColor),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }
                        return Container();
                      })
                      : const EmptyActiveOrder(
                    text: 'You have no order history',
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
