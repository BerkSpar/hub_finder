import 'package:flutter/material.dart';

class FocusStatsWidget extends StatelessWidget {
  final int totalMinutes;
  final int sessionCount;

  const FocusStatsWidget({
    super.key,
    required this.totalMinutes,
    required this.sessionCount,
  });

  String _formatTotalTime() {
    if (totalMinutes < 60) {
      return '${totalMinutes}m';
    }
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    return minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            icon: Icons.timer,
            value: _formatTotalTime(),
            label: 'Total Focus',
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey.shade300,
          ),
          _StatItem(
            icon: Icons.check_circle,
            value: '$sessionCount',
            label: 'Sessions',
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
