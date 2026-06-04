import 'package:supabase_flutter/supabase_flutter.dart';

class SocietyService {
  final _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getPlots(String societyId) async {
    final data = await _client
        .from('plots')
        .select()
        .eq('society_id', societyId)
        .order('block');
    return List<Map<String, dynamic>>.from(data);
  }

  Future<List<Map<String, dynamic>>> getDealers(String societyId) async {
    final data = await _client
        .from('society_dealers')
        .select('*, profiles(*)')
        .eq('society_id', societyId);
    return List<Map<String, dynamic>>.from(data);
  }

  Future<List<Map<String, dynamic>>> getPendingBookings(String societyId) async {
    final data = await _client
        .from('bookings')
        .select()
        .eq('society_id', societyId)
        .eq('status', 'pending');
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> updatePaymentConfig(
    String societyId,
    Map<String, dynamic> config,
  ) async {
    await _client.from('societies').update(config).eq('id', societyId);
  }
}
