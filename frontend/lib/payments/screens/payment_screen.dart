import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_routes.dart';
import '../widgets/payment_method_selector.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _method = 'bank';
  final _amountController = TextEditingController(text: '350000');

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Make Payment')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Card(
            child: ListTile(
              title: Text('Booking BK-2026-0042'),
              subtitle: Text('Plot A-15 — Token payment'),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _amountController,
            decoration: const InputDecoration(
              labelText: 'Amount (PKR)',
              prefixText: 'PKR ',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.w600)),
          PaymentMethodSelector(
            selected: _method,
            onChanged: (m) => setState(() => _method = m),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.push(AppRoutes.receipt),
            child: const Text('Pay Now'),
          ),
        ],
      ),
    );
  }
}
