import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class CommissionScreen extends StatelessWidget {
  const CommissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final records = <Map<String, dynamic>>[
      {'deal': 'Plot A-5', 'amount': 'PKR 45,000', 'date': '2026-05-15', 'paid': true},
      {'deal': 'Plot B-2', 'amount': 'PKR 62,000', 'date': '2026-05-28', 'paid': false},
      {'deal': 'Plot C-8', 'amount': 'PKR 38,000', 'date': '2026-06-01', 'paid': false},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Commission')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Earned', style: TextStyle(color: Colors.white70)),
                SizedBox(height: 4),
                Text(
                  'PKR 145,000',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, i) {
                final r = records[i];
                return ListTile(
                  title: Text(r['deal'] as String),
                  subtitle: Text(r['date'] as String),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        r['amount'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        r['paid'] == true ? 'Paid' : 'Pending',
                        style: TextStyle(
                          color: r['paid'] == true
                              ? AppColors.success
                              : AppColors.warning,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
