import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/pages/login_page.dart';
import 'package:store_app/providers/logic_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// themes
import 'themes/default_theme.dart';
import 'themes/dark_theme.dart';

Future<void> main() async {
  const String url = 'https://qacvdvtoeywofwvgzgie.supabase.co';
  const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFhY3ZkdnRvZXl3b2Z3dmd6Z2llIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc0NDQyOTcsImV4cCI6MjAzMzAyMDI5N30.p1bCdFFPbVYxUOT6Dd-HwgxdFA5Nd5sqlObgbHdatJA';
  await Supabase.initialize(url: url, anonKey: anonKey);
  runApp(const ProviderScope(child: MainApp()));
}

final supabase = Supabase.instance.client;

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData selectedTheme =
        ref.watch(useDarkThemeProvider) ? darkTheme : defaultTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme,
      home: const LoginPage(),
    );
  }
}
