import 'package:flutter/material.dart';
import '../constants.dart';
import '../../models/prescription_model.dart';
import 'stat_card.dart';

class HeaderStats extends StatelessWidget {
  final PrescriptionStats stats;

  const HeaderStats({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(PrescriptionConstants.mediumPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(
          PrescriptionConstants.cardBorderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: StatCard(
              label: 'Active',
              value: stats.activeCount.toString(),
              color: theme.colorScheme.secondary,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: theme.dividerColor.withOpacity(0.3),
          ),
          Expanded(
            child: StatCard(
              label: 'À renouveler',
              value: stats.expiringCount.toString(),
              color: PrescriptionColors.pendingColor,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: theme.dividerColor.withOpacity(0.3),
          ),
          Expanded(
            child: StatCard(
              label: 'Total',
              value: stats.totalCount.toString(),
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
