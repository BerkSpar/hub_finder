class UserConfig {
  bool didOnboarding;
  List<String> goals;
  String? username;
  DateTime? remindAt;
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
      'remind_at': remindAt?.millisecondsSinceEpoch,
      'tags': tags,
      'commit_goal': commitGoal,
    };
  }

  factory UserConfig.fromMap(Map<String, dynamic> map) {
    return UserConfig(
      didOnboarding: map['did_onboarding'] ?? false,
      goals: List<String>.from(map['goals'] ?? []),
      username: map['username'],
      remindAt: map['remind_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['remind_at'])
          : null,
      tags: List<String>.from(map['tags'] ?? []),
      commitGoal: map['commit_goal'] ?? 1,
    );
  }
}
