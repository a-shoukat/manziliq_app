import 'package:flutter/material.dart';

import '../widgets/lot_badge_widget.dart';

class LotManagementScreen extends StatelessWidget {
  const LotManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lots = <Map<String, String>>[
      {'name': 'Block A Premium', 'plots': '24', 'status': 'active'},
      {'name': 'Block B Standard', 'plots': '18', 'status': 'pending'},
      {'name': 'Block C Corner', 'plots': '8', 'status': 'closed'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Lot Management')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: lots.length,
        itemBuilder: (context, i) {
          final lot = lots[i];
          return Card(
            child: ListTile(
              title: Text(lot['name']!),
              subtitle: Text('${lot['plots']} plots assigned'),
              trailing: LotBadgeWidget(
                label: lot['name']!,
                status: lot['status']!,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
