import 'models.dart';
import 'constants.dart';
import 'package:flutter/material.dart';

class HomeData {
  static final List<Medication> medications = [
    Medication(
      name: 'Metformine',
      dosage: '500mg, 2 fois par jour',
      status: 'warning',
      daysLeft: 7,
      lastTaken: 'Aujourd\'hui, 08:30',
      type: 'Comprimé',
      schedule: [true, false, true],
      remainingPills: 15,
      totalPills: 60,
    ),
    Medication(
      name: 'Lisinopril',
      dosage: '10mg, 1 fois par jour',
      status: 'normal',
      daysLeft: 30,
      lastTaken: 'Aujourd\'hui, 09:00',
      type: 'Comprimé',
      schedule: [true, false, false],
      remainingPills: 45,
      totalPills: 90,
    ),
    Medication(
      name: 'Atorvastatine',
      dosage: '20mg, 1 fois par jour',
      status: 'normal',
      daysLeft: 45,
      lastTaken: 'Hier, 20:00',
      type: 'Comprimé',
      schedule: [false, false, true],
      remainingPills: 30,
      totalPills: 90,
    ),
  ];

  static final List<Prescription> prescriptions = [
    Prescription(
      title: 'Ordonnance cardiologie',
      doctor: 'Dr. Martin',
      date: '05/06/2024',
      status: 'active',
      remainingRefills: 2,
      expiryDate: '05/09/2024',
    ),
    Prescription(
      title: 'Ordonnance diabétologie',
      doctor: 'Dr. Dubois',
      date: '12/03/2024',
      status: 'expiring',
      remainingRefills: 0,
      expiryDate: '12/06/2024',
    ),
    Prescription(
      title: 'Ordonnance généraliste',
      doctor: 'Dr. Leroy',
      date: '20/05/2024',
      status: 'active',
      remainingRefills: 1,
      expiryDate: '20/08/2024',
    ),
  ];

  static final Appointment nextAppointment = Appointment(
    doctor: 'Dr. Sophie Martin',
    specialty: 'Cardiologue',
    date: 'Lun 15 Juin 2024',
    time: '10:00 - 10:30',
    address: '123 Rue de la Santé, 75015 Paris',
    type: 'Consultation de suivi',
    isConfirmed: true,
    duration: '30 min',
  );

  static final List<HealthIndicator> healthIndicators = [
    HealthIndicator(
      type: 'Glycémie',
      value: '1.2',
      unit: 'g/L',
      date: '01/06/2024',
      trend: 'down',
      status: 'normal',
      icon: Icons.water_drop,
    ),
    HealthIndicator(
      type: 'Tension',
      value: '12/8',
      unit: '',
      date: '28/05/2024',
      trend: 'stable',
      status: 'good',
      icon: Icons.monitor_heart,
    ),
    HealthIndicator(
      type: 'Poids',
      value: '72',
      unit: 'kg',
      date: '15/05/2024',
      trend: 'stable',
      status: 'normal',
      icon: Icons.monitor_weight,
    ),
    HealthIndicator(
      type: 'Cholestérol',
      value: '1.8',
      unit: 'g/L',
      date: '15/05/2024',
      trend: 'up',
      status: 'warning',
      icon: Icons.bloodtype,
    ),
  ];

  static final List<Activity> activities = [
    Activity(
      type: 'Prise médicament',
      description: 'Metformine pris',
      time: '08:30',
      icon: Icons.medication,
      color: AppColors.successGreen,
    ),
    Activity(
      type: 'Rappel',
      description: 'Rendez-vous confirmé',
      time: 'Hier, 15:20',
      icon: Icons.notifications,
      color: AppColors.primaryBlue,
    ),
    Activity(
      type: 'Consultation',
      description: 'Visite chez le cardiologue',
      time: '01/06/2024',
      icon: Icons.medical_services,
      color: AppColors.purpleHealth,
    ),
    Activity(
      type: 'Prescription',
      description: 'Nouvelle ordonnance',
      time: '28/05/2024',
      icon: Icons.description,
      color: AppColors.tealHealth,
    ),
  ];

  static List<StatCard> getStatsCards() {
    return [
      StatCard(
        icon: Icons.medication,
        value: medications.length.toString(),
        label: 'Traitements actifs',
        color: AppColors.primaryBlue,
        progress: medications.length / 10.0,
      ),
      StatCard(
        icon: Icons.calendar_today,
        value: '1',
        label: 'RDV à venir',
        color: AppColors.healthGreen,
        progress: 0.3,
      ),
      StatCard(
        icon: Icons.description,
        value: prescriptions.length.toString(),
        label: 'Prescriptions',
        color: AppColors.warningOrange,
        progress: prescriptions.length / 5.0,
      ),
    ];
  }

  static bool get needsRenewal =>
      medications.any((m) => m.status == 'warning');
}