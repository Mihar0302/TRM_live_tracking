import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trm/controller/global_controller.dart';
import 'package:trm/screen/login_screen.dart';
import 'package:trm/utils/app_color.dart';
import 'package:trm/widget/custom_textfild.dart';

import '../http/shared_pref_helper.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  GlobalController globalCacheController = Get.find();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController licenseNo = TextEditingController();
  TextEditingController licenseType = TextEditingController();
  TextEditingController licenseIssueDate = TextEditingController();
  TextEditingController licenseExpDate = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();

  @override
  void initState() {
    id.text = globalCacheController.userID.value;
    name.text = globalCacheController.userName.value;
    email.text = globalCacheController.userEmail.value;
    address.text = globalCacheController.userAddress.value;
    mobileNumber.text = globalCacheController.userNumber.value;
    licenseNo.text = globalCacheController.userLicenseNo.value;
    licenseType.text = globalCacheController.userLicenseType.value;
    licenseIssueDate.text = globalCacheController.userLicenseIssueDate.value;
    licenseExpDate.text = globalCacheController.userLicenseExpiry.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTextFild(
            readOnly: true,
            margin: true,
            size: size,
            hint: "Employee ID",
            controller: id,
            label: true,
          ),
          SizedBox(height: size.height * 0.025),
          CustomTextFild(
            readOnly: true,
            margin: true,
            size: size,
            hint: "Name",
            controller: name,
            label: true,
          ),
          SizedBox(height: size.height * 0.025),
          CustomTextFild(
            readOnly: true,
            margin: true,
            size: size,
            hint: "Email",
            controller: email,
            label: true,
          ),
          SizedBox(height: size.height * 0.025),
          CustomTextFild(
            readOnly: true,
            margin: true,
            size: size,
            hint: "Address",
            controller: address,
            label: true,
          ),
          SizedBox(height: size.height * 0.025),
          CustomTextFild(
            readOnly: true,
            margin: true,
            size: size,
            hint: "Mobile Number",
            controller: mobileNumber,
            label: true,
          ),
          SizedBox(height: size.height * 0.025),
          CustomTextFild(
            readOnly: true,
            margin: true,
            size: size,
            hint: "License No",
            controller: id,
            label: true,
          ),
          SizedBox(height: size.height * 0.025),
          CustomTextFild(
            readOnly: true,
            margin: true,
            size: size,
            hint: "License Type",
            controller: licenseType,
            label: true,
          ),
          SizedBox(height: size.height * 0.025),
          CustomTextFild(
            readOnly: true,
            margin: true,
            size: size,
            hint: "License Issue Date",
            controller: licenseIssueDate,
            label: true,
          ),
          SizedBox(height: size.height * 0.025),
          CustomTextFild(
            readOnly: true,
            margin: true,
            size: size,
            hint: "License Exp Date",
            controller: licenseExpDate,
            label: true,
          ),
          SizedBox(height: size.height * 0.05),
          InkWell(
            onTap: () async {
              final SharedPreferencesHelper prefs = SharedPreferencesHelper(
                pref: await SharedPreferences.getInstance(),
              );
              prefs.setUserToken("");
              globalCacheController.usersToken.value = "";
              Get.offAll(const LoginScreen());
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
                vertical: size.height * 0.018,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColor.red.withOpacity(0.3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Logout",
                      style: TextStyle(
                          color: AppColor.red,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.021)),
                  SizedBox(width: size.width * 0.03),
                  Icon(
                    Icons.logout,
                    size: size.height * 0.03,
                    color: AppColor.red,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }
}
