import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/pages/onboarding/widgets/onboarding_page_indicator.dart';
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
      appBar: AppBar(
        title: Image.asset('asset/images/logo_light.png', height: 32),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.flag_rounded, color: Colors.green, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    "Let's Personalize",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 500))
                  .slideY(begin: -0.2, end: 0),
              const SizedBox(height: 8),
              Text(
                "Select your goals and we'll tailor Hub Finder for you",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 200),
                  ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final item = UserGoal.all[index];

                    return Observer(builder: (context) {
                      final isSelected =
                          widget.controller.selectedGoals.contains(item);

                      return _GoalTile(
                        item: item,
                        isSelected: isSelected,
                        index: index,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          setState(() {
                            widget.controller.selectGoal(item);
                          });
                        },
                      );
                    });
                  },
                  itemCount: UserGoal.all.length,
                ),
              ),
              const SizedBox(height: 12),
              const OnboardingPageIndicator(currentPage: 4),
              const SizedBox(height: 12),
              Observer(builder: (context) {
                final count = widget.controller.selectedGoals.length;
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _canSubmit ? widget.controller.next : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(count > 0 ? "Continue ($count selected)" : "Select at least one"),
                        if (count > 0) ...[
                          const SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoalTile extends StatelessWidget {
  final UserGoal item;
  final bool isSelected;
  final int index;
  final VoidCallback onTap;

  const _GoalTile({
    required this.item,
    required this.isSelected,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.green.withValues(alpha: 0.1) : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.green : Colors.grey.shade200,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    item.icon,
                    color: isSelected ? Colors.white : darkColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: isSelected ? Colors.green.shade700 : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.green : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: const Duration(milliseconds: 400),
          delay: Duration(milliseconds: 50 * index),
        )
        .slideX(begin: 0.1, end: 0);
  }
}
