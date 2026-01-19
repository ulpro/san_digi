import 'package:flutter/material.dart';
import '../constants.dart';
import '../../models/treatment_model.dart';

import 'medication_card.dart';

class TreatmentsSection extends StatefulWidget {
  final List<Medication> medications;
  final bool needsRenewal;

  const TreatmentsSection({
    super.key,
    required this.medications,
    required this.needsRenewal,
  });

  @override
  State<TreatmentsSection> createState() => _TreatmentsSectionState();
}

class _TreatmentsSectionState extends State<TreatmentsSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'TRAITEMENTS EN COURS',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: widget.needsRenewal
                      ? AppColors.warningOrange.withOpacity(0.1)
                      : null,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.needsRenewal) ...[
                      Icon(
                        Icons.warning_amber,
                        color: AppColors.warningOrange,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          'Renouv.',
                          style: TextStyle(
                            color: AppColors.warningOrange,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Flexible(
                      child: Text(
                        '${widget.medications.length} traitements',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: theme.brightness == Brightness.dark
                ? Colors.white.withOpacity(0.05)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: theme.colorScheme.surface,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.primaryBlue,
            unselectedLabelColor: AppColors.mediumText,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            isScrollable: true,
            tabs: const [
              Tab(text: 'Aujourd\'hui'),
              Tab(text: 'Semaine'),
              Tab(text: 'Mois'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 400,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTodayTreatments(theme),
              _buildWeeklyTreatments(theme),
              _buildMonthlyTreatments(theme),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTodayTreatments(ThemeData theme) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...widget.medications
              .map((med) => MedicationCard(medication: med))
              .toList(),
          const SizedBox(height: 16),
          Center(
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add, color: AppColors.primaryBlue, size: 16),
              label: Text(
                'Ajouter un traitement',
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyTreatments(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_view_week, size: 60, color: AppColors.mediumText),
          const SizedBox(height: 16),
          Text(
            'Vue hebdomadaire',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Planification des traitements\nsur 7 jours',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyTreatments(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_month, size: 60, color: AppColors.mediumText),
          const SizedBox(height: 16),
          Text(
            'Vue mensuelle',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Suivi mensuel de l\'observance\ndes traitements',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
