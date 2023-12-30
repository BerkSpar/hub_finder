import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/shared/core/app_colors.dart';
import 'package:hub_finder/shared/models/user_goal.dart';

class OnboardingPageGoals extends StatefulWidget {
  final OnboardingController controller;

  const OnboardingPageGoals({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<OnboardingPageGoals> createState() => _OnboardingPageGoalsState();
}

class _OnboardingPageGoalsState extends State<OnboardingPageGoals> {
  bool get _canSubmit => widget.controller.selectedGoals.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text(
                "What's your coding focus?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Define your path with hub finder",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final item = UserGoal.all[index];

                    return Observer(builder: (context) {
                      final isSelected =
                          widget.controller.selectedGoals.contains(item);

                      return ListTile(
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isSelected ? darkColor : Colors.grey[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            item.icon,
                            color: isSelected ? Colors.white : darkColor,
                          ),
                        ),
                        title: Text(item.title),
                        subtitle: Text(item.subtitle),
                        onTap: () {
                          setState(() {
                            widget.controller.selectGoal(item);
                          });
                        },
                        trailing: IconButton(
                          icon: Icon(Icons.add_circle, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              widget.controller.selectGoal(item);
                            });
                          },
                        ),
                      );
                    });
                  },
                  itemCount: UserGoal.all.length,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _canSubmit ? widget.controller.next : null,
                child: Text("Continue"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
