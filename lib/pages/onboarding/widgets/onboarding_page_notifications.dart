import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/pages/onboarding/widgets/onboarding_page_indicator.dart';
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
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_active_rounded,
                  size: 48,
                  color: Colors.orange,
                ),
              )
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 500))
                  .scale(begin: const Offset(0.5, 0.5))
                  .then()
                  .shake(duration: const Duration(milliseconds: 500), hz: 3, rotation: 0.05),
              const SizedBox(height: 24),
              Text(
                "Never Break Your Streak",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 200),
                  )
                  .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 8),
              Text(
                "We'll remind you to keep your momentum going",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 300),
                  ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: _showTimerPicker,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.access_time_filled,
                          color: Colors.orange,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Daily Reminder",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _time.format(context),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.edit,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                ),
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 400),
                  )
                  .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, size: 14, color: Colors.grey.shade500),
                  const SizedBox(width: 4),
                  Text(
                    "You can change this later in settings",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 500),
                  ),
              const Spacer(),
              const OnboardingPageIndicator(currentPage: 6),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    widget.controller.config.remindAt = _time;

                    await FirebaseService.init();

                    await NotificationService.instance.initialize();

                    await NotificationService.instance.scheduleNotification(
                      TimeOfDay.now(),
                    );

                    widget.controller.next();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Enable Notifications"),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
