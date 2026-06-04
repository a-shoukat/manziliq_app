import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class DealStageCard extends StatelessWidget {
  final String stageName;
  final int count;
  final IconData icon;
  final Color? color;

  const DealStageCard({
    super.key,
    required this.stageName,
    required this.count,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: c, size: 28),
            const SizedBox(height: 12),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: c,
              ),
            ),
            Text(stageName, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
