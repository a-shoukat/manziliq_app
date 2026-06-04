import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class CustomSidebar extends StatelessWidget {
  final List<SidebarItem>? items;
  final int selectedIndex;
  final ValueChanged<int>? onItemSelected;

  const CustomSidebar({
    super.key,
    this.items,
    this.selectedIndex = 0,
    this.onItemSelected,
  });

  static const List<SidebarItem> adminItems = [
    SidebarItem(Icons.dashboard, 'Dashboard'),
    SidebarItem(Icons.people, 'Users'),
    SidebarItem(Icons.home_work, 'Plots'),
    SidebarItem(Icons.business, 'Dealers'),
    SidebarItem(Icons.location_city, 'Societies'),
    SidebarItem(Icons.report, 'Reports'),
  ];

  @override
  Widget build(BuildContext context) {
    final menu = items ?? adminItems;

    return Container(
      width: 250,
      color: AppColors.sidebar,
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Text(
            'MANZILIQ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          ...List.generate(menu.length, (i) {
            final item = menu[i];
            final selected = i == selectedIndex;
            return ListTile(
              selected: selected,
              selectedTileColor: Colors.white.withValues(alpha: 0.1),
              leading: Icon(item.icon, color: Colors.white),
              title: Text(
                item.label,
                style: const TextStyle(color: Colors.white),
              ),
              onTap: onItemSelected != null ? () => onItemSelected!(i) : null,
            );
          }),
        ],
      ),
    );
  }
}

class SidebarItem {
  final IconData icon;
  final String label;

  const SidebarItem(this.icon, this.label);
}
