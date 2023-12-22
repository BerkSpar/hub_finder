import 'package:flutter/material.dart';

class UserConfig {
  bool didOnboarding;
  List<String> goals;
  String? username;
  TimeOfDay? remindAt;
  List<String> tags;
  int commitGoal;

  UserConfig({
    this.didOnboarding = false,
    this.goals = const [],
    this.username,
    this.remindAt,
    this.tags = const [],
    this.commitGoal = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'did_onboarding': didOnboarding,
      'goals': goals,
      'username': username,
      'tags': tags,
      'commit_goal': commitGoal,
      'remind_at_hour': remindAt?.hour,
      'remind_at_minute': remindAt?.minute,
    };
  }

  factory UserConfig.fromMap(Map<String, dynamic> map) {
    return UserConfig(
      didOnboarding: map['did_onboarding'] ?? false,
      goals: List<String>.from(map['goals'] ?? []),
      username: map['username'],
      remindAt: map['remind_at_hour'] != null && map['remind_at_minute'] != null
          ? TimeOfDay(
              hour: map['remind_at_hour'],
              minute: map['remind_at_minute'],
            )
          : null,
      tags: List<String>.from(map['tags'] ?? []),
      commitGoal: map['commit_goal'] ?? 1,
    );
  }
}
