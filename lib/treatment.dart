import 'package:flutter/material.dart';

// ==============================================
// ÉCRAN DES TRAITEMENTS (MÉDICAMENTS)
// ==============================================

class TreatmentScreen extends StatefulWidget {
  const TreatmentScreen({super.key});

  @override
  State<TreatmentScreen> createState() => _TreatmentScreenState();
}

class _TreatmentScreenState extends State<TreatmentScreen> {
  // Couleurs utilisées dans l'écran
  static const Color primaryColor = Color(0xFF005A9C);
  static const Color successColor = Color(0xFF28A745);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color dangerColor = Color(0xFFDC3545);
  static const Color backgroundColorLight = Color(0xFFFFFFFF);
  static const Color backgroundColorDark = Color(0xFF111521);

  // Liste des prises à venir
  final List<Map<String, dynamic>> upcomingDoses = [
    {
      'id': '1',
      'name': 'Paracétamol',
      'dosage': 'Comprimé 500mg',
      'time': 'Aujourd\'hui, 08:00',
      'type': 'pill',
      'status': 'taken',
      'color': successColor,
      'icon': Icons.medication,
    },
    {
      'id': '2',
      'name': 'Amoxicilline',
      'dosage': 'Gélule 250mg',
      'time': 'Aujourd\'hui, 12:00',
      'type': 'capsule',
      'status': 'pending',
      'color': warningColor,
      'icon': Icons.medication_liquid,
    },
    {
      'id': '3',
      'name': 'Metformine',
      'dosage': 'Comprimé 850mg',
      'time': 'Aujourd\'hui, 20:00',
      'type': 'pill',
      'status': 'upcoming',
      'color': primaryColor,
      'icon': Icons.medication,
    },
  ];

  // Indicateur d'observance
  final double adherenceRate = 0.95; // 95%

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      color: isDark ? backgroundColorDark : backgroundColorLight,
      child: Column(
        children: [
          // Contenu principal avec défilement
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bannière d'alerte
                  _buildAlertBanner(),
                  const SizedBox(height: 24),

                  // Section prochaines prises
                  _buildUpcomingDosesSection(isDark),
                  const SizedBox(height: 24),

                  // Section observance
                  _buildAdherenceSection(isDark),
                  const SizedBox(height: 32),

                  // Section historique des traitements
                  _buildTreatmentHistorySection(isDark),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Bannière d'alerte
  Widget _buildAlertBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dangerColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: dangerColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: dangerColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Fin du traitement pour Amoxicilline dans 3 jours.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: dangerColor,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Section prochaines prises
  Widget _buildUpcomingDosesSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prochaines Prises',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : const Color(0xFF111827),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        ...upcomingDoses.map((dose) => _buildDoseCard(dose, isDark)),
      ],
    );
  }

  // Carte de prise de médicament
  Widget _buildDoseCard(Map<String, dynamic> dose, bool isDark) {
    final bool isTaken = dose['status'] == 'taken';
    final bool isPending = dose['status'] == 'pending';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark 
            ? const Color(0xFF1F2937) 
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPending
              ? warningColor.withOpacity(0.3)
              : (isDark 
                  ? const Color(0xFF374151).withOpacity(0.3)
                  : const Color(0xFFE5E7EB)),
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
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Icône du médicament
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                dose['icon'],
                color: primaryColor,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            
            // Informations du médicament
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dose['time'],
                    style: TextStyle(
                      fontSize: 12,
                      color: isPending
                          ? warningColor
                          : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dose['name'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF111827),
                    ),
                  ),
                  Text(
                    dose['dosage'],
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Bouton d'action
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (isTaken) {
                          _showAlreadyTakenDialog(context);
                        } else {
                          _markAsTaken(dose['id']);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isTaken ? successColor : primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      icon: Icon(
                        isTaken ? Icons.check_circle_rounded : Icons.alarm_rounded,
                        size: 20,
                      ),
                      label: Text(
                        isTaken ? 'Déjà pris' : 'Prendre maintenant',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section observance
  Widget _buildAdherenceSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark 
            ? const Color(0xFF1F2937) 
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mon Observance',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : const Color(0xFF111827),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          
          // Taux d'observance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ce mois-ci',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563),
                ),
              ),
              Text(
                '${(adherenceRate * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Barre de progression
          Container(
            height: 12,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(6),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: adherenceRate,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [primaryColor, Color(0xFF2A7DE1)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Message d'encouragement
          Text(
            adherenceRate >= 0.9
                ? 'Excellent ! Continuez comme ça pour un traitement efficace.'
                : adherenceRate >= 0.7
                    ? 'Bon suivi ! Pensez à activer les rappels pour améliorer votre observance.'
                    : 'Votre observance pourrait être meilleure. Activez les rappels pour ne pas oublier vos prises.',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // Section historique des traitements
  Widget _buildTreatmentHistorySection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Traitements Actifs',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : const Color(0xFF111827),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        _buildTreatmentCard(
          name: 'Metformine',
          dosage: '850mg, 2 fois par jour',
          remainingDays: 15,
          totalDays: 30,
          isDark: isDark,
        ),
        const SizedBox(height: 12),
        _buildTreatmentCard(
          name: 'Lisinopril',
          dosage: '10mg, 1 fois par jour',
          remainingDays: 25,
          totalDays: 90,
          isDark: isDark,
        ),
        const SizedBox(height: 12),
        _buildTreatmentCard(
          name: 'Atorvastatine',
          dosage: '20mg, 1 fois par jour',
          remainingDays: 45,
          totalDays: 90,
          isDark: isDark,
        ),
      ],
    );
  }

  // Carte de traitement actif
  Widget _buildTreatmentCard({
    required String name,
    required String dosage,
    required int remainingDays,
    required int totalDays,
    required bool isDark,
  }) {
    final double progress = remainingDays / totalDays;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1F2937) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark 
              ? const Color(0xFF374151).withOpacity(0.3)
              : const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF111827),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: remainingDays < 7 
                      ? dangerColor.withOpacity(0.1)
                      : primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$remainingDays jours restants',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: remainingDays < 7 ? dangerColor : primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            dosage,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563),
            ),
          ),
          const SizedBox(height: 12),
          // Barre de progression
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: progress < 0.2
                              ? [dangerColor, const Color(0xFFFF6B6B)]
                              : [primaryColor, const Color(0xFF2A7DE1)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${((progress) * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==============================================
  // ACTIONS ET DIALOGUES
  // ==============================================

  void _markAsTaken(String doseId) {
    setState(() {
      final index = upcomingDoses.indexWhere((dose) => dose['id'] == doseId);
      if (index != -1) {
        upcomingDoses[index]['status'] = 'taken';
        upcomingDoses[index]['color'] = successColor;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Médicament marqué comme pris'),
        backgroundColor: successColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showAlreadyTakenDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Déjà pris',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: const Text(
            'Ce médicament a déjà été marqué comme pris pour aujourd\'hui.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addNewMedication(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ajouter un médicament',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              _buildFormField('Nom du médicament', Icons.medication),
              const SizedBox(height: 12),
              _buildFormField('Dosage (ex: 500mg)', Icons.science),
              const SizedBox(height: 12),
              _buildFormField('Fréquence (ex: 2 fois/jour)', Icons.access_time),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Médicament ajouté avec succès'),
                        backgroundColor: successColor,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Ajouter le médicament',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFormField(String label, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }
}