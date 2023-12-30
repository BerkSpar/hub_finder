import 'package:flutter/material.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/shared/core/app_colors.dart';

class OnboardingPageUsername extends StatefulWidget {
  final OnboardingController controller;

  const OnboardingPageUsername({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<OnboardingPageUsername> createState() => _OnboardingPageUsernameState();
}

class _OnboardingPageUsernameState extends State<OnboardingPageUsername> {
  bool get _canSubmit => widget.controller.config.username?.isNotEmpty ?? false;

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
                "What is your github username?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "We use it to track your progress",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  setState(() {
                    widget.controller.config.username = value;
                  });
                },
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  decoration: TextDecoration.none,
                ),
                cursorColor: darkColor,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFF2F2F2),
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFF2F2F2),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  hintText: "Type your username",
                  hintStyle: TextStyle(
                    color: Color(0xFF5A5A5A),
                  ),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF2F2F2),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _canSubmit ? widget.controller.next : null,
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
