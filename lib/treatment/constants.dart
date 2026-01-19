import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class TreatmentColors {
  static const Color primaryColor = AppColors.primaryDark; // Was 005A9C
  static const Color successColor = AppColors.successGreen;
  static const Color warningColor = AppColors.warningOrange;
  static const Color dangerColor = AppColors.alertRed;
  static const Color backgroundColorLight = AppColors.white;
  static const Color backgroundColorDark = AppColors.darkBackground;
  static const Color textPrimaryDark = AppColors.textPrimary;
  static const Color textPrimaryLight = AppColors.white;
  static const Color textSecondaryDark = AppColors.mediumText;
  static const Color textSecondaryLight = AppColors.lightText;
  static const Color borderColorDark = AppColors.borderDark;
  static const Color borderColorLight = AppColors.borderLight;
  static const Color cardBgDark = AppColors.darkCard;
  static const Color progressBgDark = AppColors.borderDark;
  static const Color progressBgLight = AppColors.borderLight;
  static const Color gradientStart = AppColors.primaryDark; // Was 005A9C
  static const Color gradientEnd = AppColors.primaryBlue; // Was 2A7DE1
  static const Color warningLight = AppColors
      .warningOrange; // Was FF6B6B (reddish orange) -> uniformized to warningOrange
}

class TreatmentConstants {
  static const double cardBorderRadius = 16.0;
  static const double smallCardBorderRadius = 12.0;
  static const double buttonBorderRadius = 12.0;
  static const double progressBarHeight = 6.0;
  static const double defaultPadding = 20.0;
  static const double mediumPadding = 16.0;
  static const double smallPadding = 12.0;
  static const double extraSmallPadding = 8.0;
  static const double doseCardHeight = 64.0;
  static const double doseIconSize = 32.0;
  static const double largePadding = 24.0;
}
