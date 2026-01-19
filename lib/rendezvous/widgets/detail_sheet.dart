import 'package:flutter/material.dart';
import '../constants.dart';
import '../../models/appointment_model.dart';
import 'form_fields.dart';

class DetailSheet extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onCancel;

  const DetailSheet({
    super.key,
    required this.appointment,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Détails du rendez-vous',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 20),

          _buildDetailSection(
            'Médecin',
            appointment.doctor,
            Icons.person_rounded,
          ),
          const SizedBox(height: 12),
          _buildDetailSection(
            'Spécialité',
            appointment.specialty,
            Icons.medical_services_rounded,
          ),
          const SizedBox(height: 12),
          _buildDetailSection(
            'Date et heure',
            '${appointment.date} à ${appointment.time}',
            Icons.calendar_today_rounded,
          ),
          const SizedBox(height: 12),
          _buildDetailSection(
            'Durée',
            appointment.duration,
            Icons.access_time_rounded,
          ),
          const SizedBox(height: 12),
          _buildDetailSection(
            'Type',
            appointment.type,
            Icons.description_rounded,
          ),
          const SizedBox(height: 12),
          _buildDetailSection(
            'Adresse',
            appointment.address,
            Icons.location_on_rounded,
          ),
          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        RendezVousConstants.buttonBorderRadius,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Fermer',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onCancel();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RendezVousColors.alertRed,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        RendezVousConstants.buttonBorderRadius,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Annuler RDV',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: RendezVousColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: RendezVousColors.primaryColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: RendezVousColors.textSecondaryDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
