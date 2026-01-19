class MedicationDetail {
  final String name;
  final String dosage;
  final String frequency;
  final String duration;

  MedicationDetail({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.duration,
  });

  factory MedicationDetail.fromMap(Map<String, dynamic> map) {
    return MedicationDetail(
      name: map['name'] ?? 'Médicament',
      dosage: map['dosage'] ?? 'N/A',
      frequency: map['frequency'] ?? 'N/A',
      duration: map['duration'] ?? 'N/A',
    );
  }
}

class Prescription {
  final String id;
  final String title;
  final String doctor;
  final String date;
  final String status; // 'active', 'completed', 'pending', 'expiring'
  final List<String> medications;
  final int remainingRefills;
  final String expiryDate;
  final String doctorFullName;
  final String hospital;
  final List<MedicationDetail> medicationDetails;
  final String instructions;

  Prescription({
    required this.id,
    required this.title,
    required this.doctor,
    required this.date,
    required this.status,
    required this.medications,
    required this.remainingRefills,
    required this.expiryDate,
    required this.doctorFullName,
    required this.hospital,
    required this.medicationDetails,
    required this.instructions,
  });

  factory Prescription.fromMap(Map<String, dynamic> map) {
    return Prescription(
      id: map['id'] ?? '',
      title: map['title'] ?? 'Ordonnance médicale',
      doctor: map['doctor'] ?? 'Dr. Inconnu',
      date: map['date'] ?? '',
      status: map['status'] ?? 'active',
      medications: List<String>.from(map['medications'] ?? []),
      remainingRefills: map['remainingRefills'] ?? 0,
      expiryDate: map['expiryDate'] ?? '',
      doctorFullName: map['doctorFullName'] ?? map['doctor'] ?? 'Dr. Inconnu',
      hospital: map['hospital'] ?? 'Hôpital non spécifié',
      medicationDetails: (map['medicationDetails'] as List? ?? [])
          .map((item) => MedicationDetail.fromMap(item))
          .toList(),
      instructions: map['instructions'] ?? '',
    );
  }

  bool get canRenew => remainingRefills > 0;
  bool get isCompleted => status == 'completed';
  bool get isExpiring => status == 'expiring';
  bool get isActive => status == 'active';
  bool get isPending => status == 'pending';
}

class PrescriptionStats {
  final int activeCount;
  final int expiringCount;
  final int totalCount;

  PrescriptionStats({
    required this.activeCount,
    required this.expiringCount,
    required this.totalCount,
  });

  factory PrescriptionStats.fromPrescriptions(
    List<Prescription> prescriptions,
  ) {
    return PrescriptionStats(
      activeCount: prescriptions.where((p) => p.status == 'active').length,
      expiringCount: prescriptions.where((p) => p.status == 'expiring').length,
      totalCount: prescriptions.length,
    );
  }
}
