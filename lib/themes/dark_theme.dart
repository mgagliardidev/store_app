import 'package:flutter/material.dart';

const Color primaryColor = Colors.black;
const Color secondaryColor = Color.fromRGBO(77, 74, 74, 1);
const Color backgroundColor = Colors.black;
const Color tertiaryColor = Colors.white;

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: tertiaryColor,
      surface: backgroundColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ThemeData.dark().primaryColor,
      iconTheme: const IconThemeData(color: Colors.black87),
      actionsIconTheme: const IconThemeData(color: Colors.black87),
    ),
    searchBarTheme: SearchBarThemeData(
        backgroundColor:
            WidgetStateColor.resolveWith((states) => secondaryColor),
        elevation: WidgetStateProperty.all(0)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        unselectedItemColor: Colors.white,
        elevation: 2,
        backgroundColor: secondaryColor,
        unselectedIconTheme: IconThemeData(fill: 0),
        selectedIconTheme: IconThemeData(fill: 1),
        selectedLabelStyle: TextStyle(color: Colors.white70),
        unselectedLabelStyle: TextStyle(color: Colors.white70),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: Colors.white60),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white.withOpacity(0.9),
        extendedTextStyle: const TextStyle(
            fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold)));
