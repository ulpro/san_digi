import 'package:flutter/material.dart';

class AppColors {
  // ==============================================
  // PRIMARY PALETTE (Medical Blue)
  // ==============================================
  static const Color primaryBlue = Color(0xFF2A7DE1);
  static const Color primaryDark = Color(0xFF1F4788);
  static const Color primaryLight = Color(0xFF5C9EE1);
  static const Color lightBlue = Color(0xFFE8F2FF);
  static const Color mediumBlue = Color(0xFF4A90E2);

  // ==============================================
  // STATUS COLORS
  // ==============================================
  static const Color healthGreen = Color(0xFF4CD964);
  static const Color successGreen = Color(0xFF34C759);
  static const Color lightGreen = Color(0xFFE8F7ED);
  static const Color alertRed = Color(0xFFFF3B30);
  static const Color warningOrange = Color(0xFFFF9500);
  static const Color infoBlue = Color(0xFF17A2B8);

  // ==============================================
  // NEUTRAL COLORS
  // ==============================================
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color backgroundGray = Color(0xFFF8F9FA); // backgroundLight
  static const Color lightGray = Color(0xFFF8F9FA);
  static const Color mediumGray = Color(0xFFE5E7EB);
  static const Color darkGray = Color(0xFF6B7280);

  // ==============================================
  // TEXT COLORS
  // ==============================================
  static const Color darkText = Color(0xFF2C3E50); // textPrimary
  static const Color mediumText = Color(0xFF5D6D7E); // textSecondary
  static const Color lightText = Color(0xFF95A5A6); // textHint

  // Aliases for compatibility
  static const Color textPrimary = Color(
    0xFF111827,
  ); // Slightly darker than darkText
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);

  // ==============================================
  // DARK MODE PALETTE
  // ==============================================
  static const Color darkBackground = Color(0xFF121A26);
  static const Color darkCard = Color(0xFF1C2536);
  static const Color darkPrimary = Color(0xFF5AA9FF);
  static const Color cardDark = Color(0xFF1F2937);

  // ==============================================
  // GRADIENTS
  // ==============================================
  static const Color gradientStart = Color(0xFF2A7DE1);
  static const Color gradientEnd = Color(0xFF5AA9FF);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // ==============================================
  // ADDITIONAL HEALTH COLORS
  // ==============================================
  static const Color purpleHealth = Color(0xFF9C27B0);
  static const Color tealHealth = Color(0xFF009688);

  // ==============================================
  // BORDERS
  // ==============================================
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF374151);

  // ==============================================
  // UTILITY METHODS
  // ==============================================
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackground
        : backgroundGray;
  }

  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? darkCard : white;
  }

  static Color getTextPrimaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? white : darkText;
  }
}
