import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../services/fcm_service.dart';
import '../widgets/notification_tile.dart';

class NotificationInboxScreen extends StatefulWidget {
  const NotificationInboxScreen({super.key});

  @override
  State<NotificationInboxScreen> createState() => _NotificationInboxScreenState();
}

class _NotificationInboxScreenState extends State<NotificationInboxScreen> {
  final _fcmService = FcmService();
  List<Map<String, dynamic>> _notifications = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final userId = context.read<AuthProvider>().user?.id;
    if (userId == null) {
      setState(() => _loading = false);
      return;
    }

    _fcmService.subscribeToNotifications(userId);
    _fcmService.notificationStream.listen((n) {
      if (mounted) setState(() => _notifications.insert(0, n));
    });

    try {
      _notifications = await _fcmService.fetchNotifications(userId);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _fcmService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Notifications')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_notifications.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Notifications')),
        body: const Center(
          child: Text('No notifications yet'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notifications.length,
        itemBuilder: (context, i) {
          final n = _notifications[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: NotificationTile(
              title: n['title'] as String? ?? 'Notification',
              body: n['body'] as String? ?? '',
              time: n['created_at'] as String? ?? '',
              isRead: n['read'] as bool? ?? false,
              onTap: () {
                final id = n['id'] as String?;
                if (id != null) _fcmService.markAsRead(id);
              },
            ),
          );
        },
      ),
    );
  }
}
