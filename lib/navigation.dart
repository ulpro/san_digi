import 'package:flutter/material.dart';
import 'home.dart';
import 'ordonnance.dart';
import 'treatment.dart';
import 'profile_screen.dart';
import 'rdv_screen.dart'; // ← AJOUTER CET IMPORT POUR LE RDV

// ==============================================
// IMPORTATION DES COULEURS
// ==============================================

const Color primaryBlue = Color(0xFF2A7DE1);
const Color mediumText = Color(0xFF5D6D7E);
const Color cardWhite = Color(0xFFFFFFFF);
const Color backgroundGray = Color(0xFFF8F9FA);
const Color darkBackground = Color(0xFF121A26);
const Color darkCard = Color(0xFF1C2536);
const Color alertRed = Color(0xFFFF3B30);

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Liste des écrans de l'application
  final List<Widget> _screens = [
    const HomeScreen(),
    const TreatmentScreen(), // ← ÉCRAN TRAITEMENTS RÉEL
    const PrescriptionScreen(),
    const RendezVousScreen(), // ← ÉCRAN RDV RÉEL (remplacé le placeholder)
    const ProfileScreen(), // ← ÉCRAN PROFIL RÉEL
  ];

  // Titres pour chaque écran
  final List<String> _screenTitles = [
    'Accueil',
    'Mes Traitements',
    'Mes Ordonnances',
    'Mes Rendez-vous',
    'Mon Profil',
  ];

  // Notifications pour chaque écran
  final List<bool> _hasNotifications = [
    true, // Accueil
    false, // Traitements
    false, // Ordonnances
    true, // RDV
    false, // Profil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          _screenTitles[_currentIndex],
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        // Actions spécifiques à chaque écran
        actions: _buildAppBarActions(context),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // Actions spécifiques à la barre d'application
  List<Widget> _buildAppBarActions(BuildContext context) {
    switch (_currentIndex) {
      case 0: // Accueil
        return [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () => _showNotifications(context),
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                if (_hasNotifications[0])
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: alertRed,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.surface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ];

      case 2: // Ordonnances
        return [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ];

      case 3: // RDV
        return [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () => _showNotifications(context),
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                if (_hasNotifications[3])
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: alertRed,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.surface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {
              // On peut appeler la fonction addNewAppointment de RendezVousScreen
              // via un GlobalKey ou en passant une callback
              _showAddAppointmentDialog(context);
            },
          ),
        ];

      case 4: // Profil
        return [
          IconButton(
            icon: const Icon(Icons.qr_code_2),
            onPressed: () => _showQRCodeDialog(context),
          ),
        ];

      default:
        return [];
    }
  }

  // Barre de navigation du bas avec badges de notification
  Widget _buildBottomNavigationBar(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : const Color(0xFFE2E8F0),
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        backgroundColor: theme.colorScheme.surface,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: mediumText,
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 11, height: 1.5),
        elevation: 0,
        items: [
          // Accueil
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(
                  _currentIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
                  size: 24,
                ),
                if (_hasNotifications[0] && _currentIndex != 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: alertRed,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.surface,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            activeIcon: const Icon(Icons.home_rounded, size: 24),
            label: 'Accueil',
          ),

          // Traitements
          const BottomNavigationBarItem(
            icon: Icon(Icons.medication_outlined, size: 24),
            activeIcon: Icon(Icons.medication_rounded, size: 24),
            label: 'Traitements',
          ),

          // Ordonnances
          const BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined, size: 24),
            activeIcon: Icon(Icons.description_rounded, size: 24),
            label: 'Ordonnances',
          ),

          // RDV
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(
                  _currentIndex == 3
                      ? Icons.calendar_month_rounded
                      : Icons.calendar_month_outlined,
                  size: 24,
                ),
                if (_hasNotifications[3] && _currentIndex != 3)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: alertRed,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.surface,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            activeIcon: const Icon(Icons.calendar_month_rounded, size: 24),
            label: 'RDV',
          ),

          // Profil
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined, size: 24),
            activeIcon: Icon(Icons.person_rounded, size: 24),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // Boîte de dialogue de filtrage (pour l'écran des ordonnances)
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Filtrer les ordonnances',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildFilterOption('Toutes', true),
                _buildFilterOption('Actives seulement', false),
                _buildFilterOption('À renouveler', false),
                _buildFilterOption('Terminées', false),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler', style: TextStyle(color: mediumText)),
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
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Appliquer'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterOption(String label, bool selected) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: selected ? primaryBlue : mediumText,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: selected ? const Color(0xFF2C3E50) : mediumText,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
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

  // Dialogue pour ajouter un nouveau RDV
  void _showAddAppointmentDialog(BuildContext context) {
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
              const Text(
                'Nouveau rendez-vous',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 20),
              _buildFormField(
                'Spécialité recherchée',
                Icons.medical_services_rounded,
              ),
              const SizedBox(height: 12),
              _buildFormField(
                'Motif de la consultation',
                Icons.description_rounded,
              ),
              const SizedBox(height: 12),
              _buildFormField('Date souhaitée', Icons.calendar_today_rounded),
              const SizedBox(height: 12),
              _buildFormField('Préférence horaire', Icons.access_time_rounded),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Demande de rendez-vous envoyée'),
                        backgroundColor: Color(0xFF4CD964),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Demander un rendez-vous',
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

  Widget _buildFormField(String label, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryBlue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
      ),
    );
  }

  // Dialogue de notifications
  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
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
              const Text(
                'Notifications',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 20),

              // Liste des notifications
              _buildNotificationItem(
                'Rappel de prise',
                'Prenez votre Metformine dans 30 minutes',
                Icons.medication,
                true,
              ),
              const SizedBox(height: 12),
              _buildNotificationItem(
                'Ordonnance à renouveler',
                'Votre ordonnance pour Amoxicilline expire dans 3 jours',
                Icons.warning_amber,
                false,
              ),
              const SizedBox(height: 12),
              _buildNotificationItem(
                'Rendez-vous confirmé',
                'Votre consultation avec Dr. Martin est confirmée pour demain',
                Icons.calendar_today,
                true,
              ),
              const SizedBox(height: 12),
              _buildNotificationItem(
                'Nouveau rendez-vous disponible',
                'Le Dr. Dupont a un créneau disponible demain',
                Icons.event_available,
                false,
              ),
              const SizedBox(height: 24),

              // Bouton pour tout marquer comme lu
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Toutes les notifications ont été marquées comme lues',
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Tout marquer comme lu',
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

  Widget _buildNotificationItem(
    String title,
    String subtitle,
    IconData icon,
    bool isRead,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isRead ? Colors.transparent : primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isRead ? Colors.grey.shade200 : primaryBlue.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primaryBlue, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (!isRead)
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: alertRed,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  // Dialogue QR Code pour le profil
  void _showQRCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Mon Code Santé',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner_rounded,
                    size: 80,
                    color: primaryBlue,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Scannez ce code pour accéder à mes informations médicales',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: mediumText),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Fermer',
                          style: TextStyle(
                            fontSize: 15,
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Code santé partagé'),
                              backgroundColor: Color(0xFF28A745),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Partager',
                          style: TextStyle(
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
          ),
        );
      },
    );
  }
}
