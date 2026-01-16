import 'package:flutter/material.dart';

class Appointment {
  final String id;
  final String doctor;
  final String specialty;
  final String date;
  final String time;
  final String address;
  final String type;
  final String status; // 'confirmed', 'pending', 'completed', 'cancelled'
  final String duration;
  final bool isToday;

  Appointment({
    required this.id,
    required this.doctor,
    required this.specialty,
    required this.date,
    required this.time,
    required this.address,
    required this.type,
    required this.status,
    required this.duration,
    required this.isToday,
  });

  Color get statusColor {
    switch (status) {
      case 'confirmed':
        return const Color(0xFF4CD964);
      case 'pending':
        return const Color(0xFFFF9500);
      case 'completed':
        return const Color(0xFF6C757D);
      case 'cancelled':
        return const Color(0xFFFF3B30);
      default:
        return const Color(0xFF2A7DE1);
    }
  }

  String get statusText {
    switch (status) {
      case 'confirmed':
        return 'Confirmé';
      case 'pending':
        return 'En attente';
      case 'completed':
        return 'Terminé';
      case 'cancelled':
        return 'Annulé';
      default:
        return 'Inconnu';
    }
  }

  IconData get statusIcon {
    switch (status) {
      case 'confirmed':
        return Icons.check_circle_rounded;
      case 'pending':
        return Icons.access_time_rounded;
      case 'completed':
        return Icons.done_all_rounded;
      case 'cancelled':
        return Icons.cancel_rounded;
      default:
        return Icons.help_rounded;
    }
  }

  bool get canShowActions => status == 'confirmed' || status == 'pending';
  bool get isConfirmed => status == 'confirmed';
  bool get isPending => status == 'pending';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';
}

class AppointmentFilter {
  final String label;
  final int index;

  const AppointmentFilter({
    required this.label,
    required this.index,
  });

  static const List<AppointmentFilter> filters = [
    AppointmentFilter(label: 'À venir', index: 0),
    AppointmentFilter(label: 'Passés', index: 1),
    AppointmentFilter(label: 'Annulés', index: 2),
  ];
}

class MedicalReport {
  final String appointmentId;
  final String doctor;
  final String date;
  final String content;
  final String recommendations;

  MedicalReport({
    required this.appointmentId,
    required this.doctor,
    required this.date,
    required this.content,
    required this.recommendations,
  });
}