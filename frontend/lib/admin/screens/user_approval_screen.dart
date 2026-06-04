import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/constants/app_colors.dart';
import '../../models/user_model.dart';
import '../../shared/widgets/custom_sidebar.dart';
import '../../shared/widgets/top_navbar.dart';

class UserApprovalScreen extends StatefulWidget {
  const UserApprovalScreen({super.key});

  @override
  State<UserApprovalScreen> createState() => _UserApprovalScreenState();
}

class _UserApprovalScreenState extends State<UserApprovalScreen> {
  final _client = Supabase.instance.client;
  List<Map<String, dynamic>> _pending = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final data = await _client
          .from('profiles')
          .select()
          .eq('approval_status', 'pending');
      _pending = List<Map<String, dynamic>>.from(data);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _approve(String id) async {
    await _client.from('profiles').update({'approval_status': 'approved'}).eq('id', id);
    await _load();
  }

  Future<void> _reject(String id) async {
    await _client.from('profiles').update({'approval_status': 'rejected'}).eq('id', id);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const CustomSidebar(),
          Expanded(
            child: Column(
              children: [
                const TopNavbar(title: 'User Approval'),
                Expanded(
                  child: _loading
                      ? const Center(child: CircularProgressIndicator())
                      : _pending.isEmpty
                          ? const Center(child: Text('No pending users'))
                          : ListView.builder(
                              padding: const EdgeInsets.all(20),
                              itemCount: _pending.length,
                              itemBuilder: (context, i) {
                                final p = _pending[i];
                                final user = UserModel.fromJson(p);
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: ListTile(
                                    title: Text(user.fullName),
                                    subtitle: Text(
                                      '${user.email} • ${user.role.name}',
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.check,
                                              color: AppColors.success),
                                          onPressed: () => _approve(user.id),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.close,
                                              color: AppColors.danger),
                                          onPressed: () => _reject(user.id),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
