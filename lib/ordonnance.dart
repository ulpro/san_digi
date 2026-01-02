import 'package:flutter/material.dart';
import 'screens/prescription_detail_screen.dart';

// ==============================================
// PAGE DES ORDONNANCES
// ==============================================

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  final List<Map<String, dynamic>> _prescriptions = [
    {
      'id': '1',
      'title': 'Ordonnance cardiologie',
      'doctor': 'Dr. Martin',
      'date': '24 Mai 2024',
      'status': 'active',
      'medications': ['Paracetamol 1000mg', 'Ibuprofène 400mg', '...'],
      'remainingRefills': 2,
      'expiryDate': '24 Août 2024',
      'doctorFullName': 'Dr. Jean Dupont',
      'hospital': 'Hôpital Central',
      'medicationDetails': [
        {
          'name': 'Amoxicilline',
          'dosage': '500mg',
          'frequency': '2 fois/jour',
          'duration': 'pendant 7 jours',
        },
        {
          'name': 'Paracétamol',
          'dosage': '1g',
          'frequency': '3 fois/jour si douleur',
          'duration': 'pendant 5 jours',
        },
      ],
      'instructions':
          'À prendre pendant les repas. Éviter l\'exposition au soleil pendant le traitement à l\'Amoxicilline.',
    },
    {
      'id': '2',
      'title': 'Ordonnance généraliste',
      'doctor': 'Dr. Dupont',
      'date': '15 Avril 2024',
      'status': 'completed',
      'medications': ['Amoxicilline 500mg'],
      'remainingRefills': 0,
      'expiryDate': '15 Juillet 2024',
      'doctorFullName': 'Dr. Sophie Martin',
      'hospital': 'Clinique Saint-Louis',
      'medicationDetails': [
        {
          'name': 'Amoxicilline',
          'dosage': '500mg',
          'frequency': '2 fois/jour',
          'duration': 'pendant 7 jours',
        },
      ],
      'instructions': 'À prendre pendant les repas.',
    },
    {
      'id': '3',
      'title': 'Ordonnance renouvellement',
      'doctor': 'Dr. Durand',
      'date': '02 Février 2024',
      'status': 'pending',
      'medications': ['Demande de renouvellement'],
      'remainingRefills': 1,
      'expiryDate': '02 Mai 2024',
      'doctorFullName': 'Dr. Pierre Durand',
      'hospital': 'Centre Médical',
      'medicationDetails': [
        {
          'name': 'Métoprolol',
          'dosage': '50mg',
          'frequency': '1 fois/jour',
          'duration': 'pendant 30 jours',
        },
      ],
      'instructions': 'Prendre le matin.',
    },
    {
      'id': '4',
      'title': 'Ordonnance spécialisée',
      'doctor': 'Dr. Lefebvre',
      'date': '10 Juin 2024',
      'status': 'expiring',
      'medications': ['Métoprolol 50mg', 'Aspirine 100mg'],
      'remainingRefills': 0,
      'expiryDate': '10 Juillet 2024',
      'doctorFullName': 'Dr. Marie Lefebvre',
      'hospital': 'Hôpital Universitaire',
      'medicationDetails': [
        {
          'name': 'Métoprolol',
          'dosage': '50mg',
          'frequency': '1 fois/jour',
          'duration': 'pendant 30 jours',
        },
        {
          'name': 'Aspirine',
          'dosage': '100mg',
          'frequency': '1 fois/jour',
          'duration': 'pendant 30 jours',
        },
      ],
      'instructions': 'Contrôler la tension artérielle régulièrement.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = theme.brightness == Brightness.dark;
    final hasPrescriptions = _prescriptions.isNotEmpty;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth > 600 ? 20 : 16),
          child: Column(
            children: [
              // En-tête avec statistiques
              _buildHeaderStats(theme, screenWidth),
              SizedBox(height: 20),

              // Liste des ordonnances
              Expanded(
                child: hasPrescriptions
                    ? ListView.builder(
                        itemCount: _prescriptions.length,
                        itemBuilder: (context, index) {
                          return _buildPrescriptionCard(
                            _prescriptions[index],
                            theme,
                            isDark,
                          );
                        },
                      )
                    : _buildEmptyState(theme, isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderStats(ThemeData theme, double screenWidth) {
    final activeCount = _prescriptions
        .where((p) => p['status'] == 'active')
        .length;
    final expiringCount = _prescriptions
        .where((p) => p['status'] == 'expiring')
        .length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
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
            child: _buildStatItem(
              'Active',
              activeCount.toString(),
              theme.colorScheme.secondary,
              theme,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: theme.dividerColor.withOpacity(0.3),
          ),
          Expanded(
            child: _buildStatItem(
              'À renouveler',
              expiringCount.toString(),
              const Color(0xFFFF9500),
              theme,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: theme.dividerColor.withOpacity(0.3),
          ),
          Expanded(
            child: _buildStatItem(
              'Total',
              _prescriptions.length.toString(),
              theme.colorScheme.primary,
              theme,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    Color color,
    ThemeData theme,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionCard(
    Map<String, dynamic> prescription,
    ThemeData theme,
    bool isDark,
  ) {
    final status = prescription['status'];
    Color statusColor;
    IconData statusIcon;
    String statusText;

    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;

    switch (status) {
      case 'active':
        statusColor = secondaryColor;
        statusIcon = Icons.bolt;
        statusText = 'Active';
        break;
      case 'completed':
        statusColor = theme.colorScheme.onSurface.withOpacity(0.5);
        statusIcon = Icons.check_circle;
        statusText = 'Terminée';
        break;
      case 'pending':
        statusColor = const Color(0xFFFF9500);
        statusIcon = Icons.hourglass_empty;
        statusText = 'En attente';
        break;
      case 'expiring':
        statusColor = const Color(0xFFFF3B30);
        statusIcon = Icons.warning;
        statusText = 'À renouveler';
        break;
      default:
        statusColor = primaryColor;
        statusIcon = Icons.description;
        statusText = 'Inconnu';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(statusIcon, color: statusColor, size: 20),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Ordonnance du ${prescription['date']}',
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints(minWidth: 60),
                  child: TextButton(
                    onPressed: () => _showPrescriptionDetails(prescription),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: Size.zero,
                    ),
                    child: Text(
                      'Voir',
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Divider(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.grey.shade200,
              height: 1,
            ),
            SizedBox(height: 12),
            Text(
              '${prescription['title']}',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              'Prescrit par ${prescription['doctor']}',
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              'Médicaments : ${prescription['medications'].join(', ')}',
              style: TextStyle(
                fontSize: 13,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 6,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.repeat,
                      size: 14,
                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${prescription['remainingRefills']} renouv.',
                      style: TextStyle(
                        fontSize: 11,
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                    ),
                    SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        'Expire le ${prescription['expiryDate']}',
                        style: TextStyle(
                          fontSize: 11,
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme, bool isDark) {
    final primaryColor = theme.colorScheme.primary;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.folder_off,
                size: 64,
                color: theme.colorScheme.onSurface.withOpacity(0.4),
              ),
              SizedBox(height: 16),
              Text(
                'Aucune ordonnance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Vos ordonnances médicales apparaîtront\nici dès qu\'elles seront disponibles.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Ajout d\'ordonnance - Fonctionnalité à venir',
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Ajouter une ordonnance'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPrescriptionDetails(Map<String, dynamic> prescription) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PrescriptionDetailScreen(prescription: prescription),
      ),
    );
  }

  void _showFilterDialog() {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Filtrer les ordonnances',
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: theme.colorScheme.surface,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFilterOption('Toutes', true, primaryColor),
              _buildFilterOption('Actives seulement', false, primaryColor),
              _buildFilterOption('À renouveler', false, primaryColor),
              _buildFilterOption('Terminées', false, primaryColor),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Annuler',
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Filtre appliqué'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Appliquer'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterOption(String label, bool selected, Color primaryColor) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: selected ? primaryColor : null,
        size: 20,
      ),
      title: Text(
        label,
        style: TextStyle(fontSize: 14, color: selected ? primaryColor : null),
      ),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Filtre "$label" sélectionné'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }
}
