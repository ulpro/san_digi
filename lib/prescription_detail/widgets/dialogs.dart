import 'package:flutter/material.dart';
import '../../prescription/constants.dart';

class RenewPrescriptionDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const RenewPrescriptionDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(
        'Renouveler l\'ordonnance',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.onSurface,
        ),
      ),
      content: Text(
        'Voulez-vous demander un renouvellement de cette ordonnance ?',
        style: TextStyle(
          fontSize: 14,
          color: theme.colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Annuler',
            style: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: PrescriptionColors.primaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Confirmer'),
        ),
      ],
    );
  }
}

class MarkCompletedDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const MarkCompletedDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(
        'Marquer comme terminée',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.onSurface,
        ),
      ),
      content: Text(
        'Voulez-vous marquer cette ordonnance comme terminée ?',
        style: TextStyle(
          fontSize: 14,
          color: theme.colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Annuler',
            style: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: PrescriptionColors.successColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Confirmer'),
        ),
      ],
    );
  }
}