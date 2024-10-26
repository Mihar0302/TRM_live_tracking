// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationService {
//   static final _notification = FlutterLocalNotificationsPlugin();
//
//   static Future<void> initnotification() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     DarwinInitializationSettings initializationSettingsIOS =
//     DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       onDidReceiveLocalNotification: (
//           int id,
//           String? title,
//           String? body,
//           String? payload,
//           ) async {
//       },
//     );
//
//     InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     await _notification.initialize(
//       initializationSettings,
//       // onSelectNotification: (payload) {},
//     );
//   }
//
//   static showNotification(
//       int id,
//       String title,
//       String body,
//       ) async {
//     _notification.show(
//       id,
//       title,
//       body,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           "Channel_Id",
//           "Channel_Name",
//           channelDescription: "Channel_Description",
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//         iOS: DarwinNotificationDetails(
//           sound: "default.wav",
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future<void> initnotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
          ) async {},
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _notification.initialize(
      initializationSettings,
      // onSelectNotification: (payload) {},
    );
  }

  static showNotification(
      int id,
      String title,
      String body,
      ) async {
    _notification.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "Channel_Id",
          "Channel_Name",
          channelDescription: "Channel_Description",
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          sound: "default.wav",
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }
}
