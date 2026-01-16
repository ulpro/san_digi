// lib/user/shared/styles.dart
import 'package:flutter/material.dart';
import '../../shared/app_colors.dart';

class UserStyles {
  // Styles spécifiques au module user
  static const TextStyle pageTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );
  
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  
  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    height: 1.5,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );
  
  // Boutons
  static ButtonStyle primaryButton(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}