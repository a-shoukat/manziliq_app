import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../widgets/plot_info_popup.dart';
import '../widgets/plot_status_legend.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  String? _selectedPlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map View')),
      body: Stack(
        children: [
          Container(
            color: Colors.grey.shade300,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 80, color: Colors.grey.shade600),
                  const SizedBox(height: 16),
                  const Text(
                    'Google Maps integration placeholder',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 8,
                    children: ['A-1', 'A-2', 'B-5', 'C-12'].map((plot) {
                      return ActionChip(
                        label: Text(plot),
                        onPressed: () => setState(() => _selectedPlot = plot),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: PlotStatusLegend(),
          ),
          if (_selectedPlot != null)
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: PlotInfoPopup(
                plotNumber: _selectedPlot!.split('-').last,
                block: _selectedPlot!.split('-').first,
                status: 'available',
                price: 'PKR 2,800,000',
                onClose: () => setState(() => _selectedPlot = null),
                onBook: () {},
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {},
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
