import 'package:flutter/material.dart';

import '../widgets/compare_card_widget.dart';

class ComparePlotsScreen extends StatefulWidget {
  const ComparePlotsScreen({super.key});

  @override
  State<ComparePlotsScreen> createState() => _ComparePlotsScreenState();
}

class _ComparePlotsScreenState extends State<ComparePlotsScreen> {
  final _plots = [
    {
      'number': 'A-5',
      'society': 'Green Valley',
      'price': 'PKR 2,500,000',
      'size': '5 Marla',
    },
    {
      'number': 'B-12',
      'society': 'Sunrise Housing',
      'price': 'PKR 3,200,000',
      'size': '10 Marla',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compare Plots')),
      body: _plots.isEmpty
          ? const Center(child: Text('Add plots to compare from search'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ..._plots.asMap().entries.map((e) {
                  final p = e.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: CompareCardWidget(
                      plotNumber: p['number']!,
                      societyName: p['society']!,
                      price: p['price']!,
                      size: p['size']!,
                      onRemove: () => setState(() => _plots.removeAt(e.key)),
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Table(
                      columnWidths: {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                      },
                      children: [
                        TableRow(children: [
                          Text('', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Plot 1', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Plot 2', style: TextStyle(fontWeight: FontWeight.bold)),
                        ]),
                        TableRow(children: [
                          Text('Price'),
                          Text('2.5M'),
                          Text('3.2M'),
                        ]),
                        TableRow(children: [
                          Text('Size'),
                          Text('5 Marla'),
                          Text('10 Marla'),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
