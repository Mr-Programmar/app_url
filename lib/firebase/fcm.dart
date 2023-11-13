import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';
import '../screens/notification_screen.dart';

class Fcm {
  static listenAppFCM() {
    FirebaseMessaging.onMessage.listen((event) async {
      print("OnApp FCM : $event");

      String title = event.notification!.title.toString();
      String body = event.notification!.body.toString();

      print("-----OnForegroundApp---$title");
      print("----OnForegroundApp---$body");

      displyNotification(title: title.toString(), body: body.toString());


    });
  }

  // listen background FCM

  static listenbackgroundFCM(message) async {
    print("FCM background message");

    var title = message.notification.title;
    var body = message.notification.body;
    print("-----On_background/OnTerminated ---$title");
    print("----On_background/OnTerminated---$body");
    displyNotification(title: title.toString(), body: body.toString());


  }

  static generateFCMDeviceToken() {
    try {
      FirebaseMessaging.instance.getToken().then((value) {
        print("Device Token: $value");
      });
    } catch (e) {
      print("Device Token e: $e");
    }
  }

  static onOpenNotificationAction() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("Notification opened in the app");

      try {
        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (context) => const NotificationsScreen()),
        );
      } catch (e) {
        print("Navigation error: $e");
      }
    });
  }

  static displyNotification(
      {required String title, required String body}) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ));

    flutterLocalNotificationsPlugin.show(
      1,
      title,
      body,
      const NotificationDetails(
          android: AndroidNotificationDetails(
        "test",
        "test",
        playSound: true,
        priority: Priority.high,
        importance: Importance.high,
        enableVibration: true,
      )),
    );
  }
}
