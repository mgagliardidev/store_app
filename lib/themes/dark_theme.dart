import 'package:flutter/material.dart';

const Color primaryColor = Colors.black;
const Color secondaryColor = Color.fromRGBO(77, 74, 74, 1);
const Color backgroundColor = Colors.black;

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        background: backgroundColor),
    appBarTheme: const AppBarTheme(backgroundColor: backgroundColor),
    searchBarTheme: SearchBarThemeData(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => secondaryColor),
        elevation: MaterialStateProperty.all(0)),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: Colors.white60));
