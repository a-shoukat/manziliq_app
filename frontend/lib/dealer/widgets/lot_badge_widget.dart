import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class LotBadgeWidget extends StatelessWidget {
  final String label;
  final String status;

  const LotBadgeWidget({
    super.key,
    required this.label,
    required this.status,
  });

  Color get _color => switch (status.toLowerCase()) {
        'active' => AppColors.success,
        'pending' => AppColors.warning,
        'closed' => AppColors.danger,
        _ => AppColors.primary,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color),
      ),
      child: Text(
        '$label • $status',
        style: TextStyle(color: _color, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
