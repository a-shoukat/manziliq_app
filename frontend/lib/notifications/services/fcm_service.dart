import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

/// Named fcm_service for project convention; uses Supabase Realtime (not Firebase).
class FcmService {
  final _client = Supabase.instance.client;
  RealtimeChannel? _channel;
  final _controller = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get notificationStream => _controller.stream;

  Future<List<Map<String, dynamic>>> fetchNotifications(String userId) async {
    final data = await _client
        .from('notifications')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(data);
  }

  void subscribeToNotifications(String userId) {
    _channel?.unsubscribe();
    _channel = _client
        .channel('notifications:$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'notifications',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) {
            if (payload.newRecord.isNotEmpty) {
              _controller.add(Map<String, dynamic>.from(payload.newRecord));
            }
          },
        )
        .subscribe();
  }

  Future<void> markAsRead(String notificationId) async {
    await _client
        .from('notifications')
        .update({'read': true})
        .eq('id', notificationId);
  }

  void dispose() {
    _channel?.unsubscribe();
    _controller.close();
  }
}
