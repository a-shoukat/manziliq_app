import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final payments = [
      {'ref': 'PAY-001', 'amount': 'PKR 700,000', 'date': '2026-06-01', 'type': 'Down payment'},
      {'ref': 'PAY-002', 'amount': 'PKR 116,667', 'date': '2026-07-01', 'type': 'Installment #1'},
      {'ref': 'PAY-003', 'amount': 'PKR 50,000', 'date': '2026-06-15', 'type': 'Token'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Payment History')),
      body: ListView.builder(
        itemCount: payments.length,
        itemBuilder: (context, i) {
          final p = payments[i];
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.success,
              child: Icon(Icons.check, color: Colors.white, size: 20),
            ),
            title: Text(p['amount']!),
            subtitle: Text('${p['type']} • ${p['date']}'),
            trailing: TextButton(
              onPressed: () => context.push(AppRoutes.receipt),
              child: const Text('Receipt'),
            ),
          );
        },
      ),
    );
  }
}
