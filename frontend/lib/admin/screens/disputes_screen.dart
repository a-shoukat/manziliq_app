import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../shared/widgets/custom_sidebar.dart';
import '../../shared/widgets/top_navbar.dart';

class DisputesScreen extends StatelessWidget {
  const DisputesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final disputes = [
      {'plot': 'A-12', 'reason': 'Double booking claim', 'status': 'Open'},
      {'plot': 'B-05', 'reason': 'Payment mismatch', 'status': 'Under review'},
      {'plot': 'C-21', 'reason': 'Boundary dispute', 'status': 'Resolved'},
    ];

    return Scaffold(
      body: Row(
        children: [
          const CustomSidebar(),
          Expanded(
            child: Column(
              children: [
                const TopNavbar(title: 'Disputes'),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: disputes.length,
                    itemBuilder: (context, i) {
                      final d = disputes[i];
                      final color = d['status'] == 'Resolved'
                          ? AppColors.success
                          : AppColors.warning;
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.gavel, color: AppColors.plotDisputed),
                          title: Text('Plot ${d['plot']}'),
                          subtitle: Text(d['reason']!),
                          trailing: Chip(
                            label: Text(d['status']!),
                            backgroundColor: color.withValues(alpha: 0.2),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
