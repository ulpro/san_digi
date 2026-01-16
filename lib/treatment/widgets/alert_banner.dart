import 'package:flutter/material.dart';
import '../constants.dart';

class AlertBanner extends StatelessWidget {
  final String message;
  final bool isUrgent;

  const AlertBanner({
    super.key,
    required this.message,
    this.isUrgent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TreatmentConstants.mediumPadding),
      decoration: BoxDecoration(
        color: isUrgent
            ? TreatmentColors.dangerColor.withOpacity(0.1)
            : TreatmentColors.warningColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(TreatmentConstants.cardBorderRadius),
        border: Border.all(
          color: isUrgent
              ? TreatmentColors.dangerColor.withOpacity(0.2)
              : TreatmentColors.warningColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: isUrgent
                ? TreatmentColors.dangerColor
                : TreatmentColors.warningColor,
            size: 24,
          ),
          const SizedBox(width: TreatmentConstants.smallPadding),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isUrgent
                    ? TreatmentColors.dangerColor
                    : TreatmentColors.warningColor,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}