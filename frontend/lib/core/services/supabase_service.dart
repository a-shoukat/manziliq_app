import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseClient get client => Supabase.instance.client;

  User? get currentUser => client.auth.currentUser;
  Session? get session => client.auth.currentSession;

  Stream<AuthState> get authChanges => client.auth.onAuthStateChange;
}
