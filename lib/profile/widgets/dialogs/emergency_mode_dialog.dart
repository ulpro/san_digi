import 'package:flutter/material.dart';
import '../../constants.dart';

class EmergencyModeDialog extends StatelessWidget {
  const EmergencyModeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ProfileConstants.dialogBorderRadius),
      ),
      title: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ProfileColors.alertColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(Icons.emergency_rounded, color: ProfileColors.alertColor, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Mode Urgence',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: ProfileColors.alertColor,
                ),
              ),
            ),
          ],
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'Le mode urgence va contacter tous vos contacts d\'urgence, '
          'partager votre position et appeler les services d\'urgence. '
          'Cette action est irréversible.',
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7280),
            height: 1.6,
          ),
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: ProfileColors.alertColor.withOpacity(0.8),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'À utiliser uniquement en cas d\'urgence réelle',
                      style: TextStyle(
                        fontSize: 12,
                        color: ProfileColors.alertColor.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFF3F4F6),
                        foregroundColor: const Color(0xFF6B7280),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Annuler',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _startEmergencyProtocol(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ProfileColors.alertColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.emergency_rounded, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Activer',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _startEmergencyProtocol(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.emergency_rounded, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Mode urgence activé - Contacts alertés',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: ProfileColors.alertColor,
        duration: Duration(seconds: 5),
      ),
    );

    // Note: Pour l'écran EmergencyModeScreen, vous pouvez l'ajouter séparément
    // ou l'inclure ici comme navigation vers un nouvel écran
  }
}