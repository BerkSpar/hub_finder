import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/pages/onboarding/onboarding_page_end.dart';
import 'package:hub_finder/pages/onboarding/onboarding_page_goals.dart';
import 'package:hub_finder/pages/onboarding/onboarding_page_notifications.dart';
import 'package:hub_finder/pages/onboarding/onboarding_page_questions.dart';
import 'package:hub_finder/pages/onboarding/onboarding_page_start.dart';
import 'package:hub_finder/pages/onboarding/onboarding_page_username.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = OnboardingController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        OnboardingPageStart(controller: controller),
        OnboardingPageGoals(controller: controller),
        OnboardingPageUsername(controller: controller),
        OnboardingPageNotifications(controller: controller),
        OnboardingPageQuestions(controller: controller),
        OnboardingPageEnd(controller: controller),
      ],
    );
  }
}
