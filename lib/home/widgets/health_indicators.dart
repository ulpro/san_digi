import 'package:flutter/material.dart';
import '../constants.dart';
import '../models.dart';

class HealthIndicators extends StatelessWidget {
  final List<HealthIndicator> indicators;
  final double screenWidth;

  const HealthIndicators({
    super.key,
    required this.indicators,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indicatorWidth = screenWidth > 600
        ? 160.0
        : screenWidth > 400
            ? 140.0
            : (screenWidth - 60) / 2;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'INDICATEURS DE SANTÉ',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.bar_chart_rounded,
                    color: AppColors.primaryBlue),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: indicators
                .map(
                  (indicator) =>
                      _buildHealthIndicator(indicator, theme, indicatorWidth),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthIndicator(
    HealthIndicator indicator,
    ThemeData theme,
    double width,
  ) {
    Color getTrendColor(String trend) {
      switch (trend) {
        case 'down':
          return AppColors.successGreen;
        case 'up':
          return AppColors.alertRed;
        default:
          return AppColors.warningOrange;
      }
    }

    Color getStatusColor(String status) {
      switch (status) {
        case 'good':
          return AppColors.successGreen;
        case 'warning':
          return AppColors.warningOrange;
        default:
          return AppColors.primaryBlue;
      }
    }

    IconData getTrendIcon(String trend) {
      switch (trend) {
        case 'down':
          return Icons.trending_down;
        case 'up':
          return Icons.trending_up;
        default:
          return Icons.trending_flat;
      }
    }

    return Container(
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? Colors.white.withOpacity(0.05)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(AppConstants.smallCardBorderRadius),
        border: Border.all(
          color: getStatusColor(indicator.status).withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color:
                      getStatusColor(indicator.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  indicator.icon,
                  color: getStatusColor(indicator.status),
                  size: 16,
                ),
              ),
              const Spacer(),
              Icon(
                getTrendIcon(indicator.trend),
                size: 16,
                color: getTrendColor(indicator.trend),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            indicator.type,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: Text(
                  indicator.value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 2),
              Text(indicator.unit, style: theme.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${indicator.date}',
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}