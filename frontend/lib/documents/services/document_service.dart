import 'package:supabase_flutter/supabase_flutter.dart';

class DocumentService {
  final _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getDocuments(String userId) async {
    final data = await _client
        .from('documents')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(data);
  }

  Future<String> uploadDocument({
    required String userId,
    required String fileName,
    required String category,
    required String storagePath,
  }) async {
    final url =
        _client.storage.from('documents').getPublicUrl(storagePath);
    await _client.from('documents').insert({
      'user_id': userId,
      'name': fileName,
      'url': url,
      'category': category,
    });
    return url;
  }
}
