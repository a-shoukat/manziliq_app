import 'package:flutter/material.dart';

class PaymentConfigScreen extends StatefulWidget {
  const PaymentConfigScreen({super.key});

  @override
  State<PaymentConfigScreen> createState() => _PaymentConfigScreenState();
}

class _PaymentConfigScreenState extends State<PaymentConfigScreen> {
  final _downPaymentController = TextEditingController(text: '20');
  final _installmentMonthsController = TextEditingController(text: '24');
  bool _allowBankTransfer = true;
  bool _allowEasypaisa = true;
  bool _allowJazzCash = false;

  @override
  void dispose() {
    _downPaymentController.dispose();
    _installmentMonthsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Configuration')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextFormField(
            controller: _downPaymentController,
            decoration: const InputDecoration(
              labelText: 'Down Payment (%)',
              suffixText: '%',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _installmentMonthsController,
            decoration: const InputDecoration(
              labelText: 'Max Installment Months',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          const Text(
            'Accepted Payment Methods',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SwitchListTile(
            title: const Text('Bank Transfer'),
            value: _allowBankTransfer,
            onChanged: (v) => setState(() => _allowBankTransfer = v),
          ),
          SwitchListTile(
            title: const Text('Easypaisa'),
            value: _allowEasypaisa,
            onChanged: (v) => setState(() => _allowEasypaisa = v),
          ),
          SwitchListTile(
            title: const Text('JazzCash'),
            value: _allowJazzCash,
            onChanged: (v) => setState(() => _allowJazzCash = v),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment config saved (stub)')),
              );
            },
            child: const Text('Save Configuration'),
          ),
        ],
      ),
    );
  }
}
