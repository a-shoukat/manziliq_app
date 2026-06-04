import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class TopNavbar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationsTap;

  const TopNavbar({
    super.key,
    this.title = 'Admin Dashboard',
    this.actions,
    this.onProfileTap,
    this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              if (actions != null) ...actions!,
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: onNotificationsTap,
              ),
              GestureDetector(
                onTap: onProfileTap,
                child: const CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
