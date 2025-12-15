import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/pages/onboarding/widgets/onboarding_demo_container.dart';

class OnboardingPageDemoStreak extends StatelessWidget {
  final OnboardingController controller;

  const OnboardingPageDemoStreak({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingDemoContainer(
      controller: controller,
      headline: "Build Unbreakable Habits",
      benefitCopy: "Track your daily coding streak and never miss a day",
      bottomText: "Join developers who code every day",
      currentPage: 1,
      totalPages: 9,
      demoWidget: const _StreakDemoWidget(),
    );
  }
}

class _StreakDemoWidget extends StatefulWidget {
  const _StreakDemoWidget();

  @override
  State<_StreakDemoWidget> createState() => _StreakDemoWidgetState();
}

class _StreakDemoWidgetState extends State<_StreakDemoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildWeeklyStreak(),
          const SizedBox(height: 24),
          _buildCheckButton(),
          const SizedBox(height: 24),
          _buildStreakCounter(),
        ],
      ),
    );
  }

  Widget _buildWeeklyStreak() {
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        return _buildDayCircle(days[index], index < 7)
            .animate(delay: Duration(milliseconds: 100 * index))
            .fadeIn()
            .scale(begin: const Offset(0.5, 0.5));
      }),
    );
  }

  Widget _buildDayCircle(String day, bool isActive) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              color: isActive ? Colors.green : Colors.green.shade200,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          CircularProgressIndicator(
            value: isActive ? 1 : 0,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            strokeWidth: 2,
            backgroundColor: Colors.green.shade200,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckButton() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final scale = 1.0 + (_pulseController.value * 0.05);
        return Transform.scale(
          scale: scale,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            height: 100,
            width: 100,
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 50,
            ),
          ),
        );
      },
    );
  }

  Widget _buildStreakCounter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.whatshot,
              color: Color(0xFFFB7338),
              size: 32,
            ),
            const SizedBox(width: 8),
            const Text(
              "7",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        )
            .animate(delay: const Duration(milliseconds: 500))
            .fadeIn()
            .slideY(begin: 0.3),
        Text(
          "day streak",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
