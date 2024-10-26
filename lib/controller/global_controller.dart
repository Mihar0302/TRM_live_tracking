import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:trm/data/trip_model.dart';
import '../data/custom_model.dart';
import '../http/geolocator_services.dart';
import '../http/http-helper.dart';
import 'location_controller.dart';

class GlobalController extends GetxController {
  RxString usersToken = "".obs;
  RxString userName = "".obs;
  RxString userID = "".obs;
  RxString userEmail = "".obs;
  RxString userAddress = "".obs;
  RxString userNumber = "".obs;
  RxString userLicenseNo = "".obs;
  RxString userLicenseType = "".obs;
  RxString userLicenseIssueDate = "".obs;
  RxString userLicenseExpiry = "".obs;

  RxString vDNumber = ''.obs;
  RxString fcmToken = "".obs;

  List<CustomModel> orderList = [];

  RxBool errorLogin = false.obs;
  RxString showerrorText = "".obs;

  RxBool orderLoading = false.obs;

  orderGetApiCall() async {
    debugPrint("orderGetApiCall start ======>${orderList.length}");
    orderLoading.value = true;
    orderList.clear();
    CustomModel? customModel = await HttpHelper.ordersApi();
    if (customModel != null) {
      orderList.add(customModel);
      debugPrint("orderGetApiCall end ======>${orderList.length}");
      orderLoading.value = false;
    }
  }

  RxBool statusUpdate = false.obs;

  updateStatusApiCall(List orderId, String newStatus) async {
    statusUpdate.value = true;
    bool? data = await HttpHelper.updateStatus({
      "order_id": "$orderId",
      "new_status": newStatus,
    });
    if (data!) {
      getTripApiCall();
      statusUpdate.value = false;
    }
    getTripApiCall();
  }

  RxBool getTripLoading = false.obs;

  List<TripModel> tripList = [];

  List orderListData = [];

  getTripApiCall() async {
    getTripLoading.value = true;
    tripList.clear();
    TripModel? tripModel = await HttpHelper.getTripApi();
    if (tripModel != null) {
      tripList.add(tripModel);
      if (tripList.isNotEmpty) {
        debugPrint("==sdsfdsfasdfdfasd");
        for (var i = 0; i < tripList[0].data.length; i++) {
          debugPrint("== v id print ==?${tripList[0].data[0].registrationNo}");
          vDNumber.value = tripList[0].data[0].registrationNo;
          GeolocatorServices.getCurrentLocation(vDNumber.value);
          // Get.find<LocationController>().getCurrentLocation(
          //     tripList[0].data[i].VUserName);
        }
      }
    }
    getTripLoading.value = false;
  }
}
