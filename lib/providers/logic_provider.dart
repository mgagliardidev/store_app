import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexBottomNavigationProvider = StateProvider<int>((ref) => 0);

final useDarkThemeProvider = StateProvider<bool>((ref) => false);
