import 'package:flutter/material.dart';
import 'package:hub_finder/shared/models/user_config.dart';
import 'package:hub_finder/shared/models/user_goal.dart';
import 'package:hub_finder/shared/services/database_service.dart';
import 'package:mobx/mobx.dart';
part 'onboarding_controller.g.dart';

class OnboardingController = _OnboardingControllerBase
    with _$OnboardingController;

abstract class _OnboardingControllerBase with Store {
  LocalStorageService localStorageService = LocalStorageService();
  PageController pageController = PageController();
  UserConfig config = UserConfig();

  @observable
  ObservableList<UserGoal> selectedGoals = ObservableList<UserGoal>();

  @action
  void selectGoal(UserGoal goal) {
    if (selectedGoals.contains(goal)) {
      selectedGoals.remove(goal);
    } else {
      selectedGoals.add(goal);
    }

    config.goals = selectedGoals.map((e) => e.title).toList();
  }

  void next() {
    _save();

    if (pageController.page! < 5) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _save() async {
    return await localStorageService.saveConfig(config);
  }
}
