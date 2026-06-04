import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../widgets/plot_info_popup.dart';
import '../widgets/plot_status_legend.dart';

class SvgPlotMapScreen extends StatefulWidget {
  const SvgPlotMapScreen({super.key});

  @override
  State<SvgPlotMapScreen> createState() => _SvgPlotMapScreenState();
}

class _SvgPlotMapScreenState extends State<SvgPlotMapScreen> {
  String? _selectedPlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SVG Plot Map')),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(12),
              color: AppColors.background,
            ),
            child: CustomPaint(
              painter: _GridPlotPainter(
                onPlotTap: (plot) => setState(() => _selectedPlot = plot),
              ),
              child: const Center(
                child: Text(
                  'Interactive SVG map — tap colored cells',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          const Positioned(
            top: 8,
            left: 24,
            right: 24,
            child: PlotStatusLegend(),
          ),
          if (_selectedPlot != null)
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: PlotInfoPopup(
                plotNumber: _selectedPlot!.split('-')[1],
                block: _selectedPlot!.split('-')[0],
                status: 'available',
                price: 'PKR 2,500,000',
                onClose: () => setState(() => _selectedPlot = null),
                onBook: () {},
              ),
            ),
        ],
      ),
    );
  }
}

class _GridPlotPainter extends CustomPainter {
  final void Function(String plot) onPlotTap;

  _GridPlotPainter({required this.onPlotTap});

  @override
  void paint(Canvas canvas, Size size) {
    const cols = 6;
    const rows = 4;
    final cellW = size.width / cols;
    final cellH = size.height / rows;
    final colors = [
      AppColors.plotAvailable,
      AppColors.plotReserved,
      AppColors.plotSold,
      AppColors.plotDisputed,
    ];

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final paint = Paint()
          ..color = colors[(r + c) % colors.length].withValues(alpha: 0.6)
          ..style = PaintingStyle.fill;
        canvas.drawRect(
          Rect.fromLTWH(c * cellW + 2, r * cellH + 2, cellW - 4, cellH - 4),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  bool hitTest(Offset position) {
    onPlotTap('A-1');
    return true;
  }
}
