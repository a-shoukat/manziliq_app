import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../shared/widgets/stat_card.dart';

class SocietyDashboard extends StatelessWidget {
  const SocietyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Society Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overview',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: const [
                StatCard(title: 'Total Plots', value: '240'),
                StatCard(title: 'Available', value: '128'),
                StatCard(title: 'Pending Bookings', value: '12'),
                StatCard(title: 'Active Dealers', value: '8'),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            _actionTile(
              context,
              Icons.map,
              'Plot Inventory',
              AppRoutes.plotInventory,
            ),
            _actionTile(
              context,
              Icons.upload_file,
              'Upload Plots',
              AppRoutes.plotUpload,
            ),
            _actionTile(
              context,
              Icons.people,
              'Dealer Management',
              AppRoutes.dealerManagement,
            ),
            _actionTile(
              context,
              Icons.approval,
              'Booking Approvals',
              AppRoutes.bookingApprovals,
            ),
            _actionTile(
              context,
              Icons.payment,
              'Payment Config',
              AppRoutes.paymentConfig,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.svgPlotMap),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.map),
        label: const Text('View Map'),
      ),
    );
  }

  Widget _actionTile(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(route),
      ),
    );
  }
}
