import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/global_controller.dart';
import '../utils/app_color.dart';
import '../widget/custom_appbar.dart';

class OrderDetails extends StatelessWidget {
  final String startDate;
  final String endDate;
  final String fromLocation;
  final String toLocation;
  final String totalDistance;
  final String loadingTotal;
  final String unLoadingTotal;
  final String weight;
  final String dimension;
  final String status;
  final String trackingCode;
  final String registrationNo;
  final String comDate;

  const OrderDetails({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.fromLocation,
    required this.toLocation,
    required this.totalDistance,
    required this.loadingTotal,
    required this.unLoadingTotal,
    required this.weight,
    required this.dimension,
    required this.status,
    required this.trackingCode,
    required this.registrationNo,
    required this.comDate,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppbar(
                changimg: false,
                size: size,
                funfilter: () {},
                lable: "Order Details",
                fun: () {
                  Get.back();
                },
                sizechange: size.width * 0.054),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.03,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03, vertical: size.height * 0.04),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 20,
                    color: Colors.grey.withOpacity(0.23),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order Details",
                      style: TextStyle(
                          fontSize: size.height * 0.023,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: size.height * 0.04),
                  RowText(size: size, label: "Start Date", value: startDate),
                  SizedBox(height: size.height * 0.02),
                  RowText(size: size, label: "End Date", value: endDate),
                  SizedBox(height: size.height * 0.02),
                  RowText(size: size, label: "Completed Date", value: comDate),
                  SizedBox(height: size.height * 0.02),
                  RowText(
                      size: size, label: "From Location", value: fromLocation),
                  SizedBox(height: size.height * 0.02),
                  RowText(size: size, label: "To Location", value: toLocation),
                  SizedBox(height: size.height * 0.02),
                  RowText(
                      size: size,
                      label: "Total Distance",
                      value: totalDistance),
                  SizedBox(height: size.height * 0.02),
                  RowText(
                      size: size, label: "Loading Total", value: loadingTotal),
                  SizedBox(height: size.height * 0.02),
                  RowText(
                      size: size,
                      label: "Unloading Total",
                      value: unLoadingTotal),
                  SizedBox(height: size.height * 0.02),
                  RowText(size: size, label: "Weight", value: weight),
                  SizedBox(height: size.height * 0.02),
                  RowText(size: size, label: "Dimension", value: dimension),
                  SizedBox(height: size.height * 0.02),
                  RowText(size: size, label: "Status", value: status),
                  SizedBox(height: size.height * 0.02),
                  RowText(
                      size: size, label: "Tracking Code", value: trackingCode),
                  SizedBox(height: size.height * 0.02),
                  RowText(
                      size: size,
                      label: "Registration No",
                      value: registrationNo),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RowText extends StatelessWidget {
  final Size size;
  final String label;
  final String value;

  const RowText(
      {super.key,
      required this.size,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$label: ",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: size.height * 0.019,
            )),
        Expanded(child: Container()),
        SizedBox(
          width: size.width * 0.48,
          child: Text(value,
              maxLines: 5,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: size.height * 0.02,
                  color: AppColor.greyColor)),
        )
      ],
    );
  }
}
