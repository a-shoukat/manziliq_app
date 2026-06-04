import 'package:supabase_flutter/supabase_flutter.dart';

class BookingService {
  final _client = Supabase.instance.client;

  Future<Map<String, dynamic>> createBooking(Map<String, dynamic> data) async {
    final result = await _client.from('bookings').insert(data).select().single();
    return Map<String, dynamic>.from(result);
  }

  Future<Map<String, dynamic>?> getBooking(String id) async {
    final data =
        await _client.from('bookings').select().eq('id', id).maybeSingle();
    if (data == null) return null;
    return Map<String, dynamic>.from(data);
  }

  Future<void> scheduleSiteVisit(String bookingId, DateTime date) async {
    await _client.from('bookings').update({
      'site_visit_date': date.toIso8601String(),
      'stage': 'site_visit',
    }).eq('id', bookingId);
  }
}
