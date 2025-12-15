import 'package:flutter/material.dart';
import 'package:hub_finder/shared/models/focus_type.dart';
import 'dart:math' as math;

class CircularTimerWidget extends StatelessWidget {
  final double progress;
  final String formattedTime;
  final bool isRunning;
  final FocusType type;

  const CircularTimerWidget({
    super.key,
    required this.progress,
    required this.formattedTime,
    required this.isRunning,
    required this.type,
  });

  Color _getColorForType() {
    switch (type) {
      case FocusType.work:
        return const Color(0xFFE74C3C);
      case FocusType.shortBreak:
        return const Color(0xFF2ECC71);
      case FocusType.longBreak:
        return const Color(0xFF3498DB);
    }
  }

  String _getLabelForType() {
    switch (type) {
      case FocusType.work:
        return 'FOCUS';
      case FocusType.shortBreak:
        return 'SHORT BREAK';
      case FocusType.longBreak:
        return 'LONG BREAK';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColorForType();
    final size = MediaQuery.of(context).size.width * 0.65;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _CircularProgressPainter(
              progress: progress,
              color: color,
              backgroundColor: Colors.grey.shade200,
              strokeWidth: 12,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _getLabelForType(),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                formattedTime,
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
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
