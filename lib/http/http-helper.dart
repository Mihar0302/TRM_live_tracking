import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trm/http/shared_pref_helper.dart';
import 'package:trm/widget/custom_error_popup.dart';
import '../controller/global_controller.dart';
import '../data/custom_model.dart';
import '../data/trip_model.dart';

class HttpHelper {
  static final http.Client _client = http.Client();

  static Future<LoginModel?> loginApi(
    String mobile,
    String password,
  ) async {
    final GlobalController globalController = Get.find();
    // try {
    final response = await _client
        .post(Uri.parse("https://app.routingnow.com/apis/login"), body: {
      "mobile": mobile,
      "password": password,
      "fcmtoken": globalController.fcmToken.value
    }, headers: {
      "Accept": "application/json"
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("==>${response.statusCode}");
      final SharedPreferencesHelper prefs = SharedPreferencesHelper(
        pref: await SharedPreferences.getInstance(),
      );
      debugPrint('    jwt    ${jsonDecode(response.body)["token"]}');
      await prefs.setUserToken(jsonDecode(response.body)["token"]);
      await prefs.setName(jsonDecode(response.body)["user"]["d_name"] ?? "");
      await prefs
          .setNumber(jsonDecode(response.body)["user"]["d_mobile"] ?? "");
      await prefs.setAge(jsonDecode(response.body)["user"]["d_age"] ?? "");
      await prefs.setId(jsonDecode(response.body)["user"]["d_id"] ?? "");
      await prefs.setEmail(jsonDecode(response.body)["user"]["d_email"] ?? "");
      await prefs
          .setAddress(jsonDecode(response.body)["user"]["d_address"] ?? "");
      await prefs
          .setLicenseNo(jsonDecode(response.body)["user"]["d_licenseno"] ?? "");
      await prefs.setTypeLicense(
          jsonDecode(response.body)["user"]["d_lice_type"] ?? "");
      await prefs
          .setIssueDate(jsonDecode(response.body)["user"]["d_doj"] ?? '');
      await prefs.setExpiryDate(
          jsonDecode(response.body)["user"]["d_license_expdate"] ?? "");

      globalController.usersToken.value = prefs.getUserToken;
      globalController.userID.value = prefs.getuserId;
      globalController.userName.value = prefs.getName;
      globalController.userEmail.value = prefs.getuserEmail;
      globalController.userAddress.value = prefs.getuserAddress;
      globalController.userNumber.value = prefs.getNumber;
      globalController.userLicenseNo.value = prefs.getuserLicenseNo;
      globalController.userLicenseType.value = prefs.getuserTypeLicense;
      globalController.userLicenseIssueDate.value = prefs.getuserIssueDate;
      globalController.userLicenseExpiry.value = prefs.getuserExpiryDate;
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      globalController.errorLogin.value = true;
      globalController.showerrorText.value = jsonDecode(response.body)["error"];
      Methods.showAlertSnack("Alert", jsonDecode(response.body)["error"]);

      return null;
    }
    // } catch (e) {
    //   debugPrint("=====>  Error login Api===> $e");
    //
    //   return null;
    // }
  }

  static Future<CustomModel?> ordersApi() async {
    GlobalController global = Get.find();
    try {
      final response = await _client
          .get(Uri.parse("https://app.routingnow.com/apis/myorders"), headers: {
        "Accept": "application/json",
        "Authorization": global.usersToken.value
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("==> ordersApi ${response.statusCode}");
        return CustomModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("=====>  Error login Api===> $e");
      return null;
    }
  }

  static Future<TripModel?> getTripApi() async {
    GlobalController global = Get.find();
    try {
      final response = await _client
          .get(Uri.parse("https://app.routingnow.com/apis/mytrips"), headers: {
        "Accept": "application/json",
        "Authorization": global.usersToken.value
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("==> ordersApi ${response.statusCode}");
        return TripModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("=====>  Error login Api===> $e");
      return null;
    }
  }

  static Future<bool?> shareLatLon(
      String lat, String lon, String id, double speed) async {
    try {
      final response = await _client.post(
          Uri.parse(
              "https://app.routingnow.com/api?id=$id&lat=$lat&lon=$lon&speed=$speed"),
          body: {
            "id": id,
            "lat": lat,
            "lon": lon,
            "speed": "$speed",
          });
      debugPrint("==>post data print  ==> response.statusCode ${{
        "id": id,
        "lat": lat,
        "lon": lon,
        "speed": "$speed",
      }}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(
            "==>share live LatLon ==> response.statusCode ${response.statusCode}");
        return true;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("=====>  Error login Api===> $e");

      return null;
    }
  }

  static Future<bool?> updateStatus(Map body) async {
    GlobalController global = Get.find();
    try {
      final response = await _client.post(
          Uri.parse("https://app.routingnow.com/apis/update_status"),
          body: body,
          headers: {
            "Accept": "application/json",
            "Authorization": global.usersToken.value
          });

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("==>response ==>  ${response.body}");
        return true;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("=====>  Error updateStatus Api===> $e");

      return null;
    }
  }
}
