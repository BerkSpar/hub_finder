import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/pages/onboarding/widgets/onboarding_demo_container.dart';
import 'dart:math' as math;

class OnboardingPageDemoTimer extends StatelessWidget {
  final OnboardingController controller;

  const OnboardingPageDemoTimer({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingDemoContainer(
      controller: controller,
      headline: "Deep Work, Real Results",
      benefitCopy: "Pomodoro timer designed for developers",
      bottomText: "Stay in the zone and ship faster",
      currentPage: 2,
      totalPages: 9,
      demoWidget: const _TimerDemoWidget(),
    );
  }
}

class _TimerDemoWidget extends StatefulWidget {
  const _TimerDemoWidget();

  @override
  State<_TimerDemoWidget> createState() => _TimerDemoWidgetState();
}

class _TimerDemoWidgetState extends State<_TimerDemoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  int _selectedType = 0;

  static const Color focusColor = Color(0xFFE74C3C);
  static const Color shortBreakColor = Color(0xFF2ECC71);
  static const Color longBreakColor = Color(0xFF3498DB);

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  Color get _currentColor {
    switch (_selectedType) {
      case 0:
        return focusColor;
      case 1:
        return shortBreakColor;
      case 2:
        return longBreakColor;
      default:
        return focusColor;
    }
  }

  String get _currentLabel {
    switch (_selectedType) {
      case 0:
        return 'FOCUS';
      case 1:
        return 'SHORT BREAK';
      case 2:
        return 'LONG BREAK';
      default:
        return 'FOCUS';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTypeSelector(),
          const SizedBox(height: 24),
          _buildCircularTimer(),
          const SizedBox(height: 24),
          _buildStats(),
        ],
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTypeButton('Focus', 0, focusColor),
        const SizedBox(width: 8),
        _buildTypeButton('Short', 1, shortBreakColor),
        const SizedBox(width: 8),
        _buildTypeButton('Long', 2, longBreakColor),
      ],
    )
        .animate(delay: const Duration(milliseconds: 200))
        .fadeIn()
        .slideY(begin: -0.2);
  }

  Widget _buildTypeButton(String label, int index, Color color) {
    final isSelected = _selectedType == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildCircularTimer() {
    final size = 180.0;
    return AnimatedBuilder(
      animation: _progressController,
      builder: (context, child) {
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(size, size),
                painter: _CircularProgressPainter(
                  progress: _progressController.value * 0.5 + 0.3,
                  color: _currentColor,
                  backgroundColor: Colors.grey.shade200,
                  strokeWidth: 10,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _currentLabel,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "12:30",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).animate(delay: const Duration(milliseconds: 400)).fadeIn().scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          curve: Curves.easeOutBack,
        );
  }

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStatItem(Icons.timer_outlined, "2h 15m", "focused"),
          Container(
            height: 30,
            width: 1,
            color: Colors.grey.shade200,
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          _buildStatItem(Icons.check_circle_outline, "9", "sessions"),
        ],
      ),
    )
        .animate(delay: const Duration(milliseconds: 600))
        .fadeIn()
        .slideY(begin: 0.2);
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  _CircularProgressPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
