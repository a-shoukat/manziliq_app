import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  final _client = Supabase.instance.client;

  Stream<List<Map<String, dynamic>>> watchInbox(String userId) {
    return _client
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .map((rows) => List<Map<String, dynamic>>.from(rows));
  }

  Future<void> markRead(String notificationId) async {
    await _client.from('notifications').update({'is_read': true}).eq('id', notificationId);
  }

  Future<int> unreadCount(String userId) async {
    final res = await _client
        .from('notifications')
        .select('id')
        .eq('user_id', userId)
        .eq('is_read', false);
    return (res as List).length;
  }
}
