import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/custom_model.dart';
import '../http/http-helper.dart';
import '../widget/custom_error_popup.dart';
import 'global_controller.dart';

class LoginController extends GetxController {
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();

  List<LoginModel> loginData = [];
  List<UserData> userData = [];
  RxBool loginLoading = false.obs;

  loginApiCall(Function onClick) async {
    if (mobile.text.isNotEmpty) {
      if (password.text.isNotEmpty) {
        loginLoading.value = true;
        loginData.clear();
        LoginModel? loginModel =
            await HttpHelper.loginApi(mobile.text, password.text);
        if (loginModel != null) {
          loginData.add(loginModel);
          userData.add(loginData[0].userData!);
          debugPrint("orderGetApiCall======> > > > > >${loginData[0].token}");
          debugPrint("orderGetApiCall======> > > > > >${userData[0].mobile}");

          onClick();
        }
        loginLoading.value = false;
      } else {
        Methods.showAlertSnack("Alert", "Please enter Password !");
      }
    } else {
      Methods.showAlertSnack("Alert", "Please enter Mobile Number !");
    }
  }
}
