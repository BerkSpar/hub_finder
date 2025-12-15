import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/pages/onboarding/widgets/onboarding_page_indicator.dart';
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
        title: Image.asset('asset/images/logo_light.png', height: 32)
            .animate()
            .fadeIn(duration: const Duration(milliseconds: 600))
            .scale(begin: const Offset(0.8, 0.8)),
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
              Icon(
                Icons.rocket_launch_rounded,
                size: 64,
                color: Colors.green,
              )
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 500))
                  .scale(begin: const Offset(0.5, 0.5))
                  .then()
                  .shimmer(duration: const Duration(milliseconds: 1500)),
              const SizedBox(height: 24),
              Text(
                "Your Developer Companion",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 200),
                  )
                  .slideY(begin: 0.3, end: 0),
              const SizedBox(height: 12),
              Text(
                "Build habits, stay focused, and level up your skills",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 400),
                  )
                  .slideY(begin: 0.3, end: 0),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Improve your ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                      ),
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
                  ],
                ),
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 600),
                  )
                  .scale(begin: const Offset(0.9, 0.9)),
              const Spacer(),
              Text.rich(
                TextSpan(
                  text: "By continuing, you agree to our ",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                  children: [
                    TextSpan(
                      text: "Terms",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
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
                        fontWeight: FontWeight.w600,
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
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 800),
                  ),
              const SizedBox(height: 16),
              const OnboardingPageIndicator(currentPage: 0),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: widget.controller.next,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Get Started"),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 1000),
                  )
                  .slideY(begin: 0.3, end: 0),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
