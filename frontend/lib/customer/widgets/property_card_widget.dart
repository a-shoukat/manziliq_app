import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
class PropertyCardWidget extends StatelessWidget {
  final String plotNumber;
  final String societyName;
  final String block;
  final String price;
  final String status;
  final VoidCallback? onTap;
  final VoidCallback? onSave;

  const PropertyCardWidget({
    super.key,
    required this.plotNumber,
    required this.societyName,
    required this.block,
    required this.price,
    required this.status,
    this.onTap,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              color: AppColors.primary.withValues(alpha: 0.1),
              child: const Center(
                child: Icon(Icons.landscape, size: 48, color: AppColors.primary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Plot $plotNumber — Block $block',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: onSave,
                      ),
                    ],
                  ),
                  Text(societyName, style: TextStyle(color: Colors.grey.shade600)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Chip(
                        label: Text(status),
                        labelStyle: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
