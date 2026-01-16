import 'models.dart';
import 'constants.dart';
import 'package:flutter/material.dart';

class TreatmentData {
  static final List<Dose> upcomingDoses = [
    Dose(
      id: '1',
      name: 'Paracétamol',
      dosage: 'Comprimé 500mg',
      time: 'Aujourd\'hui, 08:00',
      type: 'pill',
      status: 'taken',
      color: TreatmentColors.successColor,
      icon: Icons.medication,
    ),
    Dose(
      id: '2',
      name: 'Amoxicilline',
      dosage: 'Gélule 250mg',
      time: 'Aujourd\'hui, 12:00',
      type: 'capsule',
      status: 'pending',
      color: TreatmentColors.warningColor,
      icon: Icons.medication_liquid,
    ),
    Dose(
      id: '3',
      name: 'Metformine',
      dosage: 'Comprimé 850mg',
      time: 'Aujourd\'hui, 20:00',
      type: 'pill',
      status: 'upcoming',
      color: TreatmentColors.primaryColor,
      icon: Icons.medication,
    ),
  ];

  static final Adherence currentAdherence = Adherence(
    rate: 0.95, // 95%
    period: 'Ce mois-ci',
  );

  static final Alert currentAlert = Alert(
    message: 'Fin du traitement pour Amoxicilline dans 3 jours.',
    expiryDate: DateTime.now().add(const Duration(days: 3)),
  );

  static final List<Treatment> activeTreatments = [
    Treatment(
      name: 'Metformine',
      dosage: '850mg, 2 fois par jour',
      remainingDays: 15,
      totalDays: 30,
      startDate: DateTime.now().subtract(const Duration(days: 15)),
      endDate: DateTime.now().add(const Duration(days: 15)),
    ),
    Treatment(
      name: 'Lisinopril',
      dosage: '10mg, 1 fois par jour',
      remainingDays: 25,
      totalDays: 90,
      startDate: DateTime.now().subtract(const Duration(days: 65)),
      endDate: DateTime.now().add(const Duration(days: 25)),
    ),
    Treatment(
      name: 'Atorvastatine',
      dosage: '20mg, 1 fois par jour',
      remainingDays: 45,
      totalDays: 90,
      startDate: DateTime.now().subtract(const Duration(days: 45)),
      endDate: DateTime.now().add(const Duration(days: 45)),
    ),
  ];
}