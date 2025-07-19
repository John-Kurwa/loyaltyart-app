// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class NotificationService {
//   static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

//   static Future<void> initialize() async {
//     await _messaging.requestPermission();

//     final token = await _messaging.getToken();
//     debugPrint("FCM Token: $token");

//     FirebaseMessaging.onMessage.listen((message) {
//       debugPrint("New foreground notification: ${message.notification?.title}");
//     });
//   }
// }
