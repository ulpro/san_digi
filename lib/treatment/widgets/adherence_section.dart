import 'package:flutter/material.dart';
import '../constants.dart';
import '../models.dart';

class AdherenceSection extends StatelessWidget {
  final Adherence adherence;

  const AdherenceSection({
    super.key,
    required this.adherence,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(TreatmentConstants.defaultPadding),
      decoration: BoxDecoration(
        color: isDark
            ? TreatmentColors.cardBgDark
            : TreatmentColors.backgroundColorLight,
        borderRadius:
            BorderRadius.circular(TreatmentConstants.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mon Observance',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: isDark
                  ? TreatmentColors.textPrimaryLight
                  : TreatmentColors.textPrimaryDark,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: TreatmentConstants.defaultPadding),

          // Taux d'observance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                adherence.period,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? TreatmentColors.textSecondaryLight
                      : TreatmentColors.textSecondaryDark,
                ),
              ),
              Text(
                adherence.ratePercentage,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: TreatmentColors.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: TreatmentConstants.smallPadding),

          // Barre de progression
          Container(
            height: TreatmentConstants.progressBarHeight * 2,
            decoration: BoxDecoration(
              color: isDark
                  ? TreatmentColors.progressBgDark
                  : TreatmentColors.progressBgLight,
              borderRadius:
                  BorderRadius.circular(TreatmentConstants.progressBarHeight),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: adherence.rate,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      TreatmentColors.gradientStart,
                      TreatmentColors.gradientEnd
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius:
                      BorderRadius.circular(TreatmentConstants.progressBarHeight),
                ),
              ),
            ),
          ),
          const SizedBox(height: TreatmentConstants.extraSmallPadding),

          // Message d'encouragement
          Text(
            adherence.encouragementMessage,
            style: TextStyle(
              fontSize: 12,
              color: isDark
                  ? TreatmentColors.textSecondaryLight
                  : TreatmentColors.textSecondaryDark,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}