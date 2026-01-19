import 'package:flutter/material.dart';
import '../../models/prescription_model.dart'; // Importe Prescription
import '../widgets/header_card.dart';
import '../widgets/info_section.dart';
import '../widgets/medications_section.dart';
import '../widgets/instructions_section.dart';
import '../widgets/qr_code_section.dart';
import '../widgets/bottom_action_bar.dart';

class PrescriptionDetailScreen extends StatelessWidget {
  final Prescription prescription;

  const PrescriptionDetailScreen({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Détail de l\'ordonnance')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              HeaderCard(prescription: prescription, isDark: isDark),
              const SizedBox(height: 20),
              InfoSection(
                remainingRefills: prescription.remainingRefills,
                medicationCount: prescription.medicationDetails.length,
                isDark: isDark,
              ),
              const SizedBox(height: 20),
              MedicationsSection(
                medications: prescription.medicationDetails,
                isDark: isDark,
              ),
              const SizedBox(height: 20),
              InstructionsSection(
                instructions: prescription.instructions,
                isDark: isDark,
              ),
              const SizedBox(height: 20),
              QRCodeSection(isDark: isDark),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        isCompleted: prescription.isCompleted,
        canRenew: prescription.canRenew,
        onRenew: () {},
        onMarkCompleted: () {},
        onShare: () {},
      ),
    );
  }
}
