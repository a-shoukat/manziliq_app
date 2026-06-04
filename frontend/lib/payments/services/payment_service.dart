import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentService {
  final _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getPaymentHistory(String userId) async {
    final data = await _client
        .from('payments')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(data);
  }

  Future<List<Map<String, dynamic>>> getInstallmentPlan(String bookingId) async {
    final data = await _client
        .from('installments')
        .select()
        .eq('booking_id', bookingId)
        .order('due_date');
    return List<Map<String, dynamic>>.from(data);
  }

  Future<Map<String, dynamic>> recordPayment(Map<String, dynamic> data) async {
    final result = await _client.from('payments').insert(data).select().single();
    return Map<String, dynamic>.from(result);
  }
}
