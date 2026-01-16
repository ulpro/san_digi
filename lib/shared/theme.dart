import 'package:flutter/material.dart';
import 'app_colors.dart';

// Thème global de l'application
class AppTheme {
  // Thème clair
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundLight,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardBackgroundLight,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryBlue,
      secondary: AppColors.primaryLight,
      surface: AppColors.backgroundLight,
      error: AppColors.dangerRed,
    ),
  );

  // Thème sombre
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      foregroundColor: AppColors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardBackgroundDark,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryBlue,
      secondary: AppColors.primaryLight,
      surface: AppColors.backgroundDark,
      error: AppColors.dangerRed,
    ),
  );
}
