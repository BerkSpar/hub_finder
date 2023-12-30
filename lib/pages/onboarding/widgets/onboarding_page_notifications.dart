import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/shared/services/firebase_service.dart';
import 'package:hub_finder/shared/services/notification_service.dart';

class OnboardingPageNotifications extends StatefulWidget {
  final OnboardingController controller;

  const OnboardingPageNotifications({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<OnboardingPageNotifications> createState() =>
      _OnboardingPageNotificationsState();
}

class _OnboardingPageNotificationsState
    extends State<OnboardingPageNotifications> {
  TimeOfDay _time = TimeOfDay(
    hour: 18,
    minute: 0,
  );

  Future<void> _showTimerPicker() async {
    if (Platform.isIOS) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              initialDateTime: DateTime(2001, 12, 29, _time.hour, _time.minute),
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (DateTime newTime) {
                setState(() => _time = TimeOfDay.fromDateTime(newTime));
              },
            ),
          ),
        ),
      );
      return;
    }

    final result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (result != null) {
      setState(() => _time = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('asset/images/logo_light.png', height: 32),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(),
              Text(
                "It's important to remember",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Enable notifications to receive updates",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _showTimerPicker,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.notification_add_sharp,
                        color: Color(0xFF5A5A5A),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _time.format(context),
                        style: TextStyle(
                          color: Color(0xFF5A5A5A),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "You can change it later on settings",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFC6C6C6),
                  fontSize: 14,
                  fontFamily: 'Kumbh Sans',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  widget.controller.config.remindAt = _time;

                  await FirebaseService.init();

                  await NotificationService.instance.initialize();

                  await NotificationService.instance.scheduleNotification(
                    TimeOfDay.now(),
                  );

                  widget.controller.next();
                },
                child: Text("Continue"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
