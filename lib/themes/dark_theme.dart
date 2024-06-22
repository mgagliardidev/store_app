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
      background: backgroundColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: Colors.black87),
      actionsIconTheme: IconThemeData(color: Colors.black87),
    ),
    searchBarTheme: SearchBarThemeData(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => secondaryColor),
        elevation: MaterialStateProperty.all(0)),
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
