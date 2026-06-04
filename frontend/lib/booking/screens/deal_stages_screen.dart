import 'package:flutter/material.dart';

import '../widgets/pipeline_stepper_widget.dart';

class DealStagesScreen extends StatelessWidget {
  const DealStagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const stages = [
      'Submitted',
      'Approved',
      'Token Paid',
      'Agreement',
      'Possession',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Deal Progress')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              child: ListTile(
                title: Text('Plot A-15 — Green Valley'),
                subtitle: Text('Booking BK-2026-0042'),
              ),
            ),
            const SizedBox(height: 32),
            const PipelineStepperWidget(stages: stages, currentIndex: 2),
            const SizedBox(height: 32),
            ...List.generate(stages.length, (i) {
              final done = i <= 2;
              return ListTile(
                leading: Icon(
                  done ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: done ? Colors.green : Colors.grey,
                ),
                title: Text(stages[i]),
                subtitle: i == 2 ? const Text('In progress') : null,
              );
            }),
          ],
        ),
      ),
    );
  }
}
