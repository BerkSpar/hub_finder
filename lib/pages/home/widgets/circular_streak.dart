import 'package:flutter/material.dart';

class CircularStreak extends StatelessWidget {
  final bool isActive;
  final DateTime date;

  const CircularStreak({
    super.key,
    required this.date,
    this.isActive = false,
  });

  String parseWeekday() {
    switch (date.weekday) {
      case 1:
        return 'M';
      case 2:
        return 'T';
      case 3:
        return 'W';
      case 4:
        return 'T';
      case 5:
        return 'F';
      case 6:
        return 'S';
      case 7:
        return 'S';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            parseWeekday(),
            style: TextStyle(
              color: isActive ? Colors.green : Colors.green.shade100,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          CircularProgressIndicator(
            value: isActive ? 1 : 0,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.green,
            ),
            strokeWidth: 2,
            backgroundColor: Colors.green.shade100,
          ),
        ],
      ),
    );
  }
}
