import 'package:flutter/material.dart';

class SearchFilterWidget extends StatelessWidget {
  final String? selectedBlock;
  final String? selectedSize;
  final ValueChanged<String?> onBlockChanged;
  final ValueChanged<String?> onSizeChanged;
  final VoidCallback onApply;

  const SearchFilterWidget({
    super.key,
    this.selectedBlock,
    this.selectedSize,
    required this.onBlockChanged,
    required this.onSizeChanged,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Filters', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            DropdownButtonFormField<String?>(
              value: selectedBlock,
              decoration: const InputDecoration(labelText: 'Block'),
              items: const [
                DropdownMenuItem(value: null, child: Text('Any')),
                DropdownMenuItem(value: 'A', child: Text('Block A')),
                DropdownMenuItem(value: 'B', child: Text('Block B')),
                DropdownMenuItem(value: 'C', child: Text('Block C')),
              ],
              onChanged: onBlockChanged,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String?>(
              value: selectedSize,
              decoration: const InputDecoration(labelText: 'Size'),
              items: const [
                DropdownMenuItem(value: null, child: Text('Any')),
                DropdownMenuItem(value: '5 Marla', child: Text('5 Marla')),
                DropdownMenuItem(value: '10 Marla', child: Text('10 Marla')),
                DropdownMenuItem(value: '1 Kanal', child: Text('1 Kanal')),
              ],
              onChanged: onSizeChanged,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onApply, child: const Text('Apply Filters')),
          ],
        ),
      ),
    );
  }
}
