import 'package:flutter/material.dart';
import '../../constants.dart';

class ConfirmDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ConfirmDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Confirmer le rendez-vous',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: const Text(
        'Voulez-vous confirmer votre présence à ce rendez-vous ?',
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
            backgroundColor: RendezVousColors.healthGreen,
            foregroundColor: Colors.white,
          ),
          child: const Text('Confirmer'),
        ),
      ],
    );
  }
}