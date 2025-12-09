import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define consistent color scheme for all platforms
  static final ColorScheme _colorScheme = ColorScheme.fromSeed(
    seedColor: Color(0xFF005292),
  );

  static final TextTheme _textTheme = TextTheme(
    displayLarge: GoogleFonts.balooBhaijaan2(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF4A5250),
    ),
    displayMedium: GoogleFonts.balooBhaijaan2(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF4A5250),
    ),
    displaySmall: GoogleFonts.balooBhaijaan2(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF4A5250),
    ),
    headlineLarge: GoogleFonts.balooBhaijaan2(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF4A5250),
    ),
    headlineMedium: GoogleFonts.balooBhaijaan2(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF4A5250),
    ),
    headlineSmall: GoogleFonts.balooBhaijaan2(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF4A5250),
    ),
    titleLarge: GoogleFonts.balooBhaijaan2(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF4A5250),
    ),
    titleMedium: GoogleFonts.balooBhaijaan2(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF4A5250),
    ),
    titleSmall: GoogleFonts.balooBhaijaan2(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF4A5250),
    ),
    bodyLarge: GoogleFonts.balooBhaijaan2(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF4A5250),
    ),
    bodyMedium: GoogleFonts.balooBhaijaan2(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF4A5250),
    ),
    bodySmall: GoogleFonts.balooBhaijaan2(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF4A5250),
    ),
    labelLarge: GoogleFonts.balooBhaijaan2(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF4A5250),
    ),
    labelMedium: GoogleFonts.balooBhaijaan2(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF4A5250),
    ),
    labelSmall: GoogleFonts.balooBhaijaan2(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF4A5250),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.balooBhaijaan2().fontFamily,
    brightness: Brightness.light,
    colorScheme: _colorScheme,
    textTheme: _textTheme,

    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: const IconThemeData(color: Color(0xFF4A5250)),
      titleTextStyle: GoogleFonts.balooBhaijaan2(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF4A5250),
      ),
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFFFAFBFA),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF005292),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: GoogleFonts.balooBhaijaan2(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFFAFBFA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE5E8E6)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE5E8E6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF005292), width: 2),
      ),
      contentPadding: const EdgeInsets.all(16),
    ),
  );
}
