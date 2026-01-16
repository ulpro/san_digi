import 'package:flutter/material.dart';
import '../../constants.dart';

class CancelDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const CancelDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Annuler le rendez-vous',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: const Text(
        'Êtes-vous sûr de vouloir annuler ce rendez-vous ?',
        style: TextStyle(
          fontSize: 14,
          color: RendezVousColors.textSecondaryDark,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Non, garder',
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
            backgroundColor: RendezVousColors.alertRed,
            foregroundColor: Colors.white,
          ),
          child: const Text('Oui, annuler'),
        ),
      ],
    );
  }
}