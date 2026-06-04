import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class BlockFilterWidget extends StatelessWidget {
  final List<String> blocks;
  final String? selectedBlock;
  final ValueChanged<String?> onChanged;

  const BlockFilterWidget({
    super.key,
    required this.blocks,
    required this.selectedBlock,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterChip(
            label: const Text('All Blocks'),
            selected: selectedBlock == null,
            onSelected: (_) => onChanged(null),
            selectedColor: AppColors.primary.withValues(alpha: 0.2),
          ),
          const SizedBox(width: 8),
          ...blocks.map(
            (block) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text('Block $block'),
                selected: selectedBlock == block,
                onSelected: (_) => onChanged(block),
                selectedColor: AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
