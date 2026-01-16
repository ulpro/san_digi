import 'package:flutter/material.dart';
import '../constants.dart';
import '../models.dart';

class ContactCard extends StatelessWidget {
  final EmergencyContact contact;
  final bool isDark;
  final double screenWidth;
  final VoidCallback onCall;
  final bool isLast;

  const ContactCard({
    super.key,
    required this.contact,
    required this.isDark,
    required this.screenWidth,
    required this.onCall,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = screenWidth < 360 ? 48.0 : 56.0;
    final callButtonSize = screenWidth < 360 ? 44.0 : 52.0;
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
            // Avatar
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [ProfileColors.primaryColor, ProfileColors.primaryGradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(ProfileConstants.smallCardBorderRadius),
              ),
              child: Center(
                child: Icon(
                  contact.icon,
                  color: Colors.white,
                  size: avatarSize * 0.45,
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
                    contact.name,
                    style: TextStyle(
                      fontSize: screenWidth < 360 ? 15 : 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? ProfileColors.textLight : ProfileColors.textMainColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth < 360 ? 6 : 8,
                      vertical: screenWidth < 360 ? 1 : 2,
                    ),
                    decoration: BoxDecoration(
                      color: ProfileColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      contact.relationship,
                      style: TextStyle(
                        fontSize: screenWidth < 360 ? 11 : 12,
                        fontWeight: FontWeight.w600,
                        color: ProfileColors.primaryColor,
                      ),
                    ),
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
                          contact.phone,
                          style: TextStyle(
                            fontSize: screenWidth < 360 ? 12 : 14,
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

            // Bouton d'appel
            Container(
              width: callButtonSize,
              height: callButtonSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [ProfileColors.successColor, ProfileColors.callButtonColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ProfileColors.successColor.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(callButtonSize / 2),
                child: InkWell(
                  onTap: onCall,
                  borderRadius: BorderRadius.circular(callButtonSize / 2),
                  child: Center(
                    child: Icon(
                      Icons.call_rounded,
                      color: Colors.white,
                      size: callButtonSize * 0.45,
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