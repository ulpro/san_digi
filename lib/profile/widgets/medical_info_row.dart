import 'package:flutter/material.dart';
import '../constants.dart';

class MedicalInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool isDark;
  final bool isMultiLine;
  final List<String>? treatments;
  final Color color;
  final double screenWidth;

  const MedicalInfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.isDark,
    this.isMultiLine = false,
    this.treatments,
    required this.color,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final iconContainerSize = screenWidth < 360 ? 40.0 : 44.0;
    final iconSize = screenWidth < 360 ? 20.0 : 22.0;
    final titleFontSize = screenWidth < 360 ? 14.0 : 15.0;
    final valueFontSize = screenWidth < 360 ? 13.0 : 14.0;

    return Container(
      padding: EdgeInsets.all(screenWidth < 360 ? 10 : 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111827) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(ProfileConstants.smallCardBorderRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icône
          Container(
            width: iconContainerSize,
            height: iconContainerSize,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: iconSize),
          ),
          SizedBox(width: screenWidth < 360 ? 10 : 12),

          // Contenu
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                    color: isDark ? ProfileColors.textLight : ProfileColors.textMainColor,
                  ),
                ),
                SizedBox(height: screenWidth * 0.01),
                if (isMultiLine && treatments != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: treatments!
                        .map<Widget>(
                          (treatment) => Padding(
                            padding: EdgeInsets.only(bottom: screenWidth * 0.01),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.circle, size: 6, color: color),
                                SizedBox(width: screenWidth * 0.02),
                                Expanded(
                                  child: Text(
                                    treatment,
                                    style: TextStyle(
                                      fontSize: valueFontSize,
                                      color: isDark
                                          ? ProfileColors.textSecondaryDark
                                          : ProfileColors.textSecondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  )
                else
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: valueFontSize,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? ProfileColors.textSecondaryDark
                          : ProfileColors.textSecondaryColor,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}