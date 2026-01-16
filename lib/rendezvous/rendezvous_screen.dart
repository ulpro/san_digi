import 'package:flutter/material.dart';
import 'data.dart';
import 'constants.dart';
import 'models.dart';
import 'widgets/today_section.dart';
import 'widgets/filter_section.dart';
import 'widgets/appointment_card.dart';
import 'widgets/empty_state.dart';
import 'widgets/floating_action_button.dart';
import 'widgets/detail_sheet.dart';
import 'widgets/dialogs/reminder_dialog.dart';
import 'widgets/dialogs/confirm_dialog.dart';
import 'widgets/dialogs/cancel_dialog.dart';
import 'widgets/dialogs/medical_report_dialog.dart';
import 'widgets/dialogs/new_appointment_sheet.dart';

class RendezVousScreen extends StatefulWidget {
  const RendezVousScreen({super.key});

  @override
  State<RendezVousScreen> createState() => _RendezVousScreenState();
}

class _RendezVousScreenState extends State<RendezVousScreen> {
  int _selectedFilterIndex = 0;
  late List<Appointment> _appointments;

  @override
  void initState() {
    super.initState();
    _appointments = List.from(RendezVousData.appointments);
  }

  void _handleFilterChanged(int index) {
    setState(() {
      _selectedFilterIndex = index;
    });
  }

  void _showAppointmentDetails(Appointment appointment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return DetailSheet(
          appointment: appointment,
          onCancel: () {
            Navigator.pop(context);
            _showCancelDialog(appointment);
          },
        );
      },
    );
  }

  void _handleAppointmentAction(Appointment appointment) {
    if (appointment.isConfirmed) {
      _showReminderDialog(appointment);
    } else if (appointment.isPending) {
      _showConfirmDialog(appointment);
    }
  }

  void _showReminderDialog(Appointment appointment) {
    showDialog(
      context: context,
      builder: (context) => ReminderDialog(
        onConfirm: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Rappel programmé 1 heure avant le rendez-vous'),
              backgroundColor: RendezVousColors.healthGreen,
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  void _showConfirmDialog(Appointment appointment) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        onConfirm: () {
          setState(() {
            final index = _appointments.indexWhere((apt) => apt.id == appointment.id);
            if (index != -1) {
              _appointments[index] = Appointment(
                id: appointment.id,
                doctor: appointment.doctor,
                specialty: appointment.specialty,
                date: appointment.date,
                time: appointment.time,
                address: appointment.address,
                type: appointment.type,
                status: 'confirmed',
                duration: appointment.duration,
                isToday: appointment.isToday,
              );
            }
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Rendez-vous confirmé avec succès'),
              backgroundColor: RendezVousColors.healthGreen,
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  void _showCancelDialog(Appointment appointment) {
    showDialog(
      context: context,
      builder: (context) => CancelDialog(
        onConfirm: () {
          setState(() {
            final index = _appointments.indexWhere((apt) => apt.id == appointment.id);
            if (index != -1) {
              _appointments[index] = Appointment(
                id: appointment.id,
                doctor: appointment.doctor,
                specialty: appointment.specialty,
                date: appointment.date,
                time: appointment.time,
                address: appointment.address,
                type: appointment.type,
                status: 'cancelled',
                duration: appointment.duration,
                isToday: appointment.isToday,
              );
            }
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Rendez-vous annulé'),
              backgroundColor: RendezVousColors.alertRed,
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  void _showMedicalReport(Appointment appointment) {
    final report = RendezVousData.getMedicalReport(appointment.id);
    showDialog(
      context: context,
      builder: (context) => MedicalReportDialog(report: report),
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
      builder: (context) => const NewAppointmentSheet(),
    );
  }

  List<Appointment> _getFilteredAppointments() {
    switch (_selectedFilterIndex) {
      case 0:
        return _appointments
            .where((apt) => apt.isConfirmed || apt.isPending)
            .toList();
      case 1:
        return _appointments.where((apt) => apt.isCompleted).toList();
      case 2:
        return _appointments.where((apt) => apt.isCancelled).toList();
      default:
        return _appointments;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final todayAppointments = _appointments.where((apt) => apt.isToday).toList();
    final filteredAppointments = _getFilteredAppointments();

    return Scaffold(
      backgroundColor: isDark 
          ? RendezVousColors.bgDark 
          : RendezVousColors.bgLight,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(RendezVousConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section "Aujourd'hui"
                  if (todayAppointments.isNotEmpty) ...[
                    TodaySection(
                      todayAppointments: todayAppointments,
                      onShowDetails: _showAppointmentDetails,
                      onActionPressed: _handleAppointmentAction,
                      onShowMedicalReport: _showMedicalReport,
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Filtres
                  FilterSection(
                    selectedFilterIndex: _selectedFilterIndex,
                    onFilterChanged: _handleFilterChanged,
                  ),
                  const SizedBox(height: 24),

                  // Liste des rendez-vous
                  if (filteredAppointments.isNotEmpty)
                    Column(
                      children: filteredAppointments.map((apt) => AppointmentCard(
                            appointment: apt,
                            isToday: apt.isToday,
                            onShowDetails: () => _showAppointmentDetails(apt),
                            onActionPressed: () => _handleAppointmentAction(apt),
                            onShowMedicalReport: () => _showMedicalReport(apt),
                          )).toList(),
                    )
                  else
                    EmptyState(selectedFilterIndex: _selectedFilterIndex),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AppointmentFAB(onPressed: _addNewAppointment),
    );
  }
}