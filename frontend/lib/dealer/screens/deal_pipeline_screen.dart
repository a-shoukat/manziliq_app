import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class DealPipelineScreen extends StatelessWidget {
  const DealPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stages = ['Inquiry', 'Site Visit', 'Negotiation', 'Booking', 'Closed'];
    final deals = {
      'Inquiry': ['Ahmed — Plot A-5'],
      'Site Visit': ['Sara — Plot B-2'],
      'Negotiation': ['Hassan — Plot C-8', 'Ali — Plot A-12'],
      'Booking': ['Fatima — Plot D-1'],
      'Closed': ['Omar — Plot B-15'],
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Deal Pipeline')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: stages.length,
        itemBuilder: (context, i) {
          final stage = stages[i];
          final items = deals[stage] ?? [];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              title: Text(stage, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${items.length} deals'),
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                child: Text('${items.length}'),
              ),
              children: items
                  .map(
                    (d) => ListTile(
                      dense: true,
                      title: Text(d),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
