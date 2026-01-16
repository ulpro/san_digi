import 'package:flutter/material.dart';
import '../constants.dart';
import '../models.dart';

class InstitutionCard extends StatelessWidget {
  final HealthcareInstitution institution;
  final bool isDark;
  final double screenWidth;
  final VoidCallback onViewDetails;
  final bool isLast;

  const InstitutionCard({
    super.key,
    required this.institution,
    required this.isDark,
    required this.screenWidth,
    required this.onViewDetails,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = screenWidth < 360 ? 48.0 : 56.0;
    final arrowButtonSize = screenWidth < 360 ? 40.0 : 48.0;
    final padding = screenWidth < 360 
        ? const EdgeInsets.all(12)
        : const EdgeInsets.all(16);

    return Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: isDark
                      ? ProfileColors.borderDark
                      : ProfileColors.borderLight,
                ),
              ),
      ),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            // Icône
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: ProfileColors.primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(ProfileConstants.smallCardBorderRadius),
                border: Border.all(
                  color: ProfileColors.primaryColor.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Icon(
                  institution.icon,
                  color: ProfileColors.primaryColor,
                  size: iconSize * 0.45,
                ),
              ),
            ),
            SizedBox(width: screenWidth < 360 ? 10 : 14),

            // Informations
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    institution.name,
                    style: TextStyle(
                      fontSize: screenWidth < 360 ? 15 : 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? ProfileColors.textLight : ProfileColors.textMainColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Row(
                    children: [
                      Icon(
                        Icons.medical_services_rounded,
                        size: screenWidth < 360 ? 12 : 14,
                        color: isDark
                            ? ProfileColors.textSecondaryDark
                            : ProfileColors.textSecondaryColor,
                      ),
                      SizedBox(width: screenWidth * 0.015),
                      Expanded(
                        child: Text(
                          institution.specialty,
                          style: TextStyle(
                            fontSize: screenWidth < 360 ? 12 : 13,
                            color: isDark
                                ? ProfileColors.textSecondaryDark
                                : ProfileColors.textSecondaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Row(
                    children: [
                      Icon(
                        Icons.phone_rounded,
                        size: screenWidth < 360 ? 12 : 14,
                        color: isDark
                            ? ProfileColors.textSecondaryDark
                            : ProfileColors.textSecondaryColor,
                      ),
                      SizedBox(width: screenWidth * 0.015),
                      Expanded(
                        child: Text(
                          institution.phone,
                          style: TextStyle(
                            fontSize: screenWidth < 360 ? 12 : 13,
                            color: isDark
                                ? const Color(0xFFD1D5DB)
                                : const Color(0xFF495057),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Bouton de navigation
            Container(
              width: arrowButtonSize,
              height: arrowButtonSize,
              decoration: BoxDecoration(
                color: isDark
                    ? ProfileColors.borderDark
                    : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: onViewDetails,
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: isDark
                          ? ProfileColors.textSecondaryDark
                          : ProfileColors.textSecondaryColor,
                      size: arrowButtonSize * 0.55,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}