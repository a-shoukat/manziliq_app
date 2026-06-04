import 'package:flutter/foundation.dart';

import '../booking/services/booking_service.dart';

class BookingProvider extends ChangeNotifier {
  final BookingService _service = BookingService();

  Map<String, dynamic>? _currentBooking;
  bool _loading = false;

  Map<String, dynamic>? get currentBooking => _currentBooking;
  bool get loading => _loading;

  Future<void> loadBooking(String id) async {
    _loading = true;
    notifyListeners();
    try {
      _currentBooking = await _service.getBooking(id);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<String?> createBooking(Map<String, dynamic> data) async {
    _loading = true;
    notifyListeners();
    try {
      _currentBooking = await _service.createBooking(data);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
