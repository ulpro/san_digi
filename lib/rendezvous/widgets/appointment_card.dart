import 'package:flutter/material.dart';
import '../constants.dart';
import '../models.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final bool isToday;
  final VoidCallback onShowDetails;
  final VoidCallback onActionPressed;
  final VoidCallback onShowMedicalReport;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.isToday,
    required this.onShowDetails,
    required this.onActionPressed,
    required this.onShowMedicalReport,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: RendezVousConstants.smallPadding),
      decoration: BoxDecoration(
        color: isDark 
            ? RendezVousColors.cardDark 
            : Colors.white,
        borderRadius: BorderRadius.circular(RendezVousConstants.cardBorderRadius),
        border: Border.all(
          color: isDark 
              ? RendezVousColors.borderDark.withOpacity(0.3)
              : RendezVousColors.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(RendezVousConstants.mediumPadding),
        child: Column(
          children: [
            // En-tête avec statut
            _buildHeader(isDark),
            const SizedBox(height: RendezVousConstants.mediumPadding),

            // Informations du rendez-vous
            _buildAppointmentInfo(isDark),
            const SizedBox(height: RendezVousConstants.mediumPadding),

            // Actions
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: RendezVousConstants.smallPadding,
            vertical: RendezVousConstants.extraSmallPadding,
          ),
          decoration: BoxDecoration(
            color: appointment.statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(RendezVousConstants.smallCardBorderRadius),
          ),
          child: Row(
            children: [
              Icon(appointment.statusIcon, 
                  color: appointment.statusColor, 
                  size: 14),
              const SizedBox(width: 6),
              Text(
                appointment.statusText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: appointment.statusColor,
                ),
              ),
            ],
          ),
        ),
        if (isToday)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: RendezVousConstants.smallPadding,
              vertical: RendezVousConstants.extraSmallPadding,
            ),
            decoration: BoxDecoration(
              color: RendezVousColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(RendezVousConstants.smallCardBorderRadius),
            ),
            child: Text(
              'AUJOURD\'HUI',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: RendezVousColors.primaryColor,
                letterSpacing: 0.5,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAppointmentInfo(bool isDark) {
    return Row(
      children: [
        // Icône
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: RendezVousColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(RendezVousConstants.smallCardBorderRadius),
          ),
          child: Icon(
            Icons.local_hospital_rounded,
            color: RendezVousColors.primaryColor,
            size: RendezVousConstants.iconSize,
          ),
        ),
        const SizedBox(width: RendezVousConstants.mediumPadding),
        
        // Détails
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appointment.doctor,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark 
                      ? RendezVousColors.textPrimaryLight 
                      : RendezVousColors.textPrimaryDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                appointment.specialty,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark 
                      ? RendezVousColors.textSecondaryLight 
                      : RendezVousColors.textSecondaryDark,
                ),
              ),
              const SizedBox(height: RendezVousConstants.extraSmallPadding),
              
              // Date et heure
              _buildDetailRow(
                Icons.calendar_today_rounded,
                '${appointment.date} • ${appointment.time}',
                isDark,
              ),
              const SizedBox(height: 6),
              
              // Type et durée
              _buildDetailRow(
                Icons.access_time_rounded,
                '${appointment.type} • ${appointment.duration}',
                isDark,
              ),
              const SizedBox(height: 6),
              
              // Adresse
              _buildDetailRow(
                Icons.location_on_rounded,
                appointment.address,
                isDark,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String text, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: isDark 
              ? RendezVousColors.textSecondaryLight 
              : RendezVousColors.textSecondaryDark,
        ),
        const SizedBox(width: RendezVousConstants.extraSmallPadding),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isDark 
                  ? RendezVousColors.textSecondaryLight 
                  : RendezVousColors.textSecondaryDark,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    if (appointment.canShowActions) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onShowDetails,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: BorderSide(
                  color: RendezVousColors.primaryColor.withOpacity(0.3),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      RendezVousConstants.buttonBorderRadius),
                ),
              ),
              icon: const Icon(
                Icons.info_outline_rounded,
                size: 18,
              ),
              label: const Text(
                'Détails',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: RendezVousConstants.smallPadding),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onActionPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: RendezVousColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      RendezVousConstants.buttonBorderRadius),
                ),
              ),
              icon: Icon(
                appointment.isConfirmed 
                    ? Icons.calendar_today_rounded 
                    : Icons.check_rounded,
                size: 18,
              ),
              label: Text(
                appointment.isConfirmed ? 'Me rappeler' : 'Confirmer',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      );
    } else if (appointment.isCompleted) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onShowMedicalReport,
          style: ElevatedButton.styleFrom(
            backgroundColor: RendezVousColors.healthGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  RendezVousConstants.buttonBorderRadius),
            ),
          ),
          icon: const Icon(Icons.description_rounded, size: 18),
          label: const Text(
            'Voir le compte-rendu',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
    
    return const SizedBox.shrink();
  }
}