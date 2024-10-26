import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trm/screen/splash_screen.dart';
import 'controller/global_controller.dart';
import 'http/shared_pref_helper.dart';
import 'notification_data/push_notif_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GlobalController globalCacheController = Get.put(GlobalController());
  await PushNotificationService.initialise(globalCacheController);
  final SharedPreferencesHelper prefs = SharedPreferencesHelper(
    pref: await SharedPreferences.getInstance(),
  );
  globalCacheController.usersToken.value = prefs.getUserToken;
  globalCacheController.userID.value = prefs.getuserId;
  globalCacheController.userName.value = prefs.getName;
  globalCacheController.userEmail.value = prefs.getuserEmail;
  globalCacheController.userAddress.value = prefs.getuserAddress;
  globalCacheController.userNumber.value = prefs.getNumber;
  globalCacheController.userLicenseNo.value = prefs.getuserLicenseNo;
  globalCacheController.userLicenseType.value = prefs.getuserTypeLicense;
  globalCacheController.userLicenseIssueDate.value = prefs.getuserIssueDate;
  globalCacheController.userLicenseExpiry.value = prefs.getuserExpiryDate;
  debugPrint("====> token ==> ${globalCacheController.usersToken.value}");
  globalCacheController.getTripApiCall();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalController cacheController = Get.find();
    return GetMaterialApp(
      title: "Titan Route Master",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "open_sans_regular",
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        ),
      ),
      home: const SplashScreen(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
