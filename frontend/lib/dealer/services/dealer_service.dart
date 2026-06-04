import 'package:supabase_flutter/supabase_flutter.dart';

class DealerService {
  final _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getLots(String dealerId) async {
    final data = await _client
        .from('lots')
        .select('*, plots(*)')
        .eq('dealer_id', dealerId);
    return List<Map<String, dynamic>>.from(data);
  }

  Future<List<Map<String, dynamic>>> getDeals(String dealerId) async {
    final data = await _client
        .from('bookings')
        .select()
        .eq('dealer_id', dealerId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(data);
  }

  Future<double> getTotalCommission(String dealerId) async {
    final data = await _client
        .from('commissions')
        .select('amount')
        .eq('dealer_id', dealerId);
    double total = 0;
    for (final row in data) {
      total += (row['amount'] as num?)?.toDouble() ?? 0;
    }
    return total;
  }
}
