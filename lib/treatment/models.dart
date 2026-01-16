import 'package:flutter/material.dart';

class Dose {
  final String id;
  final String name;
  final String dosage;
  final String time;
  final String type;
  final String status; // 'taken', 'pending', 'upcoming'
  final Color color;
  final IconData icon;

  Dose({
    required this.id,
    required this.name,
    required this.dosage,
    required this.time,
    required this.type,
    required this.status,
    required this.color,
    required this.icon,
  });

  bool get isTaken => status == 'taken';
  bool get isPending => status == 'pending';
  bool get isUpcoming => status == 'upcoming';
}

class Treatment {
  final String name;
  final String dosage;
  final int remainingDays;
  final int totalDays;
  final DateTime startDate;
  final DateTime endDate;

  Treatment({
    required this.name,
    required this.dosage,
    required this.remainingDays,
    required this.totalDays,
    required this.startDate,
    required this.endDate,
  });

  double get progress => remainingDays / totalDays;
  bool get needsRenewal => remainingDays < 7;
}

class Adherence {
  final double rate;
  final String period;

  Adherence({
    required this.rate,
    required this.period,
  });

  String get ratePercentage => '${(rate * 100).toInt()}%';
  String get encouragementMessage {
    if (rate >= 0.9) {
      return 'Excellent ! Continuez comme ça pour un traitement efficace.';
    } else if (rate >= 0.7) {
      return 'Bon suivi ! Pensez à activer les rappels pour améliorer votre observance.';
    } else {
      return 'Votre observance pourrait être meilleure. Activez les rappels pour ne pas oublier vos prises.';
    }
  }
}

class Alert {
  final String message;
  final DateTime expiryDate;

  Alert({
    required this.message,
    required this.expiryDate,
  });

  int get daysUntilExpiry => expiryDate.difference(DateTime.now()).inDays;
  bool get isUrgent => daysUntilExpiry <= 3;
}