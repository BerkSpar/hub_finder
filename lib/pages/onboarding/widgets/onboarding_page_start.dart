import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/pages/privacy_policy/privacy_policy_page.dart';
import 'package:hub_finder/pages/terms_and_conditions/terms_and_conditions_page.dart';

class OnboardingPageStart extends StatelessWidget {
  final OnboardingController controller;

  const OnboardingPageStart({
    Key? key,
    required this.controller,
  }) : super(key: key);

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
                "Elevate your coding prowess",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Enhance your developer skills effortlessly with Hub Finder",
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
                onPressed: controller.next,
                child: Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
