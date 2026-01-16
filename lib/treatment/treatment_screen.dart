import 'package:flutter/material.dart';
import 'data.dart';
import 'constants.dart';
import 'models.dart';
import 'widgets/alert_banner.dart';
import 'widgets/upcoming_doses_section.dart';
import 'widgets/adherence_section.dart';
import 'widgets/treatment_history_section.dart';

class TreatmentScreen extends StatefulWidget {
  const TreatmentScreen({super.key});

  @override
  State<TreatmentScreen> createState() => _TreatmentScreenState();
}

class _TreatmentScreenState extends State<TreatmentScreen> {
  late List<Dose> _upcomingDoses;

  @override
  void initState() {
    super.initState();
    _upcomingDoses = List.from(TreatmentData.upcomingDoses);
  }

  void _markAsTaken(String doseId) {
    setState(() {
      final index = _upcomingDoses.indexWhere((dose) => dose.id == doseId);
      if (index != -1) {
        _upcomingDoses[index] = Dose(
          id: _upcomingDoses[index].id,
          name: _upcomingDoses[index].name,
          dosage: _upcomingDoses[index].dosage,
          time: _upcomingDoses[index].time,
          type: _upcomingDoses[index].type,
          status: 'taken',
          color: TreatmentColors.successColor,
          icon: _upcomingDoses[index].icon,
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Médicament marqué comme pris'),
        backgroundColor: TreatmentColors.successColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _addNewMedication() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ajouter un médicament',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Médicament ajouté avec succès'),
                      backgroundColor: TreatmentColors.successColor,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('Ajouter'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      color: isDark
          ? TreatmentColors.backgroundColorDark
          : TreatmentColors.backgroundColorLight,
      child: Column(
        children: [
          // Contenu principal avec défilement
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(TreatmentConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bannière d'alerte
                  AlertBanner(
                    message: TreatmentData.currentAlert.message,
                    isUrgent: TreatmentData.currentAlert.isUrgent,
                  ),
                  const SizedBox(height: TreatmentConstants.defaultPadding),

                  // Section prochaines prises
                  UpcomingDosesSection(
                    doses: _upcomingDoses,
                    onMarkAsTaken: _markAsTaken,
                  ),
                  const SizedBox(height: TreatmentConstants.defaultPadding),

                  // Section observance
                  AdherenceSection(adherence: TreatmentData.currentAdherence),
                  const SizedBox(height: TreatmentConstants.largePadding),

                  // Section historique des traitements
                  TreatmentHistorySection(
                    treatments: TreatmentData.activeTreatments,
                  ),
                  const SizedBox(height: TreatmentConstants.largePadding),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}