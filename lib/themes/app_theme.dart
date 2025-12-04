import 'package:flutter/material.dart';
import 'palette.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: Palette.backgroundLight,
    cardColor: Palette.cardLight,
    primaryColor: Palette.primaryGreen,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Palette.textLight),
      bodyMedium: TextStyle(color: Palette.textLight),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: Palette.backgroundDark,
    cardColor: Palette.cardDark,
    primaryColor: Palette.primaryGreen,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Palette.textDark),
      bodyMedium: TextStyle(color: Palette.textDark),
    ),
  );
}
