// import 'dart:io';
//
// import 'package:ReNew8/controller/global_controller.dart';
// import 'package:ReNew8/notification_data/local_notification_service.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
//
// Future<void> _firebaseMessagingBackgroundHandler(
//   RemoteMessage message,
// ) async {
//   await Firebase.initializeApp();
//   debugPrint('=====>    A bg message just showed up :  ${message.data}');
// }
//
// class PushNotificationService {
//   static Future<void> initialise(GlobalController controller) async {
//     await Firebase.initializeApp();
//     // await NotificationService.initnotification();
//
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     if(Platform.isIOS) {
//       FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//         sound: true,
//         alert: true,
//         badge: true,
//       );
//     }
//     controller.userToken.value = (await FirebaseMessaging.instance.getToken())!;
//     debugPrint(
//         "======>  FCM Token  =====   ${await FirebaseMessaging.instance.getToken()}");
//     debugPrint(
//         "======>  FCM Token with global ?? =====   ${await FirebaseMessaging.instance.getToken()}");
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       debugPrint("=======>  Message recived  =====   ${message.notification}");
//       if (message.notification != null) {
//         NotificationService.showNotification(
//           message.hashCode,
//           message.notification!.title ?? "Title",
//           message.notification!.body!,
//         );
//       }
//     });
//
//     FirebaseMessaging.instance.onTokenRefresh.listen((String newToken) {
//       debugPrint("========> new token ==> $newToken");
//     });
//   }
// }

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../controller/global_controller.dart';
import 'local_notification_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp();
  debugPrint('=====>    A bg message just showed up :  ${message.data}');
}

class PushNotificationService {
  static Future<void> initialise(GlobalController controller) async {
    await FirebaseMessaging.instance.requestPermission();
    await NotificationService.initnotification();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (Platform.isIOS) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        sound: true,
        alert: true,
        badge: true,
      );
    }
    controller.fcmToken.value = (await FirebaseMessaging.instance.getToken())!;
    debugPrint(
        "======>  FCM Token  =====   ${await FirebaseMessaging.instance.getToken()}");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint(
          "======>  notification body  =====   ${message.notification!.body}");
      await controller.getTripApiCall();
      if (message.notification != null) {
        NotificationService.showNotification(
          message.hashCode,
          message.notification!.title ?? "Title",
          message.notification!.body!,
        );
      }
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((String newToken) {
      debugPrint("======>  notification body  =====   $newToken");
    });
  }
}
