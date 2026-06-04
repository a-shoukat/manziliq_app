import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class CompareCardWidget extends StatelessWidget {
  final String plotNumber;
  final String societyName;
  final String price;
  final String size;
  final VoidCallback? onRemove;

  const CompareCardWidget({
    super.key,
    required this.plotNumber,
    required this.societyName,
    required this.price,
    required this.size,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Plot $plotNumber',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(societyName),
                  Text(size, style: TextStyle(color: Colors.grey.shade600)),
                  Text(
                    price,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
