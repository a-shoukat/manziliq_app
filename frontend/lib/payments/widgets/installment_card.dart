import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class InstallmentCard extends StatelessWidget {
  final int installmentNumber;
  final String amount;
  final String dueDate;
  final bool isPaid;

  const InstallmentCard({
    super.key,
    required this.installmentNumber,
    required this.amount,
    required this.dueDate,
    this.isPaid = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isPaid
              ? AppColors.success.withValues(alpha: 0.2)
              : AppColors.warning.withValues(alpha: 0.2),
          child: Text(
            '#$installmentNumber',
            style: TextStyle(
              color: isPaid ? AppColors.success : AppColors.warning,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(amount),
        subtitle: Text('Due: $dueDate'),
        trailing: Chip(
          label: Text(isPaid ? 'Paid' : 'Due'),
          backgroundColor: isPaid
              ? AppColors.success.withValues(alpha: 0.15)
              : AppColors.warning.withValues(alpha: 0.15),
        ),
      ),
    );
  }
}
