import 'package:flutter/material.dart';
import '../../constants.dart';
import '../form_fields.dart';

class NewAppointmentSheet extends StatefulWidget {
  const NewAppointmentSheet({super.key});

  @override
  State<NewAppointmentSheet> createState() => _NewAppointmentSheetState();
}

class _NewAppointmentSheetState extends State<NewAppointmentSheet> {
  final TextEditingController _specialtyController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    _specialtyController.dispose();
    _reasonController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Demande de rendez-vous envoyée'),
        backgroundColor: RendezVousColors.healthGreen,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nouveau rendez-vous',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          AppointmentFormField(
            label: 'Spécialité recherchée',
            icon: Icons.medical_services_rounded,
            controller: _specialtyController,
          ),
          const SizedBox(height: 12),
          AppointmentFormField(
            label: 'Motif de la consultation',
            icon: Icons.description_rounded,
            controller: _reasonController,
          ),
          const SizedBox(height: 12),
          AppointmentFormField(
            label: 'Date souhaitée',
            icon: Icons.calendar_today_rounded,
            controller: _dateController,
          ),
          const SizedBox(height: 12),
          AppointmentFormField(
            label: 'Préférence horaire',
            icon: Icons.access_time_rounded,
            controller: _timeController,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: RendezVousColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      RendezVousConstants.buttonBorderRadius),
                ),
              ),
              child: const Text(
                'Demander un rendez-vous',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}