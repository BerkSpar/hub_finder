import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';

class OnboardingDemoContainer extends StatelessWidget {
  final OnboardingController controller;
  final String headline;
  final String benefitCopy;
  final Widget demoWidget;
  final String bottomText;
  final int currentPage;
  final int totalPages;

  const OnboardingDemoContainer({
    super.key,
    required this.controller,
    required this.headline,
    required this.benefitCopy,
    required this.demoWidget,
    required this.bottomText,
    required this.currentPage,
    required this.totalPages,
  });

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
              const SizedBox(height: 24),
              Text(
                headline,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 500))
                  .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 8),
              Text(
                benefitCopy,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 200),
                  )
                  .slideY(begin: 0.2, end: 0),
              const Spacer(),
              demoWidget
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 400),
                  )
                  .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
              const Spacer(),
              Text(
                bottomText,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 600),
                  ),
              const SizedBox(height: 24),
              _buildPageIndicator(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.next,
                child: const Text("Continue"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
