import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  const String url = 'https://qacvdvtoeywofwvgzgie.supabase.co';
  const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFhY3ZkdnRvZXl3b2Z3dmd6Z2llIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc0NDQyOTcsImV4cCI6MjAzMzAyMDI5N30.p1bCdFFPbVYxUOT6Dd-HwgxdFA5Nd5sqlObgbHdatJA';
  await Supabase.initialize(url: url, anonKey: anonKey);
  runApp(const ProviderScope(child: MainApp()));
}

final supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const HomePage(),
    );
  }
}
