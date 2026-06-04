import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_routes.dart';
import '../../shared/widgets/stat_card.dart';
import '../widgets/deal_stage_card.dart';

class DealerDashboard extends StatelessWidget {
  const DealerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dealer Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                StatCard(title: 'Active Lots', value: '12'),
                StatCard(title: 'Open Deals', value: '7'),
                StatCard(title: 'Commission (PKR)', value: '450K'),
              ],
            ),
            const SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: const [
                DealStageCard(
                  stageName: 'Inquiry',
                  count: 3,
                  icon: Icons.help_outline,
                ),
                DealStageCard(
                  stageName: 'Negotiation',
                  count: 2,
                  icon: Icons.handshake_outlined,
                ),
                DealStageCard(
                  stageName: 'Booking',
                  count: 1,
                  icon: Icons.bookmark_added_outlined,
                ),
                DealStageCard(
                  stageName: 'Closed',
                  count: 5,
                  icon: Icons.check_circle_outline,
                ),
              ],
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.inventory_2),
              title: const Text('Lot Management'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(AppRoutes.lotManagement),
            ),
            ListTile(
              leading: const Icon(Icons.timeline),
              title: const Text('Deal Pipeline'),
              onTap: () => context.push(AppRoutes.dealPipeline),
            ),
            ListTile(
              leading: const Icon(Icons.payments),
              title: const Text('Commission'),
              onTap: () => context.push(AppRoutes.commission),
            ),
          ],
        ),
      ),
    );
  }
}
