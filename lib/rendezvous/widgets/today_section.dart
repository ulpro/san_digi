import 'package:flutter/material.dart';
import '../constants.dart';
import '../../models/appointment_model.dart';
import 'appointment_card.dart';

class TodaySection extends StatelessWidget {
  final List<Appointment> todayAppointments;
  final Function(Appointment) onShowDetails;
  final Function(Appointment) onActionPressed;
  final Function(Appointment) onShowMedicalReport;

  const TodaySection({
    super.key,
    required this.todayAppointments,
    required this.onShowDetails,
    required this.onActionPressed,
    required this.onShowMedicalReport,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (todayAppointments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aujourd\'hui',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: isDark
                ? RendezVousColors.textPrimaryLight
                : RendezVousColors.textPrimaryDark,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: RendezVousConstants.mediumPadding),
        ...todayAppointments.map(
          (apt) => AppointmentCard(
            appointment: apt,
            isToday: apt.isToday,
            onShowDetails: () => onShowDetails(apt),
            onActionPressed: () => onActionPressed(apt),
            onShowMedicalReport: () => onShowMedicalReport(apt),
          ),
        ),
      ],
    );
  }
}
