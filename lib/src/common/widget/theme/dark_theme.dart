import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _DarkThemeColor {
  static const primary = Color(0xFFD02626);
  static const onPrimary = Color(0xFFFFFFFF);
  static const secondary = Color(0xFF200B0B);
  static const onSecondary = Color(0xFFFFFFFF);
  static const background = Color(0xFF000000);
  static const onBackground = Color(0xFFFFFFFF);
}

class DarkTheme {
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(),
        colorScheme: const ColorScheme.dark(
          primary: _DarkThemeColor.primary,
          onPrimary: _DarkThemeColor.onPrimary,
          secondary: _DarkThemeColor.secondary,
          onSecondary: _DarkThemeColor.onSecondary,
          background: _DarkThemeColor.background,
          onBackground: _DarkThemeColor.onBackground,
        ),
        snackBarTheme: SnackBarThemeData(
          elevation: 0.0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: _DarkThemeColor.secondary,
          contentTextStyle: GoogleFonts.montserrat(
            color: _DarkThemeColor.onSecondary,
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
}
