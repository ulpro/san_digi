import 'package:flutter/material.dart';
import 'data.dart';
import 'constants.dart';
import 'models.dart';
import 'widgets/app_bar.dart';
import 'widgets/qr_code_section.dart';
import 'widgets/medical_info_section.dart';
import 'widgets/emergency_contacts_section.dart';
import 'widgets/healthcare_institutions_section.dart';
import 'widgets/emergency_button.dart';
import 'widgets/dialogs/edit_medical_info_sheet.dart';
import 'widgets/dialogs/call_contact_dialog.dart';
import 'widgets/dialogs/institution_details_sheet.dart';
import 'widgets/dialogs/emergency_mode_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  MedicalInfo medicalInfo = ProfileData.medicalInfo;

  void _handleMenuAction(String value) {
    switch (value) {
      case 'edit':
        _showEditMedicalInfo();
        break;
      case 'share':
        _shareHealthCode();
        break;
      case 'export':
        _exportMedicalData();
        break;
    }
  }

  void _showEditMedicalInfo() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => EditMedicalInfoSheet(
        medicalInfo: medicalInfo,
        onSave: (updatedInfo) {
          setState(() {
            medicalInfo = updatedInfo;
          });
        },
      ),
    );
  }

  void _shareHealthCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code santé partagé avec succès'),
        backgroundColor: ProfileColors.successColor,
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
        backgroundColor: ProfileColors.successColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _callContact(EmergencyContact contact) {
    showDialog(
      context: context,
      builder: (context) => CallContactDialog(
        contact: contact,
        onCall: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Appel vers ${contact.name} initié'),
              backgroundColor: ProfileColors.primaryColor,
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  void _viewInstitutionDetails(HealthcareInstitution institution) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => InstitutionDetailsSheet(institution: institution),
    );
  }

  void _activateEmergencyMode() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const EmergencyModeDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: isDark 
          ? ProfileColors.backgroundColorDark 
          : ProfileColors.backgroundColorLight,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar personnalisée
            ProfileAppBar(
              isDark: isDark,
              screenWidth: screenWidth,
              onBack: () => Navigator.pop(context),
              onMenuAction: _handleMenuAction,
            ),

            // Contenu principal
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: ProfileConstants.mediumPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // QR Code
                    QRCodeSection(
                      isDark: isDark,
                      screenWidth: screenWidth,
                      onShare: _shareHealthCode,
                      onDownload: _downloadQRCode,
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Informations médicales
                    MedicalInfoSection(
                      isDark: isDark,
                      screenWidth: screenWidth,
                      medicalInfo: medicalInfo,
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Contacts d'urgence
                    EmergencyContactsSection(
                      isDark: isDark,
                      screenWidth: screenWidth,
                      contacts: ProfileData.emergencyContacts,
                      onCallContact: _callContact,
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Établissements de suivi
                    HealthcareInstitutionsSection(
                      isDark: isDark,
                      screenWidth: screenWidth,
                      institutions: ProfileData.healthcareInstitutions,
                      onViewDetails: _viewInstitutionDetails,
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Bouton mode urgence
                    EmergencyButton(
                      isDark: isDark,
                      screenWidth: screenWidth,
                      onPressed: _activateEmergencyMode,
                    ),
                    SizedBox(height: screenHeight * 0.04),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}