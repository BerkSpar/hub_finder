import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/pages/privacy_policy/privacy_policy_page.dart';
import 'package:hub_finder/pages/terms_and_conditions/terms_and_conditions_page.dart';
import 'package:hub_finder/shared/models/user_goal.dart';

class OnboardingPageStart extends StatefulWidget {
  final OnboardingController controller;

  OnboardingPageStart({
    Key? key,
    required this.controller,
  }) : super(key: key) {
    FirebaseAnalytics.instance.logTutorialBegin();
  }

  @override
  State<OnboardingPageStart> createState() => _OnboardingPageStartState();
}

class _OnboardingPageStartState extends State<OnboardingPageStart> {
  String text = "skills";

  int currentGoal = 0;

  void suffleText() {
    if (currentGoal == UserGoal.all.length - 1) {
      currentGoal = 0;
    } else {
      currentGoal++;
    }

    setState(() {
      text = UserGoal.all[currentGoal].title.toLowerCase();
    });
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
                "Improve your ",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              )
                  .animate(
                    autoPlay: true,
                    onComplete: (controller) {
                      controller.repeat();
                    },
                  )
                  .fadeIn(duration: Duration(seconds: 1))
                  .fadeOut(
                    duration: Duration(seconds: 1),
                    delay: Duration(seconds: 2),
                  )
                  .callback(
                    callback: (_) => suffleText(),
                  ),
              const SizedBox(height: 16),
              Text(
                "Enhance your developer skills with Hub Finder",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Text.rich(
                TextSpan(
                  text: "Using this application you agree with our ",
                  children: [
                    TextSpan(
                      text: "Terms of Service",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          FirebaseAnalytics.instance
                              .logEvent(name: 'read_terms_and_conditions');

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => TermsAndConditionsPage(),
                            ),
                          );
                        },
                    ),
                    TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          FirebaseAnalytics.instance
                              .logEvent(name: 'read_privacy_policy');

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PrivacyPolicyPage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: widget.controller.next,
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
