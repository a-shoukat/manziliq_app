import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'providers/auth_provider.dart';
import 'providers/booking_provider.dart';
import 'providers/payment_provider.dart';
import 'providers/plot_provider.dart';
import 'providers/society_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ctctmtgwfibuxyzemkee.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN0Y3RtdGd3ZmlidXh5emVta2VlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgxNzE5NDYsImV4cCI6MjA5Mzc0Nzk0Nn0.pIrln83gIXcC2HWRdS5nE9_ihTQ0vZXNMskJYDfke-U',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SocietyProvider()),
        ChangeNotifierProvider(create: (_) => PlotProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
      ],
      child: const ManzilApp(),
    ),
  );
}
