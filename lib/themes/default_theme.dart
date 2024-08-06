import 'package:flutter/material.dart';

const Color primaryColor = Colors.white;
const Color secondaryColor = Color.fromARGB(255, 237, 232, 232);
const Color backgroundColor = Colors.white;
const Color tertiaryColor = Colors.black;

ThemeData defaultTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Roboto',
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    tertiary: tertiaryColor,
    surface: backgroundColor,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: backgroundColor,
    actionsIconTheme: IconThemeData(color: Colors.black87),
  ),
  searchBarTheme: SearchBarThemeData(
      backgroundColor:
          WidgetStateColor.resolveWith((states) => secondaryColor),
      elevation: WidgetStateProperty.all(0)),
  textTheme: const TextTheme().apply(bodyColor: Colors.black),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black26),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: Colors.black87,
      elevation: 2,
      backgroundColor: secondaryColor,
      unselectedIconTheme: IconThemeData(fill: 0),
      selectedIconTheme: IconThemeData(fill: 1),
      selectedLabelStyle: TextStyle(color: Colors.black87),
      unselectedLabelStyle: TextStyle(color: Colors.black87),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.black87),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black.withOpacity(0.8),
      extendedTextStyle: const TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
);
