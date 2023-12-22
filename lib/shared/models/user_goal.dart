import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UserGoal {
  String title;
  String subtitle;

  IconData materialIcon;
  IconData cupertinoIcon;

  IconData get icon {
    if (Platform.isIOS) return cupertinoIcon;
    return materialIcon;
  }

  UserGoal({
    required this.title,
    required this.subtitle,
    required this.materialIcon,
    required this.cupertinoIcon,
  });

  static List<UserGoal> all = [
    UserGoal(
      title: "Personal Projects",
      subtitle: "Focus on personal projects",
      materialIcon: Icons.person,
      cupertinoIcon: CupertinoIcons.person,
    ),
    UserGoal(
      title: "Open Source",
      subtitle: "Focus on open source projects",
      materialIcon: Icons.code,
      cupertinoIcon: CupertinoIcons.macwindow,
    ),
    UserGoal(
      title: "Work",
      subtitle: "Focus on work projects",
      materialIcon: Icons.work,
      cupertinoIcon: CupertinoIcons.briefcase,
    ),
  ];
}
