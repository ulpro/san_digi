import 'package:flutter/material.dart';
import '../constants.dart';
import '../models.dart';

class TreatmentCard extends StatelessWidget {
  final Treatment treatment;

  const TreatmentCard({
    super.key,
    required this.treatment,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(TreatmentConstants.mediumPadding),
      decoration: BoxDecoration(
        color: isDark
            ? TreatmentColors.cardBgDark
            : TreatmentColors.backgroundColorLight,
        borderRadius:
            BorderRadius.circular(TreatmentConstants.cardBorderRadius),
        border: Border.all(
          color: isDark
              ? TreatmentColors.borderColorDark.withOpacity(0.3)
              : TreatmentColors.borderColorLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                treatment.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? TreatmentColors.textPrimaryLight
                      : TreatmentColors.textPrimaryDark,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: TreatmentConstants.extraSmallPadding,
                  vertical: TreatmentConstants.extraSmallPadding / 2,
                ),
                decoration: BoxDecoration(
                  color: treatment.needsRenewal
                      ? TreatmentColors.dangerColor.withOpacity(0.1)
                      : TreatmentColors.primaryColor.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(TreatmentConstants.extraSmallPadding),
                ),
                child: Text(
                  '${treatment.remainingDays} jours restants',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: treatment.needsRenewal
                        ? TreatmentColors.dangerColor
                        : TreatmentColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TreatmentConstants.extraSmallPadding),
          Text(
            treatment.dosage,
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? TreatmentColors.textSecondaryLight
                  : TreatmentColors.textSecondaryDark,
            ),
          ),
          const SizedBox(height: TreatmentConstants.smallPadding),
          // Barre de progression
          Row(
            children: [
              Expanded(
                child: Container(
                  height: TreatmentConstants.progressBarHeight,
                  decoration: BoxDecoration(
                    color: isDark
                        ? TreatmentColors.progressBgDark
                        : TreatmentColors.progressBgLight,
                    borderRadius: BorderRadius.circular(
                        TreatmentConstants.progressBarHeight / 2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: treatment.progress,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: treatment.progress < 0.2
                              ? [
                                  TreatmentColors.dangerColor,
                                  TreatmentColors.warningLight
                                ]
                              : [
                                  TreatmentColors.gradientStart,
                                  TreatmentColors.gradientEnd
                                ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(
                            TreatmentConstants.progressBarHeight / 2),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: TreatmentConstants.smallPadding),
              Text(
                '${((treatment.progress) * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? TreatmentColors.textSecondaryLight
                      : TreatmentColors.textSecondaryDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}