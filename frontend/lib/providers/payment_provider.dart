import 'package:flutter/foundation.dart';

import '../payments/services/payment_service.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentService _service = PaymentService();

  List<Map<String, dynamic>> _history = [];
  List<Map<String, dynamic>> _installments = [];
  bool _loading = false;

  List<Map<String, dynamic>> get history => _history;
  List<Map<String, dynamic>> get installments => _installments;
  bool get loading => _loading;

  Future<void> loadHistory(String userId) async {
    _loading = true;
    notifyListeners();
    try {
      _history = await _service.getPaymentHistory(userId);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> loadInstallments(String bookingId) async {
    _loading = true;
    notifyListeners();
    try {
      _installments = await _service.getInstallmentPlan(bookingId);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
