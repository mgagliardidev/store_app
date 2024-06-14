import 'package:flutter/material.dart';

const Color primaryColor = Colors.white;
const Color secondaryColor = Color.fromARGB(255, 237, 232, 232);
const Color backgroundColor = Colors.white;

ThemeData defaultTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      background: backgroundColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
    ),
    searchBarTheme: SearchBarThemeData(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => secondaryColor),
        elevation: MaterialStateProperty.all(0)),
    textTheme: const TextTheme().apply(bodyColor: Colors.black),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: Colors.black26),
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
        selectedItemColor: Colors.black87));
