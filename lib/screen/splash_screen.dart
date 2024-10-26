import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trm/screen/home_screen.dart';
import 'package:trm/utils/app_color.dart';
import '../controller/global_controller.dart';
import '../notification_data/push_notif_service.dart';
import '../utils/app_images.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalController global = Get.find();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      if (global.usersToken.value.isNotEmpty) {
        Get.off(() => const HomeScreen());
      } else {
        Get.off(() => const LoginScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AppImages.logo,
              height: size.height * 0.14,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Titan ",
                  style: TextStyle(
                      fontSize: size.height * 0.023,
                      color: const Color(0xffFF6600),
                      fontWeight: FontWeight.w500)),
              Text("Route ",
                  style: TextStyle(
                      fontSize: size.height * 0.023,
                      color: const Color(0xff005482),
                      fontWeight: FontWeight.w500)),
              Text("Master",
                  style: TextStyle(
                      fontSize: size.height * 0.023,
                      color: const Color(0xff84CC00),
                      fontWeight: FontWeight.w500))
            ],
          ),
        ],
      ),
    );
  }
}
