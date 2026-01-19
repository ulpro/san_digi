import 'package:flutter/material.dart';
import '../constants.dart';
import '../../models/health_model.dart';
import 'institution_card.dart';

class HealthcareInstitutionsSection extends StatelessWidget {
  final bool isDark;
  final double screenWidth;
  final List<HealthcareInstitution> institutions;
  final Function(HealthcareInstitution) onViewDetails;

  const HealthcareInstitutionsSection({
    super.key,
    required this.isDark,
    required this.screenWidth,
    required this.institutions,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // En-tête
        Row(
          children: [
            Container(
              width: screenWidth < 360 ? 36 : 40,
              height: screenWidth < 360 ? 36 : 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    ProfileColors.primaryColor,
                    ProfileColors.primaryGradientEnd,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.local_hospital_rounded,
                color: Colors.white,
                size: screenWidth < 360 ? 20 : 22,
              ),
            ),
            SizedBox(width: screenWidth < 360 ? 10 : 12),
            Flexible(
              child: Text(
                'Établissements de Suivi',
                style: TextStyle(
                  fontSize: screenWidth < 360 ? 16 : 18,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? ProfileColors.textLight
                      : ProfileColors.textMainColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.03),

        // Liste des établissements
        Container(
          decoration: BoxDecoration(
            color: isDark ? ProfileColors.cardDark : Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.1 : 0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: institutions
                .asMap()
                .entries
                .map(
                  (entry) => InstitutionCard(
                    institution: entry.value,
                    isDark: isDark,
                    screenWidth: screenWidth,
                    onViewDetails: () => onViewDetails(entry.value),
                    isLast: entry.key == institutions.length - 1,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
