import 'package:flutter/foundation.dart';
import '../auth/services/auth_service.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _user;
  bool _loading = false;

  UserModel? get user => _user;
  bool get loading => _loading;
  bool get isLoggedIn => _user != null;
  bool get isApproved => _user?.isApproved ?? false;

  Future<void> init() async {
    _loading = true;
    notifyListeners();
    _user = await _authService.getCurrentProfile();
    _loading = false;
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    _loading = true;
    notifyListeners();
    try {
      _user = await _authService.login(email, password);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<String?> register({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required UserRole role,
    Map<String, dynamic>? extra,
  }) async {
    _loading = true;
    notifyListeners();
    try {
      _user = await _authService.register(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
        role: role,
        extra: extra,
      );
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }

  Future<void> refreshProfile() async {
    _user = await _authService.getCurrentProfile();
    notifyListeners();
  }
}
