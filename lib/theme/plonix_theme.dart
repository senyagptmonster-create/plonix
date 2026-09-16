import 'package:flutter/material.dart';

class PlonixTheme {
  static const bg = Color(0xFF0D0A14);
  static const surface = Color(0xFF171223);
  static const edge = Color(0xFF251D38);
  static const accent = Color(0xFFD946EF); // Neon Magenta
  static const accentLight = Color(0xFFF0ABFC);
  static const ink = Color(0xFFFDF4FF);
  static const success = Color(0xFF10B981);
  static const muted = Color(0xFF948A9E);

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg,
      fontFamily: 'AppFont',
      primaryColor: accent,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        foregroundColor: ink,
      ),
    );
  }
}
