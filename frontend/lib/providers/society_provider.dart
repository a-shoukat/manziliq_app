import 'package:flutter/foundation.dart';

import '../society/services/society_service.dart';

class SocietyProvider extends ChangeNotifier {
  final SocietyService _service = SocietyService();

  List<Map<String, dynamic>> _plots = [];
  bool _loading = false;

  List<Map<String, dynamic>> get plots => _plots;
  bool get loading => _loading;

  Future<void> loadPlots(String societyId) async {
    _loading = true;
    notifyListeners();
    try {
      _plots = await _service.getPlots(societyId);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void clear() {
    _plots = [];
    notifyListeners();
  }
}
