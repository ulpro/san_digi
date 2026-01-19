import 'package:flutter/material.dart';
import '../constants.dart';
import '../../models/treatment_model.dart';
import 'treatment_card.dart';

class TreatmentHistorySection extends StatelessWidget {
  final List<Treatment> treatments;

  const TreatmentHistorySection({super.key, required this.treatments});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Traitements Actifs',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: isDark
                ? TreatmentColors.textPrimaryLight
                : TreatmentColors.textPrimaryDark,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: TreatmentConstants.mediumPadding),
        ...treatments.map((treatment) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: TreatmentConstants.smallPadding,
            ),
            child: TreatmentCard(treatment: treatment),
          );
        }).toList(),
      ],
    );
  }
}
