import 'dart:io';
import 'dart:math';

import 'package:emptio/core/notification_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotifications {
  late FirebaseMessaging _messaging;
  late BuildContext mcontext;
  static const androidChannel = AndroidNotificationChannel(
    "com.gutomz.emptio",
    "Emptio Notifications",
    "App Emptio Notifications Channel",
    importance: Importance.max,
  );

  Future setupFirebase(BuildContext context) async {
    _messaging = FirebaseMessaging.instance;
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await NotificationHandler.initNotification(context, androidChannel);
    firebaseCloudMessageListener(context);
    mcontext = context;
  }

  void firebaseCloudMessageListener(BuildContext context) async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('Settings ${settings.authorizationStatus}');

    _messaging.getToken().then((token) => print('Messaging Token: $token'));

    FirebaseMessaging.onMessage.listen((remoteMessage) {
      print('Receive $remoteMessage');
      RemoteNotification? notification = remoteMessage.notification;
      AndroidNotification? android = remoteMessage.notification?.android;

      if (notification != null && android != null) {
        showNotification(notification);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      print('Received open app: $remoteMessage');
      if (Platform.isIOS) {
        showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text(remoteMessage.notification?.title ?? ""),
            content: Text(remoteMessage.notification?.body ?? ""),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("Ok"),
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
              )
            ],
          ),
        );
      }
    });
  }

  static void showNotification(RemoteNotification notification) async {
    var android = AndroidNotificationDetails(
      androidChannel.id,
      androidChannel.name,
      androidChannel.description,
      autoCancel: true,
      ongoing: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    var ios = IOSNotificationDetails();

    var platform = NotificationDetails(android: android, iOS: ios);

    await NotificationHandler.flutterLocalNotificationPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      platform,
    );
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handle background service $message');
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      showNotification(notification);
    }
  }
}
