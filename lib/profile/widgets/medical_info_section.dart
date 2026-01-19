import 'package:flutter/material.dart';
import '../constants.dart';
import '../../models/health_model.dart';
import 'medical_info_row.dart';

class MedicalInfoSection extends StatelessWidget {
  final bool isDark;
  final double screenWidth;
  final MedicalInfo medicalInfo;

  const MedicalInfoSection({
    super.key,
    required this.isDark,
    required this.screenWidth,
    required this.medicalInfo,
  });

  @override
  Widget build(BuildContext context) {
    final padding = screenWidth < 360
        ? const EdgeInsets.all(16)
        : const EdgeInsets.all(20);
    final iconSize = screenWidth < 360 ? 20.0 : 22.0;

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: isDark ? ProfileColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(ProfileConstants.cardBorderRadius),
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
                  Icons.medical_information_rounded,
                  color: Colors.white,
                  size: iconSize,
                ),
              ),
              SizedBox(width: screenWidth < 360 ? 10 : 12),
              Flexible(
                child: Text(
                  'Informations Médicales',
                  style: TextStyle(
                    fontSize: screenWidth < 360 ? 16 : 18,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? ProfileColors.textLight
                        : ProfileColors.textMainColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.04),

          // Allergies
          MedicalInfoRow(
            icon: Icons.all_inclusive_rounded,
            title: 'Allergies',
            value: medicalInfo.allergies,
            isDark: isDark,
            color: const Color(0xFFFF6B6B),
            screenWidth: screenWidth,
          ),
          SizedBox(height: screenWidth * 0.03),

          // Groupe sanguin
          MedicalInfoRow(
            icon: Icons.bloodtype_rounded,
            title: 'Groupe Sanguin',
            value: medicalInfo.bloodType,
            isDark: isDark,
            color: ProfileColors.alertColor,
            screenWidth: screenWidth,
          ),
          SizedBox(height: screenWidth * 0.03),

          // Traitements importants
          MedicalInfoRow(
            icon: Icons.medication_rounded,
            title: 'Traitements Importants',
            value: medicalInfo.importantTreatments.join(', '),
            isDark: isDark,
            isMultiLine: true,
            treatments: medicalInfo.importantTreatments,
            color: ProfileColors.successColor,
            screenWidth: screenWidth,
          ),
        ],
      ),
    );
  }
}
