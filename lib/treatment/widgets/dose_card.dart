import 'package:flutter/material.dart';
import '../constants.dart';
import '../../models/treatment_model.dart';

class DoseCard extends StatefulWidget {
  final Dose dose;
  final Function(String) onMarkAsTaken;

  const DoseCard({super.key, required this.dose, required this.onMarkAsTaken});

  @override
  State<DoseCard> createState() => _DoseCardState();
}

class _DoseCardState extends State<DoseCard> {
  void _handleTap() {
    if (widget.dose.isTaken) {
      _showAlreadyTakenDialog();
    } else {
      widget.onMarkAsTaken(widget.dose.id);
    }
  }

  void _showAlreadyTakenDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Déjà pris',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          content: const Text(
            'Ce médicament a déjà été marqué comme pris pour aujourd\'hui.',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: TreatmentConstants.smallPadding),
      decoration: BoxDecoration(
        color: isDark
            ? TreatmentColors.cardBgDark
            : TreatmentColors.backgroundColorLight,
        borderRadius: BorderRadius.circular(
          TreatmentConstants.cardBorderRadius,
        ),
        border: Border.all(
          color: widget.dose.isPending
              ? TreatmentColors.warningColor.withOpacity(0.3)
              : (isDark
                    ? TreatmentColors.borderColorDark.withOpacity(0.3)
                    : TreatmentColors.borderColorLight),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(TreatmentConstants.mediumPadding),
        child: Row(
          children: [
            // Icône du médicament
            Container(
              width: TreatmentConstants.doseCardHeight,
              height: TreatmentConstants.doseCardHeight,
              decoration: BoxDecoration(
                color: TreatmentColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  TreatmentConstants.smallCardBorderRadius,
                ),
              ),
              child: Icon(
                widget.dose.icon,
                color: TreatmentColors.primaryColor,
                size: TreatmentConstants.doseIconSize,
              ),
            ),
            const SizedBox(width: TreatmentConstants.mediumPadding),

            // Informations du médicament
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.dose.time,
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.dose.isPending
                          ? TreatmentColors.warningColor
                          : (isDark
                                ? TreatmentColors.textSecondaryLight
                                : TreatmentColors.textSecondaryDark),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.dose.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? TreatmentColors.textPrimaryLight
                          : TreatmentColors.textPrimaryDark,
                    ),
                  ),
                  Text(
                    widget.dose.dosage,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? TreatmentColors.textSecondaryLight
                          : TreatmentColors.textSecondaryDark,
                    ),
                  ),
                  const SizedBox(height: TreatmentConstants.smallPadding),
                  // Bouton d'action
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _handleTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.dose.isTaken
                            ? TreatmentColors.successColor
                            : TreatmentColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            TreatmentConstants.buttonBorderRadius,
                          ),
                        ),
                        elevation: 0,
                      ),
                      icon: Icon(
                        widget.dose.isTaken
                            ? Icons.check_circle_rounded
                            : Icons.alarm_rounded,
                        size: 20,
                      ),
                      label: Text(
                        widget.dose.isTaken
                            ? 'Déjà pris'
                            : 'Prendre maintenant',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
