import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models.dart';

class MedicalReportDialog extends StatelessWidget {
  final MedicalReport report;

  const MedicalReportDialog({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            RendezVousConstants.dialogBorderRadius),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Compte-rendu médical',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              report.content,
              style: const TextStyle(
                fontSize: 14,
                color: RendezVousColors.textSecondaryDark,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Recommandations : ${report.recommendations}',
              style: const TextStyle(
                fontSize: 14,
                color: RendezVousColors.textSecondaryDark,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: RendezVousColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        RendezVousConstants.buttonBorderRadius),
                  ),
                ),
                child: const Text(
                  'Fermer',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
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