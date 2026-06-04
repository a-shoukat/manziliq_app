import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../services/auth_service.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  final _authService = AuthService();
  bool _loading = false;
  String? _email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final extra = GoRouterState.of(context).extra;
    if (extra is Map && extra['email'] != null) {
      _email = extra['email'] as String;
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  Future<void> _verify() async {
    if (_otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter the 6-digit code')),
      );
      return;
    }
    final email = _email ?? context.read<AuthProvider>().user?.email;
    if (email == null) return;

    setState(() => _loading = true);
    try {
      await _authService.verifyEmailOtp(email, _otp);
      await context.read<AuthProvider>().refreshProfile();
      if (!mounted) return;

      final auth = context.read<AuthProvider>();
      if (!auth.isApproved) {
        context.go(AppRoutes.pendingApproval);
      } else {
        context.go(_homeForRole(auth.user!.role));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: AppColors.danger),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _homeForRole(UserRole role) => switch (role) {
        UserRole.admin => AppRoutes.adminDashboard,
        UserRole.society => AppRoutes.societyDashboard,
        UserRole.dealer => AppRoutes.dealerDashboard,
        UserRole.customer => AppRoutes.customerDashboard,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter the 6-digit verification code sent to your email or SMS.',
              style: TextStyle(fontSize: 16),
            ),
            if (_email != null) ...[
              const SizedBox(height: 8),
              Text(
                _email!,
                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
              ),
            ],
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (i) {
                return SizedBox(
                  width: 48,
                  child: TextField(
                    controller: _controllers[i],
                    focusNode: _focusNodes[i],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(counterText: ''),
                    onChanged: (v) {
                      if (v.isNotEmpty && i < 5) {
                        _focusNodes[i + 1].requestFocus();
                      }
                      if (v.isEmpty && i > 0) {
                        _focusNodes[i - 1].requestFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _loading ? null : _verify,
              child: _loading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Verify'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Resend code'),
            ),
          ],
        ),
      ),
    );
  }
}
