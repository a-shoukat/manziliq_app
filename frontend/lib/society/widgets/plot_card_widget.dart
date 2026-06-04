import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
class PlotCardWidget extends StatelessWidget {
  final String plotNumber;
  final String block;
  final String status;
  final String? size;
  final VoidCallback? onTap;

  const PlotCardWidget({
    super.key,
    required this.plotNumber,
    required this.block,
    required this.status,
    this.size,
    this.onTap,
  });

  Color get _statusColor => switch (status.toLowerCase()) {
        'available' => AppColors.plotAvailable,
        'reserved' => AppColors.plotReserved,
        'sold' => AppColors.plotSold,
        'disputed' => AppColors.plotDisputed,
        _ => AppColors.primary,
      };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 48,
                decoration: BoxDecoration(
                  color: _statusColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Plot $plotNumber',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text('Block $block${size != null ? ' • $size' : ''}'),
                  ],
                ),
              ),
              Chip(
                label: Text(status),
                backgroundColor: _statusColor.withValues(alpha: 0.15),
                labelStyle: TextStyle(color: _statusColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
