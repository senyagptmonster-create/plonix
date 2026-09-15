import 'package:flutter/material.dart';

class PlonixDecor {
  static const Color darkCharcoal = Color(0xFF16191D);
  static const Color cardSurface = Color(0xFF22272E);
  static const Color neonCyan = Color(0xFF00E5FF);
  static const Color vividOrange = Color(0xFFFF9100);
  static const Color lightText = Color(0xFFECEFF4);
  static const Color subtleText = Color(0xFF8B949E);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'AppFont',
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkCharcoal,
      colorScheme: const ColorScheme.dark(
        primary: neonCyan,
        secondary: vividOrange,
        surface: cardSurface,
        onSurface: lightText,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkCharcoal,
        foregroundColor: lightText,
        elevation: 0,
      ),
    );
  }
}
