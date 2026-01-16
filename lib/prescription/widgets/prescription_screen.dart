import 'package:flutter/material.dart';
import 'data.dart';
import 'widgets/header_stats.dart';
import 'widgets/prescription_card.dart';
import 'widgets/empty_state.dart';
import 'widgets/filter_dialog.dart';
import '../prescription_detail/screens/prescription_detail_screen.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  List<Prescription> _filteredPrescriptions = PrescriptionData.prescriptions;

  void _showPrescriptionDetails(Prescription prescription) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrescriptionDetailScreen(prescription: prescription),
      ),
    );
  }

  void _showAddPrescription() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ajout d\'ordonnance - Fonctionnalité à venir'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _showFilterDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => const FilterDialog(),
    );

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Filtre "$result" sélectionné'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final hasPrescriptions = _filteredPrescriptions.isNotEmpty;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth > 600 ? 20 : 16),
          child: Column(
            children: [
              // En-tête avec statistiques
              HeaderStats(stats: PrescriptionData.stats),
              const SizedBox(height: 20),

              // Liste des ordonnances
              Expanded(
                child: hasPrescriptions
                    ? ListView.builder(
                        itemCount: _filteredPrescriptions.length,
                        itemBuilder: (context, index) {
                          final prescription = _filteredPrescriptions[index];
                          return PrescriptionCard(
                            prescription: prescription,
                            onViewDetails: () => _showPrescriptionDetails(prescription),
                          );
                        },
                      )
                    : EmptyState(onAddPrescription: _showAddPrescription),
              ),
            ],
          ),
        ),
      ),
    );
  }
}