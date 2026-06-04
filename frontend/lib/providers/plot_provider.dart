import 'package:flutter/foundation.dart';

import '../maps/services/map_service.dart';

class PlotProvider extends ChangeNotifier {
  final MapService _mapService = MapService();

  List<Map<String, dynamic>> _plots = [];
  Map<String, dynamic>? _selectedPlot;
  bool _loading = false;

  List<Map<String, dynamic>> get plots => _plots;
  Map<String, dynamic>? get selectedPlot => _selectedPlot;
  bool get loading => _loading;

  Future<void> loadPlotsForSociety(String societyId) async {
    _loading = true;
    notifyListeners();
    try {
      _plots = await _mapService.getPlotsForMap(societyId);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void selectPlot(Map<String, dynamic>? plot) {
    _selectedPlot = plot;
    notifyListeners();
  }
}
