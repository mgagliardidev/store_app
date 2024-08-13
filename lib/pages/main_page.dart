import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/pages/cart_page.dart';
import 'package:store_app/pages/favourites_page.dart';
import 'package:store_app/pages/home_page.dart';
import 'package:store_app/pages/profile_page.dart';
import 'package:store_app/pages/settings_page.dart';
import 'package:store_app/providers/logic_provider.dart';

class MainPage extends ConsumerWidget {
  MainPage({super.key});

  final List<Widget> pages = <Widget>[
    const HomePage(),
    const FavouritesPage(),
    const CartPage(),
    //const ProfilePage(),
    const SettingsPage()
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexBottomNavbar = ref.watch(indexBottomNavigationProvider);

    return Scaffold(
      body: pages[indexBottomNavbar],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavbar,
        onTap: (value) => ref
            .read(indexBottomNavigationProvider.notifier)
            .update((state) => value),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'Favorite',
              activeIcon: Icon(Icons.favorite)),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
              activeIcon: Icon(Icons.shopping_cart)),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.person_outline),
          //     label: 'Profile',
          //     activeIcon: Icon(Icons.person)),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
              activeIcon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
