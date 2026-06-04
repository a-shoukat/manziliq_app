import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class DealerManagementScreen extends StatelessWidget {
  const DealerManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dealers = [
      {'name': 'Ali Khan', 'license': 'DL-1024', 'plots': '24'},
      {'name': 'Sara Ahmed', 'license': 'DL-2048', 'plots': '18'},
      {'name': 'Hassan Raza', 'license': 'DL-3072', 'plots': '31'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Dealer Management')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dealers.length,
        itemBuilder: (context, i) {
          final d = dealers[i];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Text(d['name']![0]),
              ),
              title: Text(d['name']!),
              subtitle: Text('License: ${d['license']} • ${d['plots']} plots'),
              trailing: PopupMenuButton(
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'remove', child: Text('Remove')),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
