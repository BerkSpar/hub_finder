import 'package:flutter/material.dart';

class UserConfig {
  bool didOnboarding;
  List<String> goals;
  String? username;
  TimeOfDay? remindAt;
  List<String> tags;
  int commitGoal;
  int focusWorkDuration;
  int focusShortBreakDuration;
  int focusLongBreakDuration;
  int focusCyclesBeforeLongBreak;
  String focusCurrentType;
  int focusRemainingSeconds;
  int focusCompletedPomodoros;
  DateTime? focusExpectedEndTime;
  bool focusIsRunning;

  UserConfig({
    this.didOnboarding = false,
    this.goals = const [],
    this.username,
    this.remindAt,
    this.tags = const [],
    this.commitGoal = 1,
    this.focusWorkDuration = 25,
    this.focusShortBreakDuration = 5,
    this.focusLongBreakDuration = 15,
    this.focusCyclesBeforeLongBreak = 4,
    this.focusCurrentType = 'work',
    this.focusRemainingSeconds = 0,
    this.focusCompletedPomodoros = 0,
    this.focusExpectedEndTime,
    this.focusIsRunning = false,
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
      'focus_work_duration': focusWorkDuration,
      'focus_short_break_duration': focusShortBreakDuration,
      'focus_long_break_duration': focusLongBreakDuration,
      'focus_cycles_before_long_break': focusCyclesBeforeLongBreak,
      'focus_current_type': focusCurrentType,
      'focus_remaining_seconds': focusRemainingSeconds,
      'focus_completed_pomodoros': focusCompletedPomodoros,
      'focus_expected_end_time': focusExpectedEndTime?.toIso8601String(),
      'focus_is_running': focusIsRunning,
    };
  }

  factory UserConfig.fromMap(Map map) {
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
      focusWorkDuration: map['focus_work_duration'] ?? 25,
      focusShortBreakDuration: map['focus_short_break_duration'] ?? 5,
      focusLongBreakDuration: map['focus_long_break_duration'] ?? 15,
      focusCyclesBeforeLongBreak: map['focus_cycles_before_long_break'] ?? 4,
      focusCurrentType: map['focus_current_type'] ?? 'work',
      focusRemainingSeconds: map['focus_remaining_seconds'] ?? 0,
      focusCompletedPomodoros: map['focus_completed_pomodoros'] ?? 0,
      focusExpectedEndTime: map['focus_expected_end_time'] != null
          ? DateTime.parse(map['focus_expected_end_time'])
          : null,
      focusIsRunning: map['focus_is_running'] ?? false,
    );
  }
}
