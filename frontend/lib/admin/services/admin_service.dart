import 'package:supabase_flutter/supabase_flutter.dart';

class AdminService {
  final supabase = Supabase.instance.client;

  Future<int> getUsersCount() async {
    final data = await supabase.from('profiles').select('id');
    return (data as List).length;
  }

  Future<int> getPlotsCount() async {
    final data = await supabase.from('plots').select('id');
    return (data as List).length;
  }

  Future<int> getDealersCount() async {
    final data = await supabase.from('profiles').select('id').eq('role', 'dealer');
    return (data as List).length;
  }

  Future<int> getSocietiesCount() async {
    final data =
        await supabase.from('profiles').select('id').eq('role', 'society');
    return (data as List).length;
  }
}
