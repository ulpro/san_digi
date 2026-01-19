import 'package:flutter/material.dart';
import '../constants.dart';
import '../../models/health_model.dart';
import 'contact_card.dart';

class EmergencyContactsSection extends StatelessWidget {
  final bool isDark;
  final double screenWidth;
  final List<EmergencyContact> contacts;
  final Function(EmergencyContact) onCallContact;

  const EmergencyContactsSection({
    super.key,
    required this.isDark,
    required this.screenWidth,
    required this.contacts,
    required this.onCallContact,
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
                Icons.contact_emergency_rounded,
                color: Colors.white,
                size: screenWidth < 360 ? 20 : 22,
              ),
            ),
            SizedBox(width: screenWidth < 360 ? 10 : 12),
            Flexible(
              child: Text(
                'Contacts d\'Urgence',
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

        // Liste des contacts
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
            children: contacts
                .asMap()
                .entries
                .map(
                  (entry) => ContactCard(
                    contact: entry.value,
                    isDark: isDark,
                    screenWidth: screenWidth,
                    onCall: () => onCallContact(entry.value),
                    isLast: entry.key == contacts.length - 1,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
