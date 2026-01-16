import 'package:flutter/material.dart';
import '../constants.dart';

class EmergencyButton extends StatelessWidget {
  final bool isDark;
  final double screenWidth;
  final VoidCallback onPressed;

  const EmergencyButton({
    super.key,
    required this.isDark,
    required this.screenWidth,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = screenWidth < 360 ? 58.0 : 66.0;
    final iconContainerSize = screenWidth < 360 ? 40.0 : 44.0;
    final iconSize = screenWidth < 360 ? 22.0 : 26.0;
    final titleFontSize = screenWidth < 360 ? 15.0 : 17.0;
    final subtitleFontSize = screenWidth < 360 ? 11.0 : 12.0;

    return Container(
      width: double.infinity,
      height: buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ProfileConstants.cardBorderRadius),
        gradient: const LinearGradient(
          colors: [ProfileColors.alertColor, Color(0xFFFF5252)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: ProfileColors.alertColor.withOpacity(0.5),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(ProfileConstants.cardBorderRadius),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(ProfileConstants.cardBorderRadius),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: iconContainerSize,
                  height: iconContainerSize,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.emergency_rounded,
                    color: Colors.white,
                    size: iconSize,
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MODE URGENCE',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.005),
                      Text(
                        'Appeler l\'aide immédiatement',
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white,
                  size: screenWidth < 360 ? 24 : 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}