import 'package:flutter/material.dart';
import '../constants.dart';
import '../models.dart';
import 'dose_card.dart';

class UpcomingDosesSection extends StatelessWidget {
  final List<Dose> doses;
  final Function(String) onMarkAsTaken;

  const UpcomingDosesSection({
    super.key,
    required this.doses,
    required this.onMarkAsTaken,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prochaines Prises',
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
        ...doses.map((dose) => DoseCard(
              dose: dose,
              onMarkAsTaken: onMarkAsTaken,
            )),
      ],
    );
  }
}