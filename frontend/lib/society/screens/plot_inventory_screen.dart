import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../widgets/block_filter_widget.dart';
import '../widgets/plot_card_widget.dart';

class PlotInventoryScreen extends StatefulWidget {
  const PlotInventoryScreen({super.key});

  @override
  State<PlotInventoryScreen> createState() => _PlotInventoryScreenState();
}

class _PlotInventoryScreenState extends State<PlotInventoryScreen> {
  String? _selectedBlock;
  final _blocks = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final plots = List.generate(
      8,
      (i) => {
        'number': '${i + 1}',
        'block': _blocks[i % _blocks.length],
        'status': [AppStrings.available, AppStrings.reserved, AppStrings.sold][i % 3],
        'size': '5 Marla',
      },
    ).where((p) => _selectedBlock == null || p['block'] == _selectedBlock);

    return Scaffold(
      appBar: AppBar(title: const Text('Plot Inventory')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: BlockFilterWidget(
              blocks: _blocks,
              selectedBlock: _selectedBlock,
              onChanged: (b) => setState(() => _selectedBlock = b),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: plots.length,
              itemBuilder: (context, i) {
                final p = plots.elementAt(i);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: PlotCardWidget(
                    plotNumber: p['number']!,
                    block: p['block']!,
                    status: p['status']!,
                    size: p['size'],
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
