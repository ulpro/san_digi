import 'package:flutter/material.dart';
import 'navigation.dart'; // Importation du système de navigation

// ==============================================
// PROFESSIONAL HEALTHCARE COLOR PALETTE
// ==============================================

// Medical blue - Trust, professionalism
const Color primaryBlue = Color(0xFF2A7DE1);
const Color lightBlue = Color(0xFFE8F2FF);
const Color mediumBlue = Color(0xFF4A90E2);

// Health green - Serenity, wellbeing
const Color healthGreen = Color(0xFF4CD964);
const Color lightGreen = Color(0xFFE8F7ED);

// Professional neutrals
const Color darkText = Color(0xFF2C3E50);
const Color mediumText = Color(0xFF5D6D7E);
const Color lightText = Color(0xFF95A5A6);
const Color cardWhite = Color(0xFFFFFFFF);
const Color backgroundGray = Color(0xFFF8F9FA);

// Alerts and status
const Color warningOrange = Color(0xFFFF9500);
const Color alertRed = Color(0xFFFF3B30);
const Color successGreen = Color(0xFF34C759);

// Dark theme (health adapted)
const Color darkBackground = Color(0xFF121A26);
const Color darkCard = Color(0xFF1C2536);
const Color darkPrimary = Color(0xFF5AA9FF);

// New gradient colors
const Color gradientStart = Color(0xFF2A7DE1);
const Color gradientEnd = Color(0xFF5AA9FF);

// Additional health colors
const Color purpleHealth = Color(0xFF9C27B0);
const Color tealHealth = Color(0xFF009688);

void main() {
  runApp(const SanDigiApp());
}

class SanDigiApp extends StatelessWidget {
  const SanDigiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SanDigi',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryBlue,
        colorScheme: const ColorScheme.light(
          primary: primaryBlue,
          secondary: healthGreen,
          surface: cardWhite,
          onPrimary: Colors.white,
          onSurface: darkText,
        ),
        scaffoldBackgroundColor: backgroundGray,
        appBarTheme: const AppBarTheme(
          backgroundColor: cardWhite,
          elevation: 0,
          centerTitle: true,
          foregroundColor: primaryBlue,
          titleTextStyle: TextStyle(
            color: darkText,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          color: cardWhite,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: darkText,
            letterSpacing: -0.5,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: darkText,
            letterSpacing: -0.3,
          ),
          bodyLarge: TextStyle(fontSize: 16, color: darkText, height: 1.6),
          bodyMedium: TextStyle(fontSize: 14, color: mediumText, height: 1.6),
          bodySmall: TextStyle(fontSize: 12, color: lightText, height: 1.4),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryBlue,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: darkPrimary,
        colorScheme: const ColorScheme.dark(
          primary: darkPrimary,
          secondary: healthGreen,
          surface: darkCard,
          onPrimary: Colors.white,
          onSurface: Colors.white,
        ),
        scaffoldBackgroundColor: darkBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: darkCard,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          color: darkCard,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: darkPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: -0.3,
          ),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.white, height: 1.6),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFFA0AEC0),
            height: 1.6,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: Color(0xFF718096),
            height: 1.4,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: darkPrimary,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home:
          const MainNavigation(), // ← MODIFICATION ICI : Utilisation du système de navigation
    );
  }
}
