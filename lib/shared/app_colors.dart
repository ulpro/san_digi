import 'package:flutter/material.dart';

// Couleurs globales de l'application - UNIFIÉES
class AppColors {
  // ========== COULEURS PRIMAIRES ==========
  static const Color primaryBlue = Color(0xFF2A7DE1);
  static const Color primaryDark = Color(0xFF1F4788);
  static const Color primaryLight = Color(0xFF5C9EE1);
  static const Color gradientStart = Color(0xFF2A7DE1);
  static const Color gradientEnd = Color(0xFF1F4788);

  // ========== COULEURS DE STATUT ==========
  static const Color successGreen = Color(0xFF34C759);  // Garde cette version
  static const Color alertRed = Color(0xFFFF3B30);      // AJOUTÉ
  static const Color warningOrange = Color(0xFFFF9500); // Garde cette version
  static const Color infoBlue = Color(0xFF17A2B8);
  static const Color healthGreen = Color(0xFF4CD964);   // AJOUTÉ

  // ========== COULEURS NEUTRES ==========
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color lightGray = Color(0xFFF8F9FA);
  static const Color mediumGray = Color(0xFFE5E7EB);
  static const Color darkGray = Color(0xFF6B7280);

  // ========== COULEURS DE TEXTE ==========
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);

  // ========== COULEURS DE FOND ==========
  // Version principale
  static const Color backgroundLight = Color(0xFFF6F8F6);
  static const Color backgroundDark = Color(0xFF111521);
  
  // Version alternative (noms différents)
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1F2937);
  
  // Cartes
  static const Color cardBackgroundLight = Color(0xFFFFFFFF);
  static const Color cardBackgroundDark = Color(0xFF1A2E1A);

  // ========== BORDURES ==========
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF374151);

  // ========== GRADIENTS ==========
  static Gradient primaryGradient = const LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // ========== MÉTHODES UTILITAIRES ==========
  
  // Obtenir la couleur de fond selon le thème
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? backgroundDark
        : backgroundLight;
  }

  // Obtenir la couleur de surface selon le thème
  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? surfaceDark
        : surfaceLight;
  }

  // Obtenir la couleur de texte principale selon le thème
  static Color getTextPrimaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? white
        : textPrimary;
  }

  // Obtenir la couleur de texte secondaire selon le thème
  static Color getTextSecondaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? mediumGray
        : textSecondary;
  }
}