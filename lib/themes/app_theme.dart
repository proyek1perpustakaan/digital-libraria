import 'package:flutter/material.dart';
import 'package:digital_libraria/themes/palette.dart';
import 'text_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Palette.secondaryGreen,
      secondary: Palette.white,
    ),
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      headlineLarge: TextStyles.headlineLarge,
      headlineMedium: TextStyles.headlineMedium,
      bodyLarge: TextStyles.bodyLarge,
      bodyMedium: TextStyles.bodyMedium,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFFDDF0D5),
      textTheme: ButtonTextTheme.primary,
    ),
    scaffoldBackgroundColor: Colors.white,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Palette.secondaryGreen,
      secondary: Colors.black,
    ),
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      headlineLarge: TextStyles.headlineLarge.copyWith(color: Colors.white),
      headlineMedium: TextStyles.headlineMedium.copyWith(color: Colors.white),
      bodyLarge: TextStyles.bodyLarge.copyWith(color: Colors.white70),
      bodyMedium: TextStyles.bodyMedium.copyWith(color: Colors.white60),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.teal,
      textTheme: ButtonTextTheme.primary,
    ),
    scaffoldBackgroundColor: Colors.black,
  );
}
