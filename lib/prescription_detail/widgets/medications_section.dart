import 'package:flutter/material.dart';
import '../../prescription/constants.dart';
import '../../models/prescription_model.dart';
import 'medication_card.dart';

class MedicationsSection extends StatelessWidget {
  final List<MedicationDetail> medications;
  final bool isDark;

  const MedicationsSection({
    super.key,
    required this.medications,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'Médicaments prescrits',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? PrescriptionColors.textPrimaryLight
                      : PrescriptionColors.textPrimaryDark,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${medications.length} médicament(s)',
              style: TextStyle(
                fontSize: 12,
                color: isDark
                    ? PrescriptionColors.textSecondaryLight
                    : PrescriptionColors.textSecondaryDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...medications.asMap().entries.map((entry) {
          final index = entry.key;
          final medication = entry.value;
          return MedicationCard(
            medication: medication,
            index: index,
            isDark: isDark,
          );
        }),
      ],
    );
  }
}
