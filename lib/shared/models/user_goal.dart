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
      subtitle: "Collaborate with the community",
      materialIcon: Icons.public,
      cupertinoIcon: CupertinoIcons.share,
    ),
    UserGoal(
      title: "Work",
      subtitle: "Tackle professional projects",
      materialIcon: Icons.work,
      cupertinoIcon: CupertinoIcons.briefcase,
    ),
    UserGoal(
      title: "Learning",
      subtitle: "Expand your knowledge base",
      materialIcon: Icons.school,
      cupertinoIcon: CupertinoIcons.book,
    ),
    UserGoal(
      title: "Networking",
      subtitle: "Connect with fellow developers",
      materialIcon: Icons.group,
      cupertinoIcon: CupertinoIcons.person_2,
    ),
    UserGoal(
      title: "Problem-solving",
      subtitle: "Tackle coding challenges",
      materialIcon: Icons.build,
      cupertinoIcon: CupertinoIcons.hammer,
    ),
    UserGoal(
      title: "Mentoring",
      subtitle: "Share your knowledge",
      materialIcon: Icons.lightbulb,
      cupertinoIcon: CupertinoIcons.lightbulb,
    ),
    UserGoal(
      title: "Side Hustles",
      subtitle: "Explore additional projects",
      materialIcon: Icons.directions_run,
      cupertinoIcon: CupertinoIcons.ellipsis_vertical,
    ),
    UserGoal(
      title: "Coding competitions",
      subtitle: "Test your skills",
      materialIcon: Icons.emoji_events,
      cupertinoIcon: CupertinoIcons.game_controller,
    ),
    UserGoal(
      title: "Community Involvement",
      subtitle: "Engage in coding communities",
      materialIcon: Icons.people,
      cupertinoIcon: CupertinoIcons.group,
    ),
  ];
}
