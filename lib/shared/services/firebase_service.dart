import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  static Future<void> init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
      log('Token: ${await messaging.getToken()}');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }

    messaging.setAutoInitEnabled(true);
    messaging.subscribeToTopic('all');
  }
}
