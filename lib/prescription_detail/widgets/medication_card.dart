import 'package:flutter/material.dart';
import '../../prescription/constants.dart';
import '../../models/prescription_model.dart';

class MedicationCard extends StatelessWidget {
  final MedicationDetail medication;
  final int index;
  final bool isDark;

  const MedicationCard({
    super.key,
    required this.medication,
    required this.index,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, top: index == 0 ? 0 : 0),
      padding: const EdgeInsets.all(PrescriptionConstants.mediumPadding),
      decoration: BoxDecoration(
        color: isDark ? PrescriptionColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(
          PrescriptionConstants.cardBorderRadius,
        ),
        border: Border.all(
          color: isDark
              ? PrescriptionColors.borderDark.withOpacity(0.3)
              : PrescriptionColors.dividerLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.1 : 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: PrescriptionConstants.medicationIconSize,
                height: PrescriptionConstants.medicationIconSize,
                decoration: BoxDecoration(
                  color: PrescriptionColors.activeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.medication_liquid_rounded,
                  color: PrescriptionColors.activeColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  medication.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? PrescriptionColors.textPrimaryLight
                        : PrescriptionColors.textPrimaryDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildMedicationTag(
                icon: Icons.science_rounded,
                text: medication.dosage,
                isDark: isDark,
              ),
              _buildMedicationTag(
                icon: Icons.access_time_rounded,
                text: medication.frequency,
                isDark: isDark,
              ),
              _buildMedicationTag(
                icon: Icons.calendar_today_rounded,
                text: medication.duration,
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationTag({
    required IconData icon,
    required String text,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDark
            ? PrescriptionColors.borderDark.withOpacity(0.5)
            : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: isDark
                ? PrescriptionColors.textSecondaryLight
                : PrescriptionColors.textSecondaryDark,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF4B5563),
            ),
          ),
        ],
      ),
    );
  }
}
