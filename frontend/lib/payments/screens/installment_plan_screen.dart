import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_routes.dart';
import '../widgets/installment_card.dart';

class InstallmentPlanScreen extends StatelessWidget {
  const InstallmentPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Installment Plan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total: PKR 3,500,000', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Down payment: PKR 700,000 (20%)'),
                  Text('24 monthly installments'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const InstallmentCard(
            installmentNumber: 1,
            amount: 'PKR 116,667',
            dueDate: '2026-07-01',
            isPaid: true,
          ),
          const InstallmentCard(
            installmentNumber: 2,
            amount: 'PKR 116,667',
            dueDate: '2026-08-01',
          ),
          const InstallmentCard(
            installmentNumber: 3,
            amount: 'PKR 116,667',
            dueDate: '2026-09-01',
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.push(AppRoutes.payment),
            child: const Text('Pay Next Installment'),
          ),
        ],
      ),
    );
  }
}
