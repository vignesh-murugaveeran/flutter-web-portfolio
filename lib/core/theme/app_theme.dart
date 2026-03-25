import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primarySeed = Color(0xFF6C63FF);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: primarySeed,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: primarySeed,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFF0F172A), // Premium dark blue-gray
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
    );
  }
}
