// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:frontend/app.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/providers/society_provider.dart';
import 'package:frontend/providers/plot_provider.dart';
import 'package:frontend/providers/booking_provider.dart';
import 'package:frontend/providers/payment_provider.dart';

class MockAuthProvider extends AuthProvider {
  @override
  Future<void> init() async {
    // Prevent real backend/Supabase call during test bootstrapping
  }
}

class MockGotrueAsyncStorage extends GotrueAsyncStorage {
  final Map<String, String> _storage = {};

  @override
  Future<String?> getItem({required String key}) async => _storage[key];

  @override
  Future<void> removeItem({required String key}) async => _storage.remove(key);

  @override
  Future<void> setItem({required String key, required String value}) async =>
      _storage[key] = value;
}

void main() {
  setUpAll(() async {
    // Initialize Supabase client locally to prevent assertion errors
    // when services/providers are instantiated.
    await Supabase.initialize(
      url: 'https://ctctmtgwfibuxyzemkee.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN0Y3RtdGd3ZmlidXh5emVta2VlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgxNzE5NDYsImV4cCI6MjA5Mzc0Nzk0Nn0.pIrln83gIXcC2HWRdS5nE9_ihTQ0vZXNMskJYDfke-U',
      authOptions: FlutterAuthClientOptions(
        localStorage: const EmptyLocalStorage(),
        pkceAsyncStorage: MockGotrueAsyncStorage(),
      ),
    );
  });

  testWidgets('App splash screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(create: (_) => MockAuthProvider()),
          ChangeNotifierProvider(create: (_) => SocietyProvider()),
          ChangeNotifierProvider(create: (_) => PlotProvider()),
          ChangeNotifierProvider(create: (_) => BookingProvider()),
          ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ],
        child: const ManzilApp(),
      ),
    );

    // Verify that the splash screen shows the application name and circular progress indicator.
    expect(find.text('ManzilIQ'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
