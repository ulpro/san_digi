import 'package:flutter/material.dart';

// ==============================================
// ÉCRAN DES RENDEZ-VOUS
// ==============================================

class RendezVousScreen extends StatefulWidget {
  const RendezVousScreen({super.key});

  @override
  State<RendezVousScreen> createState() => _RendezVousScreenState();
}

class _RendezVousScreenState extends State<RendezVousScreen> {
  int _selectedFilter = 0; // 0: À venir, 1: Passés, 2: Annulés
  final List<String> _filters = ['À venir', 'Passés', 'Annulés'];

  // Liste des rendez-vous
  final List<Map<String, dynamic>> _appointments = [
    {
      'id': '1',
      'doctor': 'Dr. Sophie Martin',
      'specialty': 'Cardiologue',
      'date': 'Lun 15 Juin 2024',
      'time': '10:00 - 10:30',
      'address': '123 Rue de la Santé, 75015 Paris',
      'type': 'Consultation de suivi',
      'status': 'confirmed',
      'duration': '30 min',
      'isToday': true,
    },
    {
      'id': '2',
      'doctor': 'Dr. Jean Dupont',
      'specialty': 'Généraliste',
      'date': 'Mar 18 Juin 2024',
      'time': '14:00 - 14:30',
      'address': '45 Avenue du Médical, 75008 Paris',
      'type': 'Contrôle annuel',
      'status': 'confirmed',
      'duration': '30 min',
      'isToday': false,
    },
    {
      'id': '3',
      'doctor': 'Dr. Marie Lefebvre',
      'specialty': 'Dermatologue',
      'date': 'Mer 19 Juin 2024',
      'time': '09:00 - 09:45',
      'address': '78 Boulevard des Spécialistes, 75016 Paris',
      'type': 'Consultation spécialisée',
      'status': 'pending',
      'duration': '45 min',
      'isToday': false,
    },
    {
      'id': '4',
      'doctor': 'Dr. Pierre Durand',
      'specialty': 'Ophtalmologue',
      'date': 'Jeu 20 Juin 2024',
      'time': '11:15 - 11:45',
      'address': '22 Rue de la Vision, 75017 Paris',
      'type': 'Examen de routine',
      'status': 'confirmed',
      'duration': '30 min',
      'isToday': false,
    },
    {
      'id': '5',
      'doctor': 'Dr. Lucie Bernard',
      'specialty': 'Kinésithérapeute',
      'date': 'Ven 14 Juin 2024',
      'time': '16:00 - 16:45',
      'address': '56 Allée du Sport, 75011 Paris',
      'type': 'Séance de rééducation',
      'status': 'completed',
      'duration': '45 min',
      'isToday': true,
    },
    {
      'id': '6',
      'doctor': 'Dr. Thomas Moreau',
      'specialty': 'Radiologue',
      'date': 'Sam 8 Juin 2024',
      'time': '08:30 - 09:00',
      'address': '89 Rue des Examens, 75013 Paris',
      'type': 'Échographie',
      'status': 'completed',
      'duration': '30 min',
      'isToday': false,
    },
    {
      'id': '7',
      'doctor': 'Dr. Camille Petit',
      'specialty': 'Dentiste',
      'date': 'Dim 9 Juin 2024',
      'time': '13:45 - 14:15',
      'address': '34 Avenue du Sourire, 75009 Paris',
      'type': 'Contrôle dentaire',
      'status': 'cancelled',
      'duration': '30 min',
      'isToday': false,
    },
  ];

  // Rendez-vous d'aujourd'hui
  List<Map<String, dynamic>> get todayAppointments =>
      _appointments.where((apt) => apt['isToday'] == true).toList();

  // Rendez-vous filtrés selon la sélection
  List<Map<String, dynamic>> get filteredAppointments {
    switch (_selectedFilter) {
      case 0: // À venir
        return _appointments
            .where((apt) => apt['status'] == 'confirmed' || apt['status'] == 'pending')
            .toList();
      case 1: // Passés
        return _appointments.where((apt) => apt['status'] == 'completed').toList();
      case 2: // Annulés
        return _appointments.where((apt) => apt['status'] == 'cancelled').toList();
      default:
        return _appointments;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark 
          ? const Color(0xFF121A26) 
          : const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // Contenu principal avec défilement
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section "Aujourd'hui"
                  if (todayAppointments.isNotEmpty) ...[
                    _buildTodaySection(isDark),
                    const SizedBox(height: 24),
                  ],

                  // Filtres
                  _buildFilterSection(isDark),
                  const SizedBox(height: 24),

                  // Liste des rendez-vous
                  _buildAppointmentsList(isDark),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  // Section "Aujourd'hui"
  Widget _buildTodaySection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aujourd\'hui',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : const Color(0xFF111827),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        ...todayAppointments.map((apt) => _buildAppointmentCard(apt, isDark, isToday: true)),
      ],
    );
  }

  // Section filtres
  Widget _buildFilterSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tous les rendez-vous',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : const Color(0xFF111827),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        // Boutons de filtre
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _filters.asMap().entries.map((entry) {
              final index = entry.key;
              final filter = entry.value;
              final isSelected = _selectedFilter == index;
              
              return Padding(
                padding: EdgeInsets.only(right: index < _filters.length - 1 ? 12 : 0),
                child: FilterChip(
                  label: Text(
                    filter,
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF2A7DE1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() => _selectedFilter = index);
                  },
                  backgroundColor: isDark 
                      ? const Color(0xFF1C2536) 
                      : Colors.white,
                  selectedColor: const Color(0xFF2A7DE1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected 
                          ? const Color(0xFF2A7DE1) 
                          : (isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB)),
                    ),
                  ),
                  checkmarkColor: Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Liste des rendez-vous
  Widget _buildAppointmentsList(bool isDark) {
    final appointments = filteredAppointments;
    
    if (appointments.isEmpty) {
      return _buildEmptyState(isDark);
    }

    return Column(
      children: appointments.map((apt) => 
        _buildAppointmentCard(apt, isDark, isToday: apt['isToday'])
      ).toList(),
    );
  }

  // État vide
  Widget _buildEmptyState(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(
            Icons.calendar_today_rounded,
            size: 64,
            color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun rendez-vous',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedFilter == 0
                ? 'Vous n\'avez pas de rendez-vous à venir.'
                : _selectedFilter == 1
                    ? 'Vous n\'avez pas de rendez-vous passés.'
                    : 'Vous n\'avez pas de rendez-vous annulés.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  // Carte de rendez-vous
  Widget _buildAppointmentCard(Map<String, dynamic> appointment, bool isDark,
      {bool isToday = false}) {
    final status = appointment['status'];
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case 'confirmed':
        statusColor = const Color(0xFF4CD964); // healthGreen
        statusText = 'Confirmé';
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'pending':
        statusColor = const Color(0xFFFF9500); // warningOrange
        statusText = 'En attente';
        statusIcon = Icons.access_time_rounded;
        break;
      case 'completed':
        statusColor = const Color(0xFF6C757D);
        statusText = 'Terminé';
        statusIcon = Icons.done_all_rounded;
        break;
      case 'cancelled':
        statusColor = const Color(0xFFFF3B30); // alertRed
        statusText = 'Annulé';
        statusIcon = Icons.cancel_rounded;
        break;
      default:
        statusColor = const Color(0xFF2A7DE1);
        statusText = 'Inconnu';
        statusIcon = Icons.help_rounded;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C2536) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark 
              ? const Color(0xFF2D3748).withOpacity(0.3)
              : const Color(0xFFE5E7EB),
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
        child: Column(
          children: [
            // En-tête avec statut
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                if (isToday)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A7DE1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'AUJOURD\'HUI',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2A7DE1),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Informations du rendez-vous
            Row(
              children: [
                // Icône
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A7DE1).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.local_hospital_rounded,
                    color: Color(0xFF2A7DE1),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Détails
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment['doctor'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        appointment['specialty'],
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563),
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Date et heure
                      _buildDetailRow(
                        Icons.calendar_today_rounded,
                        '${appointment['date']} • ${appointment['time']}',
                        isDark,
                      ),
                      const SizedBox(height: 6),
                      
                      // Type et durée
                      _buildDetailRow(
                        Icons.access_time_rounded,
                        '${appointment['type']} • ${appointment['duration']}',
                        isDark,
                      ),
                      const SizedBox(height: 6),
                      
                      // Adresse
                      _buildDetailRow(
                        Icons.location_on_rounded,
                        appointment['address'],
                        isDark,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Actions
            if (status == 'confirmed' || status == 'pending')
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showAppointmentDetails(appointment),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(
                          color: const Color(0xFF2A7DE1).withOpacity(0.3),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(
                        Icons.info_outline_rounded,
                        size: 18,
                      ),
                      label: const Text(
                        'Détails',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _handleAppointmentAction(appointment),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A7DE1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Icon(
                        status == 'confirmed' ? Icons.calendar_today_rounded : Icons.check_rounded,
                        size: 18,
                      ),
                      label: Text(
                        status == 'confirmed' ? 'Me rappeler' : 'Confirmer',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else if (status == 'completed')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showMedicalReport(appointment),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CD964),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.description_rounded, size: 18),
                  label: const Text(
                    'Voir le compte-rendu',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563),
            ),
          ),
        ),
      ],
    );
  }

  // Bouton flottant pour nouveau RDV
  Widget _buildFloatingActionButton() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF2A7DE1), Color(0xFF5AA9FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2A7DE1).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(32),
        child: InkWell(
          onTap: () => _addNewAppointment(),
          borderRadius: BorderRadius.circular(32),
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }

  // ==============================================
  // ACTIONS ET DIALOGUES
  // ==============================================

  void _handleAppointmentAction(Map<String, dynamic> appointment) {
    final status = appointment['status'];
    
    if (status == 'confirmed') {
      _setReminder(appointment);
    } else if (status == 'pending') {
      _confirmAppointment(appointment);
    }
  }

  void _showAppointmentDetails(Map<String, dynamic> appointment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return _buildAppointmentDetailsSheet(appointment);
      },
    );
  }

  Widget _buildAppointmentDetailsSheet(Map<String, dynamic> appointment) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Détails du rendez-vous',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          
          // Informations principales
          _buildDetailSection(
            'Médecin',
            appointment['doctor'],
            Icons.person_rounded,
          ),
          const SizedBox(height: 12),
          _buildDetailSection(
            'Spécialité',
            appointment['specialty'],
            Icons.medical_services_rounded,
          ),
          const SizedBox(height: 12),
          _buildDetailSection(
            'Date et heure',
            '${appointment['date']} à ${appointment['time']}',
            Icons.calendar_today_rounded,
          ),
          const SizedBox(height: 12),
          _buildDetailSection(
            'Durée',
            appointment['duration'],
            Icons.access_time_rounded,
          ),
          const SizedBox(height: 12),
          _buildDetailSection(
            'Type',
            appointment['type'],
            Icons.description_rounded,
          ),
          const SizedBox(height: 12),
          _buildDetailSection(
            'Adresse',
            appointment['address'],
            Icons.location_on_rounded,
          ),
          const SizedBox(height: 24),
          
          // Boutons d'action
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
                    _cancelAppointment(appointment);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF3B30),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Annuler RDV',
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
    );
  }

  Widget _buildDetailSection(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF2A7DE1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF2A7DE1),
            size: 20,
          ),
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
                ),
              ),
              const SizedBox(height: 2),
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
    );
  }

  void _setReminder(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Rappel de rendez-vous',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: const Text(
            'Voulez-vous programmer un rappel pour ce rendez-vous ?',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Annuler',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Rappel programmé 1 heure avant le rendez-vous'),
                    backgroundColor: Color(0xFF4CD964),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A7DE1),
                foregroundColor: Colors.white,
              ),
              child: const Text('Programmer'),
            ),
          ],
        );
      },
    );
  }

  void _confirmAppointment(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Confirmer le rendez-vous',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: const Text(
            'Voulez-vous confirmer votre présence à ce rendez-vous ?',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Annuler',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  final index = _appointments.indexWhere((apt) => apt['id'] == appointment['id']);
                  if (index != -1) {
                    _appointments[index]['status'] = 'confirmed';
                  }
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Rendez-vous confirmé avec succès'),
                    backgroundColor: Color(0xFF4CD964),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CD964),
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  void _cancelAppointment(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Annuler le rendez-vous',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: const Text(
            'Êtes-vous sûr de vouloir annuler ce rendez-vous ?',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Non, garder',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  final index = _appointments.indexWhere((apt) => apt['id'] == appointment['id']);
                  if (index != -1) {
                    _appointments[index]['status'] = 'cancelled';
                  }
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Rendez-vous annulé'),
                    backgroundColor: Color(0xFFFF3B30),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF3B30),
                foregroundColor: Colors.white,
              ),
              child: const Text('Oui, annuler'),
            ),
          ],
        );
      },
    );
  }

  void _showMedicalReport(Map<String, dynamic> appointment) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Compte-rendu médical',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Consultation avec le Dr. Martin s\'est bien déroulée. Tension artérielle stable à 12/8. Aucun symptôme alarmant détecté. Prochain contrôle dans 6 mois.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4B5563),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2A7DE1),
                      foregroundColor: Colors.white,
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
              ],
            ),
          ),
        );
      },
    );
  }

  void _addNewAppointment() {
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
              const Text(
                'Nouveau rendez-vous',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              _buildFormField('Spécialité recherchée', Icons.medical_services_rounded),
              const SizedBox(height: 12),
              _buildFormField('Motif de la consultation', Icons.description_rounded),
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
                    backgroundColor: const Color(0xFF2A7DE1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Demander un rendez-vous',
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
        prefixIcon: Icon(icon, color: const Color(0xFF2A7DE1)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2A7DE1), width: 2),
        ),
      ),
    );
  }
}