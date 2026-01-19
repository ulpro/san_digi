import 'package:flutter/material.dart';

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
