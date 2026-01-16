import 'package:flutter/material.dart';

class MedicalInfo {
  final String allergies;
  final String bloodType;
  final List<String> importantTreatments;

  MedicalInfo({
    required this.allergies,
    required this.bloodType,
    required this.importantTreatments,
  });

  factory MedicalInfo.defaultInfo() {
    return MedicalInfo(
      allergies: 'Pollen, Pénicilline',
      bloodType: 'O+',
      importantTreatments: ['Lévothyroxine', 'Anticoagulants'],
    );
  }
}

class EmergencyContact {
  final String name;
  final String relationship;
  final String phone;
  final IconData icon;

  EmergencyContact({
    required this.name,
    required this.relationship,
    required this.phone,
    required this.icon,
  });

  factory EmergencyContact.fromMap(Map<String, dynamic> map) {
    return EmergencyContact(
      name: map['name'] ?? '',
      relationship: map['relationship'] ?? '',
      phone: map['phone'] ?? '',
      icon: map['icon'] ?? Icons.person,
    );
  }
}

class HealthcareInstitution {
  final String name;
  final String specialty;
  final String phone;
  final IconData icon;
  final String? address;
  final String? hours;

  HealthcareInstitution({
    required this.name,
    required this.specialty,
    required this.phone,
    required this.icon,
    this.address,
    this.hours,
  });

  factory HealthcareInstitution.fromMap(Map<String, dynamic> map) {
    return HealthcareInstitution(
      name: map['name'] ?? '',
      specialty: map['specialty'] ?? '',
      phone: map['phone'] ?? '',
      icon: map['icon'] ?? Icons.local_hospital,
      address: map['address'],
      hours: map['hours'],
    );
  }
}

class HealthCode {
  final String id;
  final String code;
  final DateTime createdAt;

  HealthCode({
    required this.id,
    required this.code,
    required this.createdAt,
  });

  factory HealthCode.defaultCode() {
    return HealthCode(
      id: 'SNDG-2024-001',
      code: 'CODE SANTÉ',
      createdAt: DateTime.now(),
    );
  }
}