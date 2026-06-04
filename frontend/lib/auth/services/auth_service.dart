import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/user_model.dart';

class AuthService {
  final _client = Supabase.instance.client;

  Future<UserModel?> getCurrentProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final data = await _client.from('profiles').select().eq('id', user.id).maybeSingle();
    if (data == null) return null;
    return UserModel.fromJson(data);
  }

  Future<UserModel> login(String email, String password) async {
    final res = await _client.auth.signInWithPassword(email: email, password: password);
    if (res.user == null) throw Exception('Login failed');

    final profile = await getCurrentProfile();
    if (profile == null) throw Exception('Profile not found');
    return profile;
  }

  Future<UserModel> register({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required UserRole role,
    Map<String, dynamic>? extra,
  }) async {
    final res = await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': fullName,
        'role': role.name,
      },
    );

    if (res.user == null) throw Exception('Registration failed');

    await _client.from('profiles').update({
      'full_name': fullName,
      'phone': phone,
      'role': role.name,
      if (extra != null) ...extra,
    }).eq('id', res.user!.id);

    final profile = await getCurrentProfile();
    if (profile == null) throw Exception('Profile not found');
    return profile;
  }

  Future<void> verifyEmailOtp(String email, String token) async {
    await _client.auth.verifyOTP(type: OtpType.email, email: email, token: token);
    await _client.from('profiles').update({'email_verified': true}).eq('email', email);
  }

  Future<void> verifyPhoneOtp(String phone, String token) async {
    await _client.auth.verifyOTP(type: OtpType.sms, phone: phone, token: token);
    final user = _client.auth.currentUser;
    if (user != null) {
      await _client.from('profiles').update({'phone_verified': true}).eq('id', user.id);
    }
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }
}
