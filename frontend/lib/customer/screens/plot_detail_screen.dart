import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_strings.dart';

class PlotDetailScreen extends StatelessWidget {
  const PlotDetailScreen({super.key, required this.plotId});

  final String plotId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plot $plotId')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              color: AppColors.primary.withValues(alpha: 0.1),
              child: const Icon(Icons.landscape, size: 80, color: AppColors.primary),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Green Valley Society',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Plot A-15 • 10 Marla',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Chip(label: Text(AppStrings.available)),
                  const SizedBox(height: 16),
                  const Text(
                    'PKR 3,500,000',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Details', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const ListTile(
                    leading: Icon(Icons.square_foot),
                    title: Text('Size'),
                    subtitle: Text('10 Marla (2250 sq ft)'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Block'),
                    subtitle: Text('Block A, Corner plot'),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.push(AppRoutes.comparePlots),
                          child: const Text('Compare'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => context.push(AppRoutes.bookingForm),
                          child: const Text('Book Now'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
