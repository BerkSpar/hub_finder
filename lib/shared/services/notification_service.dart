import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:hub_finder/shared/models/focus_type.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final instance = NotificationService();
  static const int _focusScheduledNotificationId = 100;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz_data.initializeTimeZones();
    final timezoneInfo = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: null,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> scheduleNotification(TimeOfDay time) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'hub_finder',
      'daily',
      importance: Importance.high,
      priority: Priority.high,
    );

    final DarwinNotificationDetails darwinPlatformChannelSpecifics =
        DarwinNotificationDetails(
      threadIdentifier: 'daily',
    );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'Time to review your day',
      'Take a moment to review your day and learn from your mistakes',
      RepeatInterval.daily,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> showFocusCompleteNotification(FocusType type) async {
    String title;
    String body;

    switch (type) {
      case FocusType.work:
        title = 'Focus Session Complete!';
        body = 'Great work! Time for a break.';
        break;
      case FocusType.shortBreak:
        title = 'Break Over';
        body = 'Ready to focus again?';
        break;
      case FocusType.longBreak:
        title = 'Long Break Over';
        body = 'Feeling refreshed? Let\'s get back to work!';
        break;
    }

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'focus_timer',
      'Focus Timer',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    final DarwinNotificationDetails darwinPlatformChannelSpecifics =
        DarwinNotificationDetails(
      threadIdentifier: 'focus_timer',
      presentSound: true,
    );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      1,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  Future<void> scheduleFocusCompleteNotification(
    DateTime scheduledTime,
    FocusType type,
  ) async {
    String title;
    String body;

    switch (type) {
      case FocusType.work:
        title = 'Focus Session Complete!';
        body = 'Great work! Time for a break.';
        break;
      case FocusType.shortBreak:
        title = 'Break Over';
        body = 'Ready to focus again?';
        break;
      case FocusType.longBreak:
        title = 'Long Break Over';
        body = 'Feeling refreshed? Let\'s get back to work!';
        break;
    }

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'focus_timer',
      'Focus Timer',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    final DarwinNotificationDetails darwinPlatformChannelSpecifics =
        DarwinNotificationDetails(
      threadIdentifier: 'focus_timer',
      presentSound: true,
    );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
    );

    final tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      _focusScheduledNotificationId,
      title,
      body,
      tzScheduledTime,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelScheduledFocusNotification() async {
    await _flutterLocalNotificationsPlugin
        .cancel(_focusScheduledNotificationId);
  }
}
