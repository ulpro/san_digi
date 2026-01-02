import 'package:flutter/material.dart';

// ==============================================
// HOME SCREEN
// ==============================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final int _selectedIndex = 0;
  late TabController _tabController;
  bool _isCardPressed = false;

  final List<Map<String, dynamic>> medications = [
    {
      'name': 'Metformine',
      'dosage': '500mg, 2 fois par jour',
      'status': 'warning',
      'daysLeft': 7,
      'lastTaken': 'Aujourd\'hui, 08:30',
      'type': 'Comprimé',
      'schedule': [true, false, true], // Matin, Midi, Soir
      'remainingPills': 15,
      'totalPills': 60,
    },
    {
      'name': 'Lisinopril',
      'dosage': '10mg, 1 fois par jour',
      'status': 'normal',
      'daysLeft': 30,
      'lastTaken': 'Aujourd\'hui, 09:00',
      'type': 'Comprimé',
      'schedule': [true, false, false],
      'remainingPills': 45,
      'totalPills': 90,
    },
    {
      'name': 'Atorvastatine',
      'dosage': '20mg, 1 fois par jour',
      'status': 'normal',
      'daysLeft': 45,
      'lastTaken': 'Hier, 20:00',
      'type': 'Comprimé',
      'schedule': [false, false, true],
      'remainingPills': 30,
      'totalPills': 90,
    },
  ];

  final List<Map<String, dynamic>> prescriptions = [
    {
      'title': 'Ordonnance cardiologie',
      'doctor': 'Dr. Martin',
      'date': '05/06/2024',
      'status': 'active',
      'remainingRefills': 2,
      'expiryDate': '05/09/2024',
    },
    {
      'title': 'Ordonnance diabétologie',
      'doctor': 'Dr. Dubois',
      'date': '12/03/2024',
      'status': 'expiring',
      'remainingRefills': 0,
      'expiryDate': '12/06/2024',
    },
    {
      'title': 'Ordonnance généraliste',
      'doctor': 'Dr. Leroy',
      'date': '20/05/2024',
      'status': 'active',
      'remainingRefills': 1,
      'expiryDate': '20/08/2024',
    },
  ];

  final Map<String, dynamic> nextAppointment = {
    'doctor': 'Dr. Sophie Martin',
    'specialty': 'Cardiologue',
    'date': 'Lun 15 Juin 2024',
    'time': '10:00 - 10:30',
    'address': '123 Rue de la Santé, 75015 Paris',
    'type': 'Consultation de suivi',
    'isConfirmed': true,
    'duration': '30 min',
  };

  final List<Map<String, dynamic>> healthIndicators = [
    {
      'type': 'Glycémie',
      'value': '1.2',
      'unit': 'g/L',
      'date': '01/06/2024',
      'trend': 'down',
      'status': 'normal',
      'icon': Icons.water_drop,
    },
    {
      'type': 'Tension',
      'value': '12/8',
      'unit': '',
      'date': '28/05/2024',
      'trend': 'stable',
      'status': 'good',
      'icon': Icons.monitor_heart,
    },
    {
      'type': 'Poids',
      'value': '72',
      'unit': 'kg',
      'date': '15/05/2024',
      'trend': 'stable',
      'status': 'normal',
      'icon': Icons.monitor_weight,
    },
    {
      'type': 'Cholestérol',
      'value': '1.8',
      'unit': 'g/L',
      'date': '15/05/2024',
      'trend': 'up',
      'status': 'warning',
      'icon': Icons.bloodtype,
    },
  ];

  // Déclaration des constantes de couleurs dans home.dart
  static const Color primaryBlue = Color(0xFF2A7DE1);
  static const Color healthGreen = Color(0xFF4CD964);
  static const Color warningOrange = Color(0xFFFF9500);
  static const Color alertRed = Color(0xFFFF3B30);
  static const Color successGreen = Color(0xFF34C759);
  static const Color mediumText = Color(0xFF5D6D7E);
  static const Color lightText = Color(0xFF95A5A6);
  static const Color purpleHealth = Color(0xFF9C27B0);
  static const Color tealHealth = Color(0xFF009688);
  static const Color gradientStart = Color(0xFF2A7DE1);
  static const Color gradientEnd = Color(0xFF5AA9FF);

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
    final screenWidth = MediaQuery.of(context).size.width;
    final needsRenewal = medications.any((m) => m['status'] == 'warning');

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(screenWidth > 600 ? 24 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome section
              _buildWelcomeSection(theme, screenWidth),
              SizedBox(height: 24),

              // Stats Cards - Corrigé pour éviter l'overflow
              _buildStatsRow(theme, screenWidth),
              SizedBox(height: 24),

              // Health Indicators
              _buildHealthIndicators(theme, screenWidth),
              SizedBox(height: 24),

              // Next appointment with animation
              _buildAnimatedAppointmentCard(theme),
              SizedBox(height: 24),

              // Current treatments with tabs
              _buildTreatmentsSectionWithTabs(theme),
              SizedBox(height: 24),

              // Active prescriptions
              _buildPrescriptionsSection(theme),
              SizedBox(height: 24),

              // Recent activities
              _buildRecentActivities(theme),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildEnhancedFAB(),
    );
  }

  // ==============================================
  // WIDGETS
  // ==============================================

  Widget _buildWelcomeSection(ThemeData theme, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [gradientStart, gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryBlue.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 30),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bonjour,',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Jean Dupont',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: successGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: successGreen.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: successGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profil à jour',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: successGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Dernière consultation : 01/06/2024',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: successGreen.withOpacity(0.9),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(ThemeData theme, double screenWidth) {
    if (screenWidth < 400) {
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _buildStatCard(
            icon: Icons.medication,
            value: medications.length.toString(),
            label: 'Traitements actifs',
            color: primaryBlue,
            progress: medications.length / 10.0,
            theme: theme,
            isCompact: true,
          ),
          _buildStatCard(
            icon: Icons.calendar_today,
            value: '1',
            label: 'RDV à venir',
            color: healthGreen,
            progress: 0.3,
            theme: theme,
            isCompact: true,
          ),
          _buildStatCard(
            icon: Icons.description,
            value: prescriptions.length.toString(),
            label: 'Prescriptions',
            color: warningOrange,
            progress: prescriptions.length / 5.0,
            theme: theme,
            isCompact: true,
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.medication,
            value: medications.length.toString(),
            label: 'Traitements actifs',
            color: primaryBlue,
            progress: medications.length / 10.0,
            theme: theme,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.calendar_today,
            value: '1',
            label: 'RDV à venir',
            color: healthGreen,
            progress: 0.3,
            theme: theme,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.description,
            value: prescriptions.length.toString(),
            label: 'Prescriptions',
            color: warningOrange,
            progress: prescriptions.length / 5.0,
            theme: theme,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    required double progress,
    required ThemeData theme,
    bool isCompact = false,
  }) {
    return Container(
      padding: isCompact ? const EdgeInsets.all(12) : const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
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
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: isCompact ? 16 : 20),
              ),
              const Spacer(),
              SizedBox(
                width: isCompact ? 32 : 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: color.withOpacity(0.1),
                    color: color,
                    minHeight: 6,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isCompact ? 8 : 12),
          Text(
            value,
            style: TextStyle(
              fontSize: isCompact ? 20 : 24,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
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

  Widget _buildHealthIndicators(ThemeData theme, double screenWidth) {
    final indicatorWidth = screenWidth > 600
        ? 160.0
        : screenWidth > 400
        ? 140.0
        : (screenWidth - 60) / 2;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
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
                icon: Icon(Icons.bar_chart_rounded, color: primaryBlue),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: healthIndicators
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
    Map<String, dynamic> indicator,
    ThemeData theme,
    double width,
  ) {
    Color getTrendColor(String trend) {
      switch (trend) {
        case 'down':
          return successGreen;
        case 'up':
          return alertRed;
        default:
          return warningOrange;
      }
    }

    Color getStatusColor(String status) {
      switch (status) {
        case 'good':
          return successGreen;
        case 'warning':
          return warningOrange;
        default:
          return primaryBlue;
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
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: getStatusColor(indicator['status']).withOpacity(0.1),
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
                  color: getStatusColor(indicator['status']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  indicator['icon'],
                  color: getStatusColor(indicator['status']),
                  size: 16,
                ),
              ),
              const Spacer(),
              Icon(
                getTrendIcon(indicator['trend']),
                size: 16,
                color: getTrendColor(indicator['trend']),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            indicator['type'],
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: Text(
                  indicator['value'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 2),
              Text(indicator['unit'], style: theme.textTheme.bodySmall),
            ],
          ),
          SizedBox(height: 4),
          Text(
            '${indicator['date']}',
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedAppointmentCard(ThemeData theme) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isCardPressed = true),
      onTapCancel: () => setState(() => _isCardPressed = false),
      onTapUp: (_) => setState(() => _isCardPressed = false),
      child: AnimatedScale(
        scale: _isCardPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [gradientStart, gradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: primaryBlue.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'PROCHAIN RENDEZ-VOUS',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 12,
                            ),
                            SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                'Confirmé',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
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
                SizedBox(height: 16),
                Text(
                  nextAppointment['doctor'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  nextAppointment['specialty'],
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20),
                _buildAppointmentDetail(
                  Icons.calendar_today,
                  nextAppointment['date'],
                ),
                SizedBox(height: 12),
                _buildAppointmentDetail(
                  Icons.access_time,
                  '${nextAppointment['time']} (${nextAppointment['duration']})',
                ),
                SizedBox(height: 12),
                _buildAppointmentDetail(
                  Icons.location_on,
                  nextAppointment['address'],
                ),
                SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 350) {
                      return Column(
                        children: [
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Détails',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Me rappeler',
                                style: TextStyle(
                                  color: primaryBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Détails',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Me rappeler',
                                style: TextStyle(
                                  color: primaryBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTreatmentsSectionWithTabs(ThemeData theme) {
    final needsRenewal = medications.any((m) => m['status'] == 'warning');

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
                  color: needsRenewal ? warningOrange.withOpacity(0.1) : null,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (needsRenewal) ...[
                      Icon(Icons.warning_amber, color: warningOrange, size: 14),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          'Renouv.',
                          style: TextStyle(
                            color: warningOrange,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                    Flexible(
                      child: Text(
                        '${medications.length} traitements',
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
        SizedBox(height: 16),
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
            labelColor: primaryBlue,
            unselectedLabelColor: mediumText,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            isScrollable: true,
            tabs: const [
              Tab(text: 'Aujourd\'hui'),
              Tab(text: 'Semaine'),
              Tab(text: 'Mois'),
            ],
          ),
        ),
        SizedBox(height: 16),
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
          ...medications.map((med) => _buildEnhancedMedicationCard(med, theme)),
          SizedBox(height: 16),
          Center(
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add, color: primaryBlue, size: 16),
              label: Text(
                'Ajouter un traitement',
                style: TextStyle(
                  color: primaryBlue,
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
          Icon(Icons.calendar_view_week, size: 60, color: mediumText),
          SizedBox(height: 16),
          Text(
            'Vue hebdomadaire',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
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
          Icon(Icons.calendar_month, size: 60, color: mediumText),
          SizedBox(height: 16),
          Text(
            'Vue mensuelle',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Suivi mensuel de l\'observance\ndes traitements',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedMedicationCard(
    Map<String, dynamic> med,
    ThemeData theme,
  ) {
    Color statusColor;
    Color bgColor;
    IconData statusIcon;

    switch (med['status']) {
      case 'warning':
        statusColor = warningOrange;
        bgColor = warningOrange.withOpacity(0.1);
        statusIcon = Icons.warning_amber_rounded;
        break;
      case 'critical':
        statusColor = alertRed;
        bgColor = alertRed.withOpacity(0.1);
        statusIcon = Icons.error_outline_rounded;
        break;
      default:
        statusColor = successGreen;
        bgColor = successGreen.withOpacity(0.1);
        statusIcon = Icons.check_circle_outline_rounded;
    }

    final progress = med['remainingPills'] / med['totalPills'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
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
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            med['name'],
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(statusIcon, color: statusColor, size: 16),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      med['dosage'],
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: mediumText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
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
                            med['type'],
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        if (med['status'] == 'warning')
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
                              '${med['daysLeft']} jours',
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
          SizedBox(height: 16),
          _buildMedicationSchedule(med, theme),
          SizedBox(height: 12),
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
                    '${med['remainingPills']}/${med['totalPills']}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: theme.brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.grey.shade200,
                  color: progress < 0.2 ? warningOrange : primaryBlue,
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationSchedule(Map<String, dynamic> med, ThemeData theme) {
    final List<String> times = ['Matin', 'Midi', 'Soir'];
    final List<bool> schedule = List<bool>.from(med['schedule']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prise aujourd\'hui',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
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
                      color: schedule[index]
                          ? successGreen.withOpacity(0.1)
                          : Colors.transparent,
                      border: Border.all(
                        color: schedule[index]
                            ? successGreen
                            : Colors.grey.shade300,
                        width: schedule[index] ? 2 : 1,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      schedule[index] ? Icons.check : Icons.access_time,
                      size: 16,
                      color: schedule[index] ? successGreen : Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),
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

  Widget _buildPrescriptionsSection(ThemeData theme) {
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
                  '${prescriptions.length} prescriptions',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        ...prescriptions.map(
          (pres) => _buildEnhancedPrescriptionCard(pres, theme),
        ),
      ],
    );
  }

  Widget _buildEnhancedPrescriptionCard(
    Map<String, dynamic> pres,
    ThemeData theme,
  ) {
    final isExpiring = pres['status'] == 'expiring';
    final daysUntilExpiry = _calculateDaysUntilExpiry(pres['expiryDate']);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
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
                  color: primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.description_rounded,
                  color: primaryBlue,
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            pres['title'],
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isExpiring)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: warningOrange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '$daysUntilExpiry j',
                              style: TextStyle(
                                color: warningOrange,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      pres['doctor'],
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: mediumText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 12,
                              color: lightText,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Émise le ${pres['date']}',
                              style: theme.textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.repeat, size: 12, color: lightText),
                            SizedBox(width: 4),
                            Text(
                              '${pres['remainingRefills']} renouv.',
                              style: theme.textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isExpiring) ...[
            SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: warningOrange.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: warningOrange.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, color: warningOrange, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Expire le ${pres['expiryDate']}. Pensez à renouveler.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: warningOrange,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      minimumSize: Size.zero,
                    ),
                    child: Text(
                      'Renouveler',
                      style: TextStyle(
                        color: warningOrange,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRecentActivities(ThemeData theme) {
    final List<Map<String, dynamic>> activities = [
      {
        'type': 'Prise médicament',
        'description': 'Metformine pris',
        'time': '08:30',
        'icon': Icons.medication,
        'color': successGreen,
      },
      {
        'type': 'Rappel',
        'description': 'Rendez-vous confirmé',
        'time': 'Hier, 15:20',
        'icon': Icons.notifications,
        'color': primaryBlue,
      },
      {
        'type': 'Consultation',
        'description': 'Visite chez le cardiologue',
        'time': '01/06/2024',
        'icon': Icons.medical_services,
        'color': purpleHealth,
      },
      {
        'type': 'Prescription',
        'description': 'Nouvelle ordonnance',
        'time': '28/05/2024',
        'icon': Icons.description,
        'color': tealHealth,
      },
    ];

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
        SizedBox(height: 12),
        ...activities.map((activity) => _buildActivityItem(activity, theme)),
      ],
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: activity['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(activity['icon'], color: activity['color'], size: 18),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['type'],
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  activity['description'],
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            activity['time'],
            style: theme.textTheme.bodySmall?.copyWith(color: lightText),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white70),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedFAB() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [gradientStart, gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: PopupMenuButton<String>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          offset: const Offset(0, -120),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'treatment',
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: healthGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.medication, color: healthGreen, size: 18),
                  ),
                  SizedBox(width: 12),
                  const Text('Ajouter traitement'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'appointment',
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: warningOrange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.calendar_today,
                      color: warningOrange,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 12),
                  const Text('Nouveau RDV'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'prescription',
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.description,
                      color: primaryBlue,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 12),
                  const Text('Nouvelle ordonnance'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'measurement',
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: purpleHealth.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.monitor_heart,
                      color: purpleHealth,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 12),
                  const Text('Nouvelle mesure'),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Ajout: $value'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }

  int _calculateDaysUntilExpiry(String expiryDate) {
    return 30;
  }
}
