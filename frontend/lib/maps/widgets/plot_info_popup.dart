import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class PlotInfoPopup extends StatelessWidget {
  final String plotNumber;
  final String block;
  final String status;
  final String? price;
  final VoidCallback? onBook;
  final VoidCallback? onClose;

  const PlotInfoPopup({
    super.key,
    required this.plotNumber,
    required this.block,
    required this.status,
    this.price,
    this.onBook,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Plot $plotNumber',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose ?? () => Navigator.pop(context),
                ),
              ],
            ),
            Text('Block: $block'),
            Text('Status: $status'),
            if (price != null) ...[
              const SizedBox(height: 4),
              Text(
                price!,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            if (status.toLowerCase() == 'available' && onBook != null) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onBook,
                  child: const Text('Book Now'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
