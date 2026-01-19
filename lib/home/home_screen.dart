import 'package:flutter/material.dart';

import 'data.dart';
import 'constants.dart';
import 'widgets/welcome_section.dart';
import 'widgets/stats_cards.dart';
import 'widgets/health_indicators.dart';
import 'widgets/appointment_card.dart';
import 'widgets/treatments_section.dart';
import 'widgets/prescription_card.dart';
import 'widgets/activity_item.dart';
import 'widgets/fab_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(screenWidth > 600 ? 24 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome section
              const WelcomeSection(),
              const SizedBox(height: 24),

              // Stats Cards
              StatsCards(
                stats: HomeData.getStatsCards(),
                screenWidth: screenWidth,
              ),
              const SizedBox(height: 24),

              // Health Indicators
              HealthIndicators(
                indicators: HomeData.healthIndicators,
                screenWidth: screenWidth,
              ),
              const SizedBox(height: 24),

              // Next appointment
              AppointmentCard(appointment: HomeData.nextAppointment),
              const SizedBox(height: 24),

              // Current treatments with tabs
              TreatmentsSection(
                medications: HomeData.medications,
                needsRenewal: HomeData.needsRenewal,
              ),
              const SizedBox(height: 24),

              // Active prescriptions
              _buildPrescriptionsSection(context),
              const SizedBox(height: 24),

              // Recent activities
              _buildRecentActivities(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: const FabMenu(),
    );
  }

  Widget _buildPrescriptionsSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'PRESCRIPTIONS ACTIVES',
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
                  color: theme.brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${HomeData.prescriptions.length} prescriptions',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...HomeData.prescriptions
            .map((pres) => PrescriptionCard(prescription: pres))
            .toList(),
      ],
    );
  }

  Widget _buildRecentActivities(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'ACTIVITÉS RÉCENTES',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Voir tout', style: theme.textTheme.labelLarge),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...HomeData.activities
            .map((activity) => ActivityItem(activity: activity))
            .toList(),
      ],
    );
  }
}
