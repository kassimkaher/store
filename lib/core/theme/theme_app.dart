import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.tajawal()
        .fontFamily, // Ensure you add this font or use default
    brightness: Brightness.light,

    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF005292)),

    // Mapping Text Styles
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Color(0xFF4A5250)),
    ),
  );
}
