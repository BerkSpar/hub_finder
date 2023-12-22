// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OnboardingController on _OnboardingControllerBase, Store {
  late final _$selectedGoalsAtom =
      Atom(name: '_OnboardingControllerBase.selectedGoals', context: context);

  @override
  ObservableList<UserGoal> get selectedGoals {
    _$selectedGoalsAtom.reportRead();
    return super.selectedGoals;
  }

  @override
  set selectedGoals(ObservableList<UserGoal> value) {
    _$selectedGoalsAtom.reportWrite(value, super.selectedGoals, () {
      super.selectedGoals = value;
    });
  }

  late final _$_OnboardingControllerBaseActionController =
      ActionController(name: '_OnboardingControllerBase', context: context);

  @override
  void selectGoal(UserGoal goal) {
    final _$actionInfo = _$_OnboardingControllerBaseActionController
        .startAction(name: '_OnboardingControllerBase.selectGoal');
    try {
      return super.selectGoal(goal);
    } finally {
      _$_OnboardingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedGoals: ${selectedGoals}
    ''';
  }
}
