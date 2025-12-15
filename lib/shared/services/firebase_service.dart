import 'dart:developer';
import 'dart:io';

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
      try {
        if (Platform.isIOS) {
          String? apnsToken = await messaging.getAPNSToken();
          if (apnsToken == null) {
            await Future.delayed(const Duration(seconds: 3));
            apnsToken = await messaging.getAPNSToken();
          }
        }
        final token = await messaging.getToken();
        log('Token: $token');
      } catch (e) {
        log('Failed to get FCM token: $e');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }

    messaging.setAutoInitEnabled(true);
    try {
      await messaging.subscribeToTopic('all');
    } catch (e) {
      log('Failed to subscribe to topic: $e');
    }
  }
}
