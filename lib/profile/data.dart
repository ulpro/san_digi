import 'package:flutter/material.dart';
import '../models/health_model.dart';

class ProfileData {
  static final MedicalInfo medicalInfo = MedicalInfo.defaultInfo();

  static final List<EmergencyContact> emergencyContacts = [
    EmergencyContact(
      name: 'Jeanne Dupont',
      relationship: 'Épouse',
      phone: '+33 6 12 34 56 78',
      icon: Icons.person,
    ),
    EmergencyContact(
      name: 'Luc Martin',
      relationship: 'Fils',
      phone: '+33 6 23 45 67 89',
      icon: Icons.person,
    ),
    EmergencyContact(
      name: 'Dr. Sophie Martin',
      relationship: 'Cardiologue',
      phone: '+33 1 23 45 67 89',
      icon: Icons.medical_services,
    ),
  ];

  static final List<HealthcareInstitution> healthcareInstitutions = [
    HealthcareInstitution(
      name: 'Hôpital Central',
      specialty: 'Cardiologie',
      phone: '+33 1 45 67 89 00',
      icon: Icons.local_hospital,
      address: '123 Avenue de la Santé, 75015 Paris',
      hours: 'Lun-Ven: 8h-19h, Sam: 9h-13h',
    ),
    HealthcareInstitution(
      name: 'Clinique de la Forêt',
      specialty: 'Médecine Générale',
      phone: '+33 1 56 78 90 12',
      icon: Icons.local_hospital,
      address: '456 Rue du Médical, 75008 Paris',
      hours: 'Lun-Sam: 8h-20h',
    ),
    HealthcareInstitution(
      name: 'Centre d\'Imagerie Médicale',
      specialty: 'Radiologie',
      phone: '+33 1 67 89 01 23',
      icon: Icons.medical_services,
      address: '789 Boulevard des Examens, 75016 Paris',
      hours: 'Lun-Ven: 7h-21h, Sam: 8h-14h',
    ),
  ];

  static final HealthCode healthCode = HealthCode.defaultCode();
}
