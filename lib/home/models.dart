import 'package:flutter/material.dart';

class Medication {
  final String name;
  final String dosage;
  final String status;
  final int daysLeft;
  final String lastTaken;
  final String type;
  final List<bool> schedule;
  final int remainingPills;
  final int totalPills;

  Medication({
    required this.name,
    required this.dosage,
    required this.status,
    required this.daysLeft,
    required this.lastTaken,
    required this.type,
    required this.schedule,
    required this.remainingPills,
    required this.totalPills,
  });

  double get progress => remainingPills / totalPills;
}

class Prescription {
  final String title;
  final String doctor;
  final String date;
  final String status;
  final int remainingRefills;
  final String expiryDate;

  Prescription({
    required this.title,
    required this.doctor,
    required this.date,
    required this.status,
    required this.remainingRefills,
    required this.expiryDate,
  });

  bool get isExpiring => status == 'expiring';
}

class Appointment {
  final String doctor;
  final String specialty;
  final String date;
  final String time;
  final String address;
  final String type;
  final bool isConfirmed;
  final String duration;

  Appointment({
    required this.doctor,
    required this.specialty,
    required this.date,
    required this.time,
    required this.address,
    required this.type,
    required this.isConfirmed,
    required this.duration,
  });
}

class HealthIndicator {
  final String type;
  final String value;
  final String unit;
  final String date;
  final String trend;
  final String status;
  final IconData icon;

  HealthIndicator({
    required this.type,
    required this.value,
    required this.unit,
    required this.date,
    required this.trend,
    required this.status,
    required this.icon,
  });
}

class Activity {
  final String type;
  final String description;
  final String time;
  final IconData icon;
  final Color color;

  Activity({
    required this.type,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
  });
}

class StatCard {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final double progress;

  StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.progress,
  });
}