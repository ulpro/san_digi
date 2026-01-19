import 'package:flutter/material.dart';
import '../../prescription/constants.dart';
import '../../models/prescription_model.dart';

class HeaderCard extends StatelessWidget {
  final Prescription prescription;
  final bool isDark;

  const HeaderCard({
    super.key,
    required this.prescription,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final status = prescription.status;
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case 'active':
        statusColor = PrescriptionColors.activeColor;
        statusText = 'Active';
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'completed':
        statusColor = PrescriptionColors.completedColor;
        statusText = 'Terminée';
        statusIcon = Icons.done_all_rounded;
        break;
      case 'expiring':
        statusColor = PrescriptionColors.pendingColor;
        statusText = 'À renouveler';
        statusIcon = Icons.warning_amber_rounded;
        break;
      default:
        statusColor = PrescriptionColors.primaryColor;
        statusText = 'En cours';
        statusIcon = Icons.access_time_rounded;
    }

    return Container(
      padding: const EdgeInsets.all(PrescriptionConstants.headerCardPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: isDark
              ? [PrescriptionColors.cardDark, const Color(0xFF252F44)]
              : [Colors.white, const Color(0xFFF0F7FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isDark
              ? PrescriptionColors.borderDark.withOpacity(0.3)
              : PrescriptionColors.dividerLight,
        ),
      ),
      child: Column(
        children: [
          // Titre et statut
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  prescription.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: isDark
                        ? PrescriptionColors.textPrimaryLight
                        : PrescriptionColors.textPrimaryDark,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(statusIcon, color: statusColor, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Divider
          Divider(
            color: isDark
                ? PrescriptionColors.borderDark.withOpacity(0.5)
                : PrescriptionColors.dividerLight,
            height: 1,
          ),
          const SizedBox(height: 16),

          // Infos du médecin
          _buildInfoRow(
            icon: Icons.person_rounded,
            label: 'Prescrit par',
            value: prescription.doctorFullName,
            isDark: isDark,
          ),
          const SizedBox(height: 12),

          // Date de prescription
          _buildInfoRow(
            icon: Icons.calendar_month_rounded,
            label: 'Date de prescription',
            value: prescription.date,
            isDark: isDark,
          ),
          const SizedBox(height: 12),

          // Établissement
          _buildInfoRow(
            icon: Icons.local_hospital_rounded,
            label: 'Établissement',
            value: prescription.hospital,
            isDark: isDark,
          ),

          // Date d'expiration
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.timelapse_rounded,
            label: 'Expire le',
            value: prescription.expiryDate,
            isDark: isDark,
            isWarning: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
    bool isWarning = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isWarning
                ? PrescriptionColors.warningColor.withOpacity(0.1)
                : PrescriptionColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: isWarning
                ? PrescriptionColors.warningColor
                : PrescriptionColors.primaryColor,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark
                      ? PrescriptionColors.textSecondaryLight
                      : PrescriptionColors.textSecondaryDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isWarning
                      ? PrescriptionColors.warningColor
                      : (isDark
                            ? PrescriptionColors.textPrimaryLight
                            : const Color(0xFF1F2937)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
