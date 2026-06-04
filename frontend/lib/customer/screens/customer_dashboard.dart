import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_routes.dart';
import '../../shared/widgets/animated_entrance.dart';

class CustomerDashboard extends StatelessWidget {
  const CustomerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search plots, societies...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.tune),
                onPressed: () => context.push(AppRoutes.propertySearch),
              ),
            ),
            onSubmitted: (_) => context.push(AppRoutes.propertySearch),
          ),
          const SizedBox(height: 24),
          const Text(
            'Browse',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < _navItems.length; i++)
            AnimatedEntrance(
              delay: Duration(milliseconds: 100 + i * 80),
              child: _navCard(
                context,
                _navItems[i].icon,
                _navItems[i].title,
                _navItems[i].route,
              ),
            ),
        ],
      ),
    );
  }

  static const _navItems = <_NavItem>[
    _NavItem(Icons.search, 'Property Search', AppRoutes.propertySearch),
    _NavItem(Icons.favorite, 'Saved Properties', AppRoutes.savedProperties),
    _NavItem(Icons.compare_arrows, 'Compare Plots', AppRoutes.comparePlots),
    _NavItem(Icons.map, 'Map View', AppRoutes.googleMap),
    _NavItem(Icons.notifications, 'Notifications', AppRoutes.notificationInbox),
  ];

  Widget _navCard(BuildContext context, IconData icon, String title, String route) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(route),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.icon, this.title, this.route);

  final IconData icon;
  final String title;
  final String route;
}
