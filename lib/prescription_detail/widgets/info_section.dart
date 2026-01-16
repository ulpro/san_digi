import 'package:flutter/material.dart';
import '../../prescription/constants.dart';

class InfoSection extends StatelessWidget {
  final int remainingRefills;
  final int medicationCount;
  final bool isDark;

  const InfoSection({
    super.key,
    required this.remainingRefills,
    required this.medicationCount,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PrescriptionConstants.mediumPadding),
      decoration: BoxDecoration(
        color: isDark 
            ? PrescriptionColors.cardDark 
            : Colors.white,
        borderRadius: BorderRadius.circular(PrescriptionConstants.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informations de l\'ordonnance',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isDark 
                  ? PrescriptionColors.textPrimaryLight 
                  : PrescriptionColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem(
                icon: Icons.repeat_rounded,
                label: 'Renouvellements',
                value: '$remainingRefills restant(s)',
                isDark: isDark,
              ),
              _buildInfoItem(
                icon: Icons.medication_rounded,
                label: 'Médicaments',
                value: '$medicationCount',
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: PrescriptionColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: PrescriptionColors.primaryColor,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark 
                ? PrescriptionColors.textPrimaryLight 
                : PrescriptionColors.textPrimaryDark,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDark 
                ? PrescriptionColors.textSecondaryLight 
                : PrescriptionColors.textSecondaryDark,
          ),
        ),
      ],
    );
  }
}