import 'package:flutter/material.dart';
import '../constants.dart';
import '../models.dart';

class StatsCards extends StatelessWidget {
  final List<StatCard> stats;
  final double screenWidth;

  const StatsCards({
    super.key,
    required this.stats,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (screenWidth < 400) {
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: stats
            .map((stat) => _buildStatCard(stat, theme, isCompact: true))
            .toList(),
      );
    }

    return Row(
      children: stats.map((stat) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                right: stat == stats.last ? 0 : 12),
            child: _buildStatCard(stat, theme),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatCard(StatCard stat, ThemeData theme,
      {bool isCompact = false}) {
    return Container(
      padding: isCompact
          ? const EdgeInsets.all(12)
          : const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: isCompact ? 32 : 40,
                height: isCompact ? 32 : 40,
                decoration: BoxDecoration(
                  color: stat.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(stat.icon,
                    color: stat.color, size: isCompact ? 16 : 20),
              ),
              const Spacer(),
              SizedBox(
                width: isCompact ? 32 : 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: stat.progress,
                    backgroundColor: stat.color.withOpacity(0.1),
                    color: stat.color,
                    minHeight: 6,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isCompact ? 8 : 12),
          Text(
            stat.value,
            style: TextStyle(
              fontSize: isCompact ? 20 : 24,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 4),
          Text(
            stat.label,
            style: TextStyle(
              fontSize: isCompact ? 10 : 11,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}