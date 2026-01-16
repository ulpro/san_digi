import 'models.dart';

class PrescriptionData {
  static final List<Prescription> prescriptions = [
    Prescription(
      id: '1',
      title: 'Ordonnance cardiologie',
      doctor: 'Dr. Martin',
      date: '24 Mai 2024',
      status: 'active',
      medications: ['Paracetamol 1000mg', 'Ibuprofène 400mg', '...'],
      remainingRefills: 2,
      expiryDate: '24 Août 2024',
      doctorFullName: 'Dr. Jean Dupont',
      hospital: 'Hôpital Central',
      medicationDetails: [
        MedicationDetail(
          name: 'Amoxicilline',
          dosage: '500mg',
          frequency: '2 fois/jour',
          duration: 'pendant 7 jours',
        ),
        MedicationDetail(
          name: 'Paracétamol',
          dosage: '1g',
          frequency: '3 fois/jour si douleur',
          duration: 'pendant 5 jours',
        ),
      ],
      instructions: 'À prendre pendant les repas. Éviter l\'exposition au soleil pendant le traitement à l\'Amoxicilline.',
    ),
    Prescription(
      id: '2',
      title: 'Ordonnance généraliste',
      doctor: 'Dr. Dupont',
      date: '15 Avril 2024',
      status: 'completed',
      medications: ['Amoxicilline 500mg'],
      remainingRefills: 0,
      expiryDate: '15 Juillet 2024',
      doctorFullName: 'Dr. Sophie Martin',
      hospital: 'Clinique Saint-Louis',
      medicationDetails: [
        MedicationDetail(
          name: 'Amoxicilline',
          dosage: '500mg',
          frequency: '2 fois/jour',
          duration: 'pendant 7 jours',
        ),
      ],
      instructions: 'À prendre pendant les repas.',
    ),
    Prescription(
      id: '3',
      title: 'Ordonnance renouvellement',
      doctor: 'Dr. Durand',
      date: '02 Février 2024',
      status: 'pending',
      medications: ['Demande de renouvellement'],
      remainingRefills: 1,
      expiryDate: '02 Mai 2024',
      doctorFullName: 'Dr. Pierre Durand',
      hospital: 'Centre Médical',
      medicationDetails: [
        MedicationDetail(
          name: 'Métoprolol',
          dosage: '50mg',
          frequency: '1 fois/jour',
          duration: 'pendant 30 jours',
        ),
      ],
      instructions: 'Prendre le matin.',
    ),
    Prescription(
      id: '4',
      title: 'Ordonnance spécialisée',
      doctor: 'Dr. Lefebvre',
      date: '10 Juin 2024',
      status: 'expiring',
      medications: ['Métoprolol 50mg', 'Aspirine 100mg'],
      remainingRefills: 0,
      expiryDate: '10 Juillet 2024',
      doctorFullName: 'Dr. Marie Lefebvre',
      hospital: 'Hôpital Universitaire',
      medicationDetails: [
        MedicationDetail(
          name: 'Métoprolol',
          dosage: '50mg',
          frequency: '1 fois/jour',
          duration: 'pendant 30 jours',
        ),
        MedicationDetail(
          name: 'Aspirine',
          dosage: '100mg',
          frequency: '1 fois/jour',
          duration: 'pendant 30 jours',
        ),
      ],
      instructions: 'Contrôler la tension artérielle régulièrement.',
    ),
  ];

  static PrescriptionStats get stats => PrescriptionStats.fromPrescriptions(prescriptions);
}