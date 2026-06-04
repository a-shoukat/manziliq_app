import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class PlotStatusLegend extends StatelessWidget {
  const PlotStatusLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (AppStrings.available, AppColors.plotAvailable),
      (AppStrings.reserved, AppColors.plotReserved),
      (AppStrings.sold, AppColors.plotSold),
      (AppStrings.disputed, AppColors.plotDisputed),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 16,
          runSpacing: 8,
          children: items
              .map(
                (e) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: e.$2,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(e.$1, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
