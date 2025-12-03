import 'package:flutter/material.dart';
import 'package:digital_libraria/themes/palette.dart';
import 'text_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',

    colorScheme: const ColorScheme.light(
      primary: Palette.secondaryGreen,
      secondary: Palette.white,
      background: Colors.white,
      surface: Colors.white,
      onBackground: Colors.black,
      onPrimary: Colors.white,
    ),

    scaffoldBackgroundColor: Colors.white,

    textTheme: TextTheme(
      headlineLarge: TextStyles.headlineLarge.copyWith(color: Colors.black),
      headlineMedium: TextStyles.headlineMedium.copyWith(color: Colors.black),
      bodyLarge: TextStyles.bodyLarge.copyWith(color: Colors.black87),
      bodyMedium: TextStyles.bodyMedium.copyWith(color: Colors.black87),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Poppins',

    colorScheme: const ColorScheme.dark(
      primary: Palette.secondaryGreen,
      secondary: Color(0xFF1C1C1E), // Card / container gelap
      background: Color(0xFF000000), // Background utama
      surface: Color(0xFF1C1C1E),
      onBackground: Colors.white,
      onPrimary: Colors.black,
    ),

    scaffoldBackgroundColor: const Color(0xFF000000),

    textTheme: TextTheme(
      headlineLarge: TextStyles.headlineLarge.copyWith(color: Colors.white),
      headlineMedium: TextStyles.headlineMedium.copyWith(color: Colors.white),
      bodyLarge: TextStyles.bodyLarge.copyWith(color: Colors.white),
      bodyMedium: TextStyles.bodyMedium.copyWith(color: Colors.white70),
    ),
  );
}
