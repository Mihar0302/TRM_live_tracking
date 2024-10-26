import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trm/controller/global_controller.dart';
import 'package:trm/controller/login_controller.dart';
import 'package:trm/screen/home_screen.dart';
import 'package:trm/widget/custom_btn.dart';
import 'package:trm/widget/custom_loading_popup.dart';
import 'package:trm/widget/custom_textfild.dart';

import '../utils/app_color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());
  GlobalController globalController = Get.find();
  RxBool passwordVisible = false.obs;

  @override
  void dispose() {
    loginController.mobile.text = "";
    loginController.password.text = "";
    globalController.showerrorText.value = "";
    globalController.errorLogin.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(
      () => CustomLoadingPopup(
        lodaing: loginController.loginLoading.value,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: const Text("Welcome Back",
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    )),
              ),
              SizedBox(height: size.height * 0.05),
              CustomTextFild(
                  showError: globalController.errorLogin.value,
                  error: globalController.showerrorText.value,
                  label: true,
                  margin: true,
                  size: size,
                  hint: "Mobile Number",
                  controller: loginController.mobile),
              SizedBox(height: size.height * 0.04),
              Obx(
                () => CustomTextFild(
                    showError: globalController.errorLogin.value,
                    error: globalController.showerrorText.value,
                    obsertext: passwordVisible.value,
                    label: true,
                    margin: true,
                    size: size,
                    hint: "Password",
                    controller: loginController.password,
                    button: InkWell(
                      onTap: () {
                        passwordVisible.value = !passwordVisible.value;
                      },
                      child: Icon(
                        passwordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColor.greyColor,
                      ),
                    )),
              ),
              SizedBox(height: size.height * 0.08),
              Btn(
                  size: size,
                  title: "Login",
                  func: () {
                    loginController.loginApiCall(() {
                      Get.off(() => const HomeScreen());
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
