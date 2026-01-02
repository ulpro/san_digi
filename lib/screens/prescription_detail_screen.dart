import 'package:flutter/material.dart';

// ==============================================
// ÉCRAN DÉTAIL D'UNE ORDONNANCE - DESIGN AMÉLIORÉ
// ==============================================

class PrescriptionDetailScreen extends StatelessWidget {
  final Map<String, dynamic> prescription;

  const PrescriptionDetailScreen({
    super.key,
    required this.prescription,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark 
          ? const Color(0xFF121A26) 
          : const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: isDark 
            ? const Color(0xFF1C2536) 
            : Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? Colors.white : const Color(0xFF2C3E50),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Détail de l\'ordonnance',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF2C3E50),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
              color: const Color(0xFF2A7DE1),
            ),
            onPressed: () => _sharePrescription(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carte d'en-tête améliorée
              _buildHeaderCard(context, theme, isDark),
              const SizedBox(height: 24),

              // Infos sur l'ordonnance
              _buildPrescriptionInfo(context, theme, isDark),
              const SizedBox(height: 24),

              // Médicaments prescrits avec design amélioré
              _buildMedicationsSection(context, theme, isDark),
              const SizedBox(height: 24),

              // Instructions particulières
              _buildInstructionsSection(context, theme, isDark),
              const SizedBox(height: 24),

              // QR Code Section améliorée
              _buildQRCodeSection(context, theme, isDark),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(context, theme, isDark),
    );
  }

  Widget _buildHeaderCard(BuildContext context, ThemeData theme, bool isDark) {
    final status = prescription['status'] ?? 'active';
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case 'active':
        statusColor = const Color(0xFF4CD964); // healthGreen
        statusText = 'Active';
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'completed':
        statusColor = const Color(0xFF6C757D);
        statusText = 'Terminée';
        statusIcon = Icons.done_all_rounded;
        break;
      case 'expiring':
        statusColor = const Color(0xFFFF9500); // warningOrange
        statusText = 'À renouveler';
        statusIcon = Icons.warning_amber_rounded;
        break;
      default:
        statusColor = const Color(0xFF2A7DE1); // primaryBlue
        statusText = 'En cours';
        statusIcon = Icons.access_time_rounded;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: isDark
              ? [
                  const Color(0xFF1C2536),
                  const Color(0xFF252F44),
                ]
              : [
                  Colors.white,
                  const Color(0xFFF0F7FF),
                ],
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
              ? const Color(0xFF2D3748).withOpacity(0.3)
              : const Color(0xFFE2E8F0),
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
                  prescription['title'] ?? 'Ordonnance médicale',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF2C3E50),
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                ? const Color(0xFF374151).withOpacity(0.5)
                : const Color(0xFFE5E7EB),
            height: 1,
          ),
          const SizedBox(height: 16),

          // Infos du médecin
          _buildInfoRow(
            icon: Icons.person_rounded,
            label: 'Prescrit par',
            value: prescription['doctorFullName'] ?? prescription['doctor'] ?? 'Dr. Jean Dupont',
            isDark: isDark,
          ),
          const SizedBox(height: 12),

          // Date de prescription
          _buildInfoRow(
            icon: Icons.calendar_month_rounded,
            label: 'Date de prescription',
            value: prescription['date'] ?? '15 Mars 2024',
            isDark: isDark,
          ),
          const SizedBox(height: 12),

          // Établissement
          _buildInfoRow(
            icon: Icons.local_hospital_rounded,
            label: 'Établissement',
            value: prescription['hospital'] ?? 'Hôpital Central',
            isDark: isDark,
          ),

          // Date d'expiration si disponible
          if (prescription['expiryDate'] != null) ...[
            const SizedBox(height: 12),
            _buildInfoRow(
              icon: Icons.timelapse_rounded,
              label: 'Expire le',
              value: prescription['expiryDate']!,
              isDark: isDark,
              isWarning: true,
            ),
          ],
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
                ? const Color(0xFFFF9500).withOpacity(0.1)
                : const Color(0xFF2A7DE1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: isWarning ? const Color(0xFFFF9500) : const Color(0xFF2A7DE1),
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
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF6B7280),
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
                      ? const Color(0xFFFF9500)
                      : (isDark ? Colors.white : const Color(0xFF1F2937)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrescriptionInfo(BuildContext context, ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C2536) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informations de l\'ordonnance',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem(
                icon: Icons.repeat_rounded,
                label: 'Renouvellements',
                value: '${prescription['remainingRefills'] ?? 0} restant(s)',
                isDark: isDark,
              ),
              _buildInfoItem(
                icon: Icons.medication_rounded,
                label: 'Médicaments',
                value: '${(prescription['medicationDetails'] ?? []).length}',
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF2A7DE1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF2A7DE1),
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF2C3E50),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  Widget _buildMedicationsSection(BuildContext context, ThemeData theme, bool isDark) {
    final List<Map<String, dynamic>> medications = 
        prescription['medicationDetails'] ?? [
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
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Médicaments prescrits',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF2C3E50),
              ),
            ),
            Text(
              '${medications.length} médicament(s)',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF6B7280),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...medications.asMap().entries.map((entry) {
          final index = entry.key;
          final med = entry.value;
          return _buildMedicationCard(med, index, isDark);
        }),
      ],
    );
  }

  Widget _buildMedicationCard(Map<String, dynamic> medication, int index, bool isDark) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, top: index == 0 ? 0 : 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark 
            ? const Color(0xFF1C2536) 
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? const Color(0xFF2D3748).withOpacity(0.3)
              : const Color(0xFFE5E7EB),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.1 : 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CD964).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.medication_liquid_rounded,
                  color: Color(0xFF4CD964),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  medication['name'] ?? 'Médicament',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF2C3E50),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildMedicationTag(
                icon: Icons.science_rounded,
                text: medication['dosage'] ?? 'N/A',
                isDark: isDark,
              ),
              _buildMedicationTag(
                icon: Icons.access_time_rounded,
                text: medication['frequency'] ?? 'N/A',
                isDark: isDark,
              ),
              _buildMedicationTag(
                icon: Icons.calendar_today_rounded,
                text: medication['duration'] ?? 'N/A',
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationTag({
    required IconData icon,
    required String text,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF2D3748).withOpacity(0.5)
            : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF6B7280),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF4B5563),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsSection(BuildContext context, ThemeData theme, bool isDark) {
    final instructions = prescription['instructions'] ?? 
        'À prendre pendant les repas. Éviter l\'exposition au soleil pendant le traitement à l\'Amoxicilline.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructions particulières',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF7CD).withOpacity(isDark ? 0.2 : 1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFFFD54F).withOpacity(0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.lightbulb_rounded,
                color: const Color(0xFFFFB300),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  instructions,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF78350F),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQRCodeSection(BuildContext context, ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Code pharmacie',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1C2536) : Colors.white,
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
            children: [
              // QR Code avec fond amélioré
              Container(
                width: 180,
                height: 180,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF111827) : const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF374151)
                        : const Color(0xFFE5E7EB),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.qr_code_scanner_rounded,
                      size: 80,
                      color: Color(0xFF2A7DE1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Présentez ce code à votre pharmacien',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Le QR code contient toutes les informations nécessaires pour le traitement',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionBar(BuildContext context, ThemeData theme, bool isDark) {
    final isCompleted = prescription['status'] == 'completed';
    final canRenew = (prescription['remainingRefills'] ?? 0) > 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C2536) : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark
                ? const Color(0xFF374151)
                : const Color(0xFFE5E7EB),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCompleted)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF10B981).withOpacity(0.2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_rounded, 
                      color: const Color(0xFF10B981), size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Ordonnance terminée',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
            )
          else
            Row(
              children: [
                if (canRenew)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _renewPrescription(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(
                          color: const Color(0xFF2A7DE1).withOpacity(0.3),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Icon(
                        Icons.autorenew_rounded,
                        color: const Color(0xFF2A7DE1),
                      ),
                      label: Text(
                        'Renouveler',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2A7DE1),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  flex: canRenew ? 1 : 2,
                  child: ElevatedButton.icon(
                    onPressed: () => _markAsCompleted(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2A7DE1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      shadowColor: const Color(0xFF2A7DE1).withOpacity(0.3),
                    ),
                    icon: const Icon(Icons.check_rounded, size: 20),
                    label: Text(
                      'Terminer',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _sharePrescription(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Partage de l\'ordonnance - Fonctionnalité à venir'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _renewPrescription(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Renouveler l\'ordonnance',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          content: Text(
            'Voulez-vous demander un renouvellement de cette ordonnance ?',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Annuler',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Demande de renouvellement envoyée'),
                    backgroundColor: Color(0xFF10B981),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A7DE1),
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  void _markAsCompleted(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Marquer comme terminée',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          content: Text(
            'Voulez-vous marquer cette ordonnance comme terminée ?',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Annuler',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ordonnance marquée comme terminée'),
                    backgroundColor: Color(0xFF10B981),
                    duration: Duration(seconds: 2),
                  ),
                );
                // Retour à la page précédente après 1.5 secondes
                Future.delayed(const Duration(milliseconds: 1500), () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }
}