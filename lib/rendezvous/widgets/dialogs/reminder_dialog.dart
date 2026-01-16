import 'package:flutter/material.dart';
import '../../constants.dart';

class ReminderDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ReminderDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Rappel de rendez-vous',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: const Text(
        'Voulez-vous programmer un rappel pour ce rendez-vous ?',
        style: TextStyle(
          fontSize: 14,
          color: RendezVousColors.textSecondaryDark,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Annuler',
            style: TextStyle(
              color: RendezVousColors.textSecondaryDark,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: RendezVousColors.primaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Programmer'),
        ),
      ],
    );
  }
}