import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class BookingApprovalsScreen extends StatelessWidget {
  const BookingApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings = [
      {
        'customer': 'Ahmed Ali',
        'plot': 'A-15',
        'amount': 'PKR 2,500,000',
        'date': '2026-06-01',
      },
      {
        'customer': 'Fatima Noor',
        'plot': 'B-08',
        'amount': 'PKR 3,200,000',
        'date': '2026-06-02',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Booking Approvals')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bookings.length,
        itemBuilder: (context, i) {
          final b = bookings[i];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Plot ${b['plot']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Customer: ${b['customer']}'),
                  Text('Amount: ${b['amount']}'),
                  Text('Date: ${b['date']}'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text('Reject'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.success,
                          ),
                          child: const Text('Approve'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
