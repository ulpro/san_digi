import 'package:flutter/material.dart';
import '../constants.dart';

class EmptyState extends StatelessWidget {
  final int selectedFilterIndex;

  const EmptyState({
    super.key,
    required this.selectedFilterIndex,
  });

  String get _emptyMessage {
    switch (selectedFilterIndex) {
      case 0:
        return 'Vous n\'avez pas de rendez-vous à venir.';
      case 1:
        return 'Vous n\'avez pas de rendez-vous passés.';
      case 2:
        return 'Vous n\'avez pas de rendez-vous annulés.';
      default:
        return 'Aucun rendez-vous trouvé.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(
            Icons.calendar_today_rounded,
            size: 64,
            color: isDark 
                ? RendezVousColors.textSecondaryDark 
                : RendezVousColors.textSecondaryLight,
          ),
          const SizedBox(height: RendezVousConstants.mediumPadding),
          Text(
            'Aucun rendez-vous',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isDark 
                  ? RendezVousColors.textPrimaryLight 
                  : RendezVousColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: RendezVousConstants.extraSmallPadding),
          Text(
            _emptyMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: isDark 
                  ? RendezVousColors.textSecondaryLight 
                  : RendezVousColors.textSecondaryDark,
            ),
          ),
        ],
      ),
    );
  }
}