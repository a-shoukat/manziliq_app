import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_routes.dart';

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
          _navCard(context, Icons.search, 'Property Search', AppRoutes.propertySearch),
          _navCard(context, Icons.favorite, 'Saved Properties', AppRoutes.savedProperties),
          _navCard(context, Icons.compare_arrows, 'Compare Plots', AppRoutes.comparePlots),
          _navCard(context, Icons.map, 'Map View', AppRoutes.googleMap),
          _navCard(context, Icons.notifications, 'Notifications', AppRoutes.notificationInbox),
        ],
      ),
    );
  }

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
