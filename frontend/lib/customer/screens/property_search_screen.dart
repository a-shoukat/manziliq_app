import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_strings.dart';
import '../widgets/property_card_widget.dart';
import '../widgets/search_filter_widget.dart';

class PropertySearchScreen extends StatefulWidget {
  const PropertySearchScreen({super.key});

  @override
  State<PropertySearchScreen> createState() => _PropertySearchScreenState();
}

class _PropertySearchScreenState extends State<PropertySearchScreen> {
  String? _block;
  String? _size;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Property Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search by plot, block, society...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SearchFilterWidget(
              selectedBlock: _block,
              selectedSize: _size,
              onBlockChanged: (v) => setState(() => _block = v),
              onSizeChanged: (v) => setState(() => _size = v),
              onApply: () => setState(() {}),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 6,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PropertyCardWidget(
                    plotNumber: '${i + 1}',
                    societyName: 'Green Valley Society',
                    block: ['A', 'B', 'C'][i % 3],
                    price: 'PKR ${(2 + i) * 500},000',
                    status: AppStrings.available,
                    onTap: () => context.push('/customer/plot/plot-$i'),
                    onSave: () {},
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
