import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'onboarding_controller.g.dart';

class OnboardingController = _OnboardingControllerBase
    with _$OnboardingController;

abstract class _OnboardingControllerBase with Store {
  PageController pageController = PageController();

  void next() {
    if (pageController.page! < 5) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
