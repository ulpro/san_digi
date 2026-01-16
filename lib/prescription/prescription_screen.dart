import 'package:flutter/material.dart';
import 'data.dart';  // Importe PrescriptionData
import 'widgets/header_stats.dart';
import 'widgets/prescription_card.dart';
import 'widgets/empty_state.dart';
import '../prescription_detail/screens/prescription_detail_screen.dart';

class PrescriptionScreen extends StatelessWidget {
  const PrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // En-tête avec statistiques
              HeaderStats(stats: PrescriptionData.stats),
              const SizedBox(height: 20),

              // Liste des ordonnances
              Expanded(
                child: PrescriptionData.prescriptions.isEmpty
                    ? EmptyState(onAddPrescription: () {
                        // Action d'ajout
                      })
                    : ListView.builder(
                        itemCount: PrescriptionData.prescriptions.length,
                        itemBuilder: (context, index) {
                          final prescription = PrescriptionData.prescriptions[index];
                          return PrescriptionCard(
                            prescription: prescription,
                            onViewDetails: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => 
                                    PrescriptionDetailScreen(prescription: prescription),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}