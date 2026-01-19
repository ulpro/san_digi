import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PrescriptionColors {
  static const Color primaryColor = AppColors.primaryBlue;
  static const Color secondaryColor = AppColors.successGreen;
  static const Color activeColor = AppColors.healthGreen;
  static const Color pendingColor = AppColors.warningOrange;
  static const Color expiringColor = AppColors.alertRed;
  static const Color completedColor = AppColors.mediumText; // Was 8E8E93
  static const Color successColor = AppColors.successGreen; // Was 10B981
  static const Color warningColor = AppColors.warningOrange; // Was FFB300
  static const Color infoColor = AppColors.primaryBlue;

  static const Color textPrimaryDark = AppColors.darkText;
  static const Color textPrimaryLight = AppColors.white;
  static const Color textSecondaryDark = AppColors.mediumText;
  static const Color textSecondaryLight = AppColors.lightText;

  static const Color bgDark = AppColors.darkBackground;
  static const Color cardDark = AppColors.darkCard;
  static const Color bgLight = AppColors.backgroundGray;

  static const Color borderDark = AppColors.borderDark;
  static const Color borderLight = AppColors.borderLight;
  static const Color dividerDark = AppColors.borderDark;
  static const Color dividerLight = AppColors.borderLight;

  static const Color qrBgDark =
      AppColors.textPrimary; // Was 111827 (almost black)
  static const Color qrBgLight = AppColors.backgroundGray;
}

class PrescriptionConstants {
  static const double cardBorderRadius = 16.0;
  static const double smallCardBorderRadius = 12.0;
  static const double buttonBorderRadius = 12.0;
  static const double defaultPadding = 20.0;
  static const double mediumPadding = 16.0;
  static const double smallPadding = 12.0;
  static const double extraSmallPadding = 8.0;
  static const double headerCardPadding = 20.0;
  static const double qrCodeSize = 180.0;
  static const double medicationIconSize = 40.0;
}
