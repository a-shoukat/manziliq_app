import 'package:flutter/material.dart';

class PaymentMethodSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const PaymentMethodSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const methods = [
    ('bank', 'Bank Transfer', Icons.account_balance),
    ('easypaisa', 'Easypaisa', Icons.phone_android),
    ('jazzcash', 'JazzCash', Icons.mobile_friendly),
    ('card', 'Debit/Credit Card', Icons.credit_card),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: methods.map((m) {
        return RadioListTile<String>(
          title: Text(m.$2),
          secondary: Icon(m.$3),
          value: m.$1,
          groupValue: selected,
          onChanged: (v) => onChanged(v!),
        );
      }).toList(),
    );
  }
}
