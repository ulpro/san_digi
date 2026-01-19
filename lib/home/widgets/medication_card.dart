import 'package:flutter/material.dart';
import '../constants.dart';
import '../../models/treatment_model.dart';

class MedicationCard extends StatelessWidget {
  final Medication medication;

  const MedicationCard({super.key, required this.medication});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color statusColor;
    Color bgColor;
    IconData statusIcon;

    switch (medication.status) {
      case 'warning':
        statusColor = AppColors.warningOrange;
        bgColor = AppColors.warningOrange.withOpacity(0.1);
        statusIcon = Icons.warning_amber_rounded;
        break;
      case 'critical':
        statusColor = AppColors.alertRed;
        bgColor = AppColors.alertRed.withOpacity(0.1);
        statusIcon = Icons.error_outline_rounded;
        break;
      default:
        statusColor = AppColors.successGreen;
        bgColor = AppColors.successGreen.withOpacity(0.1);
        statusIcon = Icons.check_circle_outline_rounded;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? Colors.white.withOpacity(0.1)
              : Colors.grey.shade100,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.medication_liquid_rounded,
                  color: statusColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            medication.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(statusIcon, color: statusColor, size: 16),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      medication.dosage,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.mediumText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: theme.brightness == Brightness.dark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            medication.type,
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        if (medication.status == 'warning')
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${medication.daysLeft} jours',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildMedicationSchedule(theme),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Comprimés restants',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${medication.remainingPills}/${medication.totalPills}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: medication.progress,
                  backgroundColor: theme.brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.grey.shade200,
                  color: medication.progress < 0.2
                      ? AppColors.warningOrange
                      : AppColors.primaryBlue,
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationSchedule(ThemeData theme) {
    final List<String> times = ['Matin', 'Midi', 'Soir'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prise aujourd\'hui',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: times.asMap().entries.map((entry) {
            final index = entry.key;
            final time = entry.value;
            return Expanded(
              child: Column(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: medication.schedule[index]
                          ? AppColors.successGreen.withOpacity(0.1)
                          : Colors.transparent,
                      border: Border.all(
                        color: medication.schedule[index]
                            ? AppColors.successGreen
                            : Colors.grey.shade300,
                        width: medication.schedule[index] ? 2 : 1,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      medication.schedule[index]
                          ? Icons.check
                          : Icons.access_time,
                      size: 16,
                      color: medication.schedule[index]
                          ? AppColors.successGreen
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
