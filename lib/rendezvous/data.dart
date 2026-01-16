import 'models.dart';

class RendezVousData {
  static final List<Appointment> appointments = [
    Appointment(
      id: '1',
      doctor: 'Dr. Sophie Martin',
      specialty: 'Cardiologue',
      date: 'Lun 15 Juin 2024',
      time: '10:00 - 10:30',
      address: '123 Rue de la Santé, 75015 Paris',
      type: 'Consultation de suivi',
      status: 'confirmed',
      duration: '30 min',
      isToday: true,
    ),
    Appointment(
      id: '2',
      doctor: 'Dr. Jean Dupont',
      specialty: 'Généraliste',
      date: 'Mar 18 Juin 2024',
      time: '14:00 - 14:30',
      address: '45 Avenue du Médical, 75008 Paris',
      type: 'Contrôle annuel',
      status: 'confirmed',
      duration: '30 min',
      isToday: false,
    ),
    Appointment(
      id: '3',
      doctor: 'Dr. Marie Lefebvre',
      specialty: 'Dermatologue',
      date: 'Mer 19 Juin 2024',
      time: '09:00 - 09:45',
      address: '78 Boulevard des Spécialistes, 75016 Paris',
      type: 'Consultation spécialisée',
      status: 'pending',
      duration: '45 min',
      isToday: false,
    ),
    Appointment(
      id: '4',
      doctor: 'Dr. Pierre Durand',
      specialty: 'Ophtalmologue',
      date: 'Jeu 20 Juin 2024',
      time: '11:15 - 11:45',
      address: '22 Rue de la Vision, 75017 Paris',
      type: 'Examen de routine',
      status: 'confirmed',
      duration: '30 min',
      isToday: false,
    ),
    Appointment(
      id: '5',
      doctor: 'Dr. Lucie Bernard',
      specialty: 'Kinésithérapeute',
      date: 'Ven 14 Juin 2024',
      time: '16:00 - 16:45',
      address: '56 Allée du Sport, 75011 Paris',
      type: 'Séance de rééducation',
      status: 'completed',
      duration: '45 min',
      isToday: true,
    ),
    Appointment(
      id: '6',
      doctor: 'Dr. Thomas Moreau',
      specialty: 'Radiologue',
      date: 'Sam 8 Juin 2024',
      time: '08:30 - 09:00',
      address: '89 Rue des Examens, 75013 Paris',
      type: 'Échographie',
      status: 'completed',
      duration: '30 min',
      isToday: false,
    ),
    Appointment(
      id: '7',
      doctor: 'Dr. Camille Petit',
      specialty: 'Dentiste',
      date: 'Dim 9 Juin 2024',
      time: '13:45 - 14:15',
      address: '34 Avenue du Sourire, 75009 Paris',
      type: 'Contrôle dentaire',
      status: 'cancelled',
      duration: '30 min',
      isToday: false,
    ),
  ];

  static List<Appointment> getTodayAppointments() {
    return appointments.where((apt) => apt.isToday).toList();
  }

  static List<Appointment> getFilteredAppointments(int filterIndex) {
    switch (filterIndex) {
      case 0: // À venir
        return appointments
            .where((apt) => apt.status == 'confirmed' || apt.status == 'pending')
            .toList();
      case 1: // Passés
        return appointments.where((apt) => apt.status == 'completed').toList();
      case 2: // Annulés
        return appointments.where((apt) => apt.status == 'cancelled').toList();
      default:
        return appointments;
    }
  }

  static MedicalReport getMedicalReport(String appointmentId) {
    return MedicalReport(
      appointmentId: appointmentId,
      doctor: 'Dr. Sophie Martin',
      date: '15 Juin 2024',
      content: 'Consultation avec le Dr. Martin s\'est bien déroulée. '
          'Tension artérielle stable à 12/8. Aucun symptôme alarmant détecté.',
      recommendations: 'Prochain contrôle dans 6 mois.',
    );
  }
}