import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class DocumentTileWidget extends StatelessWidget {
  final String name;
  final String category;
  final String date;
  final VoidCallback? onTap;

  const DocumentTileWidget({
    super.key,
    required this.name,
    required this.category,
    required this.date,
    this.onTap,
  });

  IconData get _icon => switch (category.toLowerCase()) {
        'cnic' => Icons.badge,
        'noc' => Icons.description,
        'agreement' => Icons.gavel,
        'receipt' => Icons.receipt,
        _ => Icons.insert_drive_file,
      };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: Icon(_icon, color: AppColors.primary),
        ),
        title: Text(name),
        subtitle: Text('$category • $date'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
