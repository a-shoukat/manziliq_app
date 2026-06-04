import 'package:supabase_flutter/supabase_flutter.dart';

class MapService {
  final _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getPlotsForMap(String societyId) async {
    final data = await _client
        .from('plots')
        .select('id, plot_number, block, status, coordinates')
        .eq('society_id', societyId);
    return List<Map<String, dynamic>>.from(data);
  }

  Future<String?> getSvgMapUrl(String societyId) async {
    final data = await _client
        .from('societies')
        .select('svg_map_url')
        .eq('id', societyId)
        .maybeSingle();
    return data?['svg_map_url'] as String?;
  }
}
