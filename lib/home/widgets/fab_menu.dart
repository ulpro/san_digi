import 'package:flutter/material.dart';
import '../constants.dart';

class FabMenu extends StatelessWidget {
  const FabMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.fabBorderRadius),
        gradient: const LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppConstants.fabBorderRadius),
        child: PopupMenuButton<String>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.fabBorderRadius),
          ),
          offset: const Offset(0, -120),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'treatment',
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.healthGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.medication,
                        color: AppColors.healthGreen, size: 18),
                  ),
                  const SizedBox(width: 12),
                  const Text('Ajouter traitement'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'appointment',
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.warningOrange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.calendar_today,
                      color: AppColors.warningOrange,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('Nouveau RDV'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'prescription',
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.description,
                      color: AppColors.primaryBlue,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('Nouvelle ordonnance'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'measurement',
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.purpleHealth.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.monitor_heart,
                      color: AppColors.purpleHealth,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('Nouvelle mesure'),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Ajout: $value'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}