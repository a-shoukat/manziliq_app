import 'package:supabase_flutter/supabase_flutter.dart';

class SearchService {
  final _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> searchPlots({
    String? block,
    String? status,
    double? minPrice,
    double? maxPrice,
    String? size,
  }) async {
    var query = _client.from('plots').select('*, societies(name)');

    if (block != null) query = query.eq('block', block);
    if (status != null) query = query.eq('status', status);
    if (minPrice != null) query = query.gte('price', minPrice);
    if (maxPrice != null) query = query.lte('price', maxPrice);
    if (size != null) query = query.eq('size', size);

    final data = await query.order('plot_number');
    return List<Map<String, dynamic>>.from(data);
  }

  Future<List<Map<String, dynamic>>> getSavedPlots(String userId) async {
    final data = await _client
        .from('saved_plots')
        .select('*, plots(*)')
        .eq('user_id', userId);
    return List<Map<String, dynamic>>.from(data);
  }
}
