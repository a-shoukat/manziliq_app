import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String body;
  final String time;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationTile({
    super.key,
    required this.title,
    required this.body,
    required this.time,
    this.isRead = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isRead ? null : AppColors.primary.withValues(alpha: 0.05),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isRead
              ? Colors.grey.shade200
              : AppColors.primary.withValues(alpha: 0.15),
          child: Icon(
            Icons.notifications,
            color: isRead ? Colors.grey : AppColors.primary,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(body, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(time, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
