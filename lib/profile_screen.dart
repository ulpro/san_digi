import 'dart:math';
import 'package:flutter/material.dart';

// ==============================================
// ÉCRAN DE PROFIL - CODE SANTÉ
// ==============================================

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Couleurs utilisées dans l'écran
  static const Color primaryColor = Color(0xFF007BFF);
  static const Color primaryGradientEnd = Color(0xFF2A7DE1);
  static const Color backgroundColorLight = Color(0xFFF8F9FA);
  static const Color backgroundColorDark = Color(0xFF111521);
  static const Color alertColor = Color(0xFFDC3545);
  static const Color textMainColor = Color(0xFF212529);
  static const Color textSecondaryColor = Color(0xFF6C757D);

  // Informations médicales
  final Map<String, dynamic> medicalInfo = {
    'allergies': 'Pollen, Pénicilline',
    'bloodType': 'O+',
    'importantTreatments': ['Lévothyroxine', 'Anticoagulants'],
  };

  // Contacts d'urgence
  final List<Map<String, dynamic>> emergencyContacts = [
    {
      'name': 'Jeanne Dupont',
      'relationship': 'Épouse',
      'phone': '+33 6 12 34 56 78',
      'icon': Icons.person,
    },
    {
      'name': 'Luc Martin',
      'relationship': 'Fils',
      'phone': '+33 6 23 45 67 89',
      'icon': Icons.person,
    },
    {
      'name': 'Dr. Sophie Martin',
      'relationship': 'Cardiologue',
      'phone': '+33 1 23 45 67 89',
      'icon': Icons.medical_services,
    },
  ];

  // Établissements de suivi
  final List<Map<String, dynamic>> healthcareInstitutions = [
    {
      'name': 'Hôpital Central',
      'specialty': 'Cardiologie',
      'phone': '+33 1 45 67 89 00',
      'icon': Icons.local_hospital,
    },
    {
      'name': 'Clinique de la Forêt',
      'specialty': 'Médecine Générale',
      'phone': '+33 1 56 78 90 12',
      'icon': Icons.local_hospital,
    },
    {
      'name': 'Centre d\'Imagerie Médicale',
      'specialty': 'Radiologie',
      'phone': '+33 1 67 89 01 23',
      'icon': Icons.medical_services,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? backgroundColorDark : backgroundColorLight,
      body: Column(
        children: [
          // AppBar personnalisée
          _buildAppBar(isDark),

          // Contenu principal avec défilement
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section QR Code améliorée
                  _buildQRCodeSection(isDark),
                  const SizedBox(height: 24),

                  // Section informations médicales
                  _buildMedicalInfoSection(isDark),
                  const SizedBox(height: 24),

                  // Section contacts d'urgence
                  _buildEmergencyContactsSection(isDark),
                  const SizedBox(height: 24),

                  // Section établissements de suivi
                  _buildHealthcareInstitutionsSection(isDark),
                  const SizedBox(height: 32),

                  // Bouton mode urgence
                  _buildEmergencyButton(isDark),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // AppBar personnalisée
  Widget _buildAppBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      decoration: BoxDecoration(
        color: isDark ? backgroundColorDark : backgroundColorLight,
        border: Border(
          bottom: BorderSide(
            color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
          ),
        ),
      ),
      child: Row(
        children: [
          // Bouton retour
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: isDark ? Colors.white : textMainColor,
                size: 20,
              ),
            ),
          ),
          const Spacer(),
          // Titre
          Text(
            'Mon Code Santé',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : textMainColor,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          // Bouton options
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6),
            ),
            child: PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      const Icon(Icons.edit_rounded, size: 20),
                      const SizedBox(width: 8),
                      const Text('Modifier les informations'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'share',
                  child: Row(
                    children: [
                      const Icon(Icons.share_rounded, size: 20),
                      const SizedBox(width: 8),
                      const Text('Partager mon code santé'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'export',
                  child: Row(
                    children: [
                      const Icon(Icons.download_rounded, size: 20),
                      const SizedBox(width: 8),
                      const Text('Exporter mes données'),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                _handleMenuAction(value);
              },
              child: Icon(
                Icons.more_vert_rounded,
                color: isDark ? Colors.white : textMainColor,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Section QR Code - Version corrigée avec taille limitée
  Widget _buildQRCodeSection(bool isDark) {
    // Calcul de la taille maximale basée sur l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    final maxQRSize = min(
      screenWidth * 0.85,
      350.0,
    ).toDouble(); // Converti en double

    return Column(
      children: [
        // Conteneur principal du QR Code avec taille limitée
        Container(
          width: maxQRSize,
          height: maxQRSize,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryColor.withOpacity(0.1),
                primaryColor.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: primaryColor.withOpacity(0.2), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: maxQRSize * 0.8,
              height: maxQRSize * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: maxQRSize * 0.6,
                  height: maxQRSize * 0.6,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: primaryColor.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code_scanner_rounded,
                          size: maxQRSize * 0.3,
                          color: primaryColor,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'CODE SANTÉ',
                          style: TextStyle(
                            fontSize: maxQRSize * 0.045,
                            fontWeight: FontWeight.w800,
                            color: primaryColor,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ID: SNDG-2024-001',
                          style: TextStyle(
                            fontSize: maxQRSize * 0.03,
                            fontWeight: FontWeight.w500,
                            color: textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Texte explicatif amélioré
        Column(
          children: [
            Text(
              'Mon QR Code Santé',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : textMainColor,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Scannez ce code pour accéder rapidement à mon dossier médical complet en cas d\'urgence',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: isDark ? const Color(0xFF9CA3AF) : textSecondaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Bouton de partage
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? const Color(0xFF1F2937) : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.1 : 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => _shareHealthCode(),
                    icon: Icon(
                      Icons.share_rounded,
                      color: primaryColor,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? const Color(0xFF1F2937) : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.1 : 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => _downloadQRCode(),
                    icon: Icon(
                      Icons.download_rounded,
                      color: primaryColor,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Section informations médicales
  Widget _buildMedicalInfoSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1F2937) : Colors.white,
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
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [primaryColor, primaryGradientEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.medical_information_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Informations Médicales',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : textMainColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Allergies
          _buildMedicalInfoRow(
            icon: Icons.all_inclusive_rounded,
            title: 'Allergies',
            value: medicalInfo['allergies'],
            isDark: isDark,
            color: const Color(0xFFFF6B6B),
          ),
          const SizedBox(height: 12),

          // Groupe sanguin
          _buildMedicalInfoRow(
            icon: Icons.bloodtype_rounded,
            title: 'Groupe Sanguin',
            value: medicalInfo['bloodType'],
            isDark: isDark,
            color: const Color(0xFFDC3545),
          ),
          const SizedBox(height: 12),

          // Traitements importants
          _buildMedicalInfoRow(
            icon: Icons.medication_rounded,
            title: 'Traitements Importants',
            value: medicalInfo['importantTreatments'].join(', '),
            isDark: isDark,
            isMultiLine: true,
            color: const Color(0xFF28A745),
          ),
        ],
      ),
    );
  }

  // Ligne d'information médicale améliorée
  Widget _buildMedicalInfoRow({
    required IconData icon,
    required String title,
    required String value,
    required bool isDark,
    bool isMultiLine = false,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111827) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icône avec fond coloré
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),

          // Contenu
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : textMainColor,
                  ),
                ),
                const SizedBox(height: 6),
                if (isMultiLine)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: medicalInfo['importantTreatments']
                        .map<Widget>(
                          (treatment) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                Icon(Icons.circle, size: 6, color: color),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    treatment,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDark
                                          ? const Color(0xFFD1D5DB)
                                          : textSecondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  )
                else
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? const Color(0xFFD1D5DB)
                          : textSecondaryColor,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Section contacts d'urgence
  Widget _buildEmergencyContactsSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryColor, primaryGradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.contact_emergency_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Contacts d\'Urgence',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : textMainColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1F2937) : Colors.white,
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
            children: emergencyContacts
                .asMap()
                .entries
                .map(
                  (entry) => _buildContactCard(
                    entry.value,
                    isDark,
                    isLast: entry.key == emergencyContacts.length - 1,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  // Carte de contact améliorée
  Widget _buildContactCard(
    Map<String, dynamic> contact,
    bool isDark, {
    bool isLast = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: isDark
                      ? const Color(0xFF374151)
                      : const Color(0xFFE5E7EB),
                ),
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar/Icone avec gradient
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryColor, primaryGradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Icon(contact['icon'], color: Colors.white, size: 26),
              ),
            ),
            const SizedBox(width: 14),

            // Informations
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : textMainColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      contact['relationship'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.phone_rounded,
                        size: 14,
                        color: isDark
                            ? const Color(0xFF9CA3AF)
                            : textSecondaryColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        contact['phone'],
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? const Color(0xFFD1D5DB)
                              : const Color(0xFF495057),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Bouton d'appel amélioré
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF28A745), Color(0xFF20C997)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF28A745).withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(26),
                child: InkWell(
                  onTap: () => _callContact(contact),
                  borderRadius: BorderRadius.circular(26),
                  child: const Center(
                    child: Icon(
                      Icons.call_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section établissements de suivi
  Widget _buildHealthcareInstitutionsSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryColor, primaryGradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.local_hospital_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Établissements de Suivi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : textMainColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1F2937) : Colors.white,
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
            children: healthcareInstitutions
                .asMap()
                .entries
                .map(
                  (entry) => _buildInstitutionCard(
                    entry.value,
                    isDark,
                    isLast: entry.key == healthcareInstitutions.length - 1,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  // Carte d'établissement améliorée
  Widget _buildInstitutionCard(
    Map<String, dynamic> institution,
    bool isDark, {
    bool isLast = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: isDark
                      ? const Color(0xFF374151)
                      : const Color(0xFFE5E7EB),
                ),
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Icone avec fond
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: primaryColor.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Icon(institution['icon'], color: primaryColor, size: 26),
              ),
            ),
            const SizedBox(width: 14),

            // Informations
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    institution['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : textMainColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.medical_services_rounded,
                        size: 14,
                        color: isDark
                            ? const Color(0xFF9CA3AF)
                            : textSecondaryColor,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          institution['specialty'],
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? const Color(0xFF9CA3AF)
                                : textSecondaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.phone_rounded,
                        size: 14,
                        color: isDark
                            ? const Color(0xFF9CA3AF)
                            : textSecondaryColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        institution['phone'],
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? const Color(0xFFD1D5DB)
                              : const Color(0xFF495057),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Bouton de navigation amélioré
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF374151)
                    : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () => _viewInstitutionDetails(institution),
                  borderRadius: BorderRadius.circular(12),
                  child: Center(
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: isDark
                          ? const Color(0xFF9CA3AF)
                          : textSecondaryColor,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bouton mode urgence amélioré
  Widget _buildEmergencyButton(bool isDark) {
    return Container(
      width: double.infinity,
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [alertColor, Color(0xFFFF5252)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: alertColor.withOpacity(0.5),
            blurRadius: 24,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: () => _activateEmergencyMode(),
          borderRadius: BorderRadius.circular(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.emergency_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MODE URGENCE',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Appeler l\'aide immédiatement',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ==============================================
  // ACTIONS ET DIALOGUES
  // ==============================================

  void _handleMenuAction(String value) {
    switch (value) {
      case 'edit':
        _editMedicalInfo();
        break;
      case 'share':
        _shareHealthCode();
        break;
      case 'export':
        _exportMedicalData();
        break;
    }
  }

  void _editMedicalInfo() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Modifier les informations',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),
              _buildEditField('Allergies', medicalInfo['allergies']),
              const SizedBox(height: 12),
              _buildEditField('Groupe sanguin', medicalInfo['bloodType']),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Informations mises à jour'),
                        backgroundColor: Color(0xFF28A745),
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
                    'Sauvegarder',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEditField(String label, String initialValue) {
    return TextField(
      controller: TextEditingController(text: initialValue),
      decoration: InputDecoration(
        labelText: label,
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

  void _shareHealthCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code santé partagé avec succès'),
        backgroundColor: Color(0xFF28A745),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _exportMedicalData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exportation des données médicales en cours...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _downloadQRCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('QR Code téléchargé dans la galerie'),
        backgroundColor: Color(0xFF28A745),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _callContact(Map<String, dynamic> contact) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Appeler ${contact['name']}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.person_rounded, color: primaryColor, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        contact['relationship'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  contact['phone'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Annuler',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Appel vers ${contact['name']} initié'),
                    backgroundColor: primaryColor,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.call_rounded, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Appeler',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _viewInstitutionDetails(Map<String, dynamic> institution) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [primaryColor, primaryGradientEnd],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      institution['icon'],
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          institution['name'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          institution['specialty'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildDetailRow(
                Icons.phone_rounded,
                'Téléphone',
                institution['phone'],
              ),
              const SizedBox(height: 12),
              _buildDetailRow(
                Icons.location_on_rounded,
                'Adresse',
                '123 Avenue de la Santé, 75015 Paris',
              ),
              const SizedBox(height: 12),
              _buildDetailRow(
                Icons.access_time_rounded,
                'Horaires',
                'Lun-Ven: 8h-19h, Sam: 9h-13h',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Fermer',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primaryColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _activateEmergencyMode() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: alertColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.emergency_rounded, color: alertColor, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Mode Urgence',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: alertColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Le mode urgence va contacter tous vos contacts d\'urgence, partager votre position et appeler les services d\'urgence. Cette action est irréversible.',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.6,
              ),
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: alertColor.withOpacity(0.8),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'À utiliser uniquement en cas d\'urgence réelle',
                          style: TextStyle(
                            fontSize: 12,
                            color: alertColor.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFF3F4F6),
                            foregroundColor: const Color(0xFF6B7280),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Annuler',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _startEmergencyProtocol();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: alertColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.emergency_rounded, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Activer',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _startEmergencyProtocol() {
    // Simulation du mode urgence
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.emergency_rounded, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Mode urgence activé - Contacts alertés',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFFDC3545),
        duration: Duration(seconds: 5),
      ),
    );

    // Changement de thème pour le mode urgence
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => EmergencyModeScreen()));
  }
}

// Écran de mode urgence amélioré
class EmergencyModeScreen extends StatelessWidget {
  const EmergencyModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDC3545),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animation de pulsation
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
              child: Center(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.emergency_rounded,
                        color: Color(0xFFDC3545),
                        size: 60,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'MODE URGENCE ACTIVÉ',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Vos contacts d\'urgence ont été alertés et votre position a été partagée avec les services de secours.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  _buildEmergencyStatus(
                    'Contacts alertés',
                    '3/3',
                    Icons.check_circle_rounded,
                  ),
                  const SizedBox(height: 12),
                  _buildEmergencyStatus(
                    'Position envoyée',
                    'Active',
                    Icons.location_on_rounded,
                  ),
                  const SizedBox(height: 12),
                  _buildEmergencyStatus(
                    'Services d\'urgence',
                    'En route',
                    Icons.local_hospital_rounded,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFFDC3545),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cancel_rounded),
                    SizedBox(width: 12),
                    Text(
                      'DÉSACTIVER LE MODE URGENCE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Appeler le 15 (SAMU)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyStatus(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
