import 'package:flutter/material.dart';
import '../constants.dart';

class AppointmentFormField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController? controller;

  const AppointmentFormField({
    super.key,
    required this.label,
    required this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: RendezVousColors.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              RendezVousConstants.buttonBorderRadius),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              RendezVousConstants.buttonBorderRadius),
          borderSide: const BorderSide(
              color: RendezVousColors.primaryColor, width: 2),
        ),
      ),
    );
  }
}