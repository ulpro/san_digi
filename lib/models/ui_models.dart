import 'package:flutter/material.dart';

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
