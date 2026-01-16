import 'package:flutter/material.dart';
import '../constants.dart';

class AddMedicationForm extends StatefulWidget {
  final Function onMedicationAdded;

  const AddMedicationForm({
    super.key,
    required this.onMedicationAdded,
  });

  @override
  State<AddMedicationForm> createState() => _AddMedicationFormState();
}

class _AddMedicationFormState extends State<AddMedicationForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();

  Widget _buildFormField(String label, IconData icon) {
    return TextField(
      controller: _getControllerForLabel(label),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: TreatmentColors.primaryColor),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(TreatmentConstants.buttonBorderRadius),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(TreatmentConstants.buttonBorderRadius),
          borderSide:
              BorderSide(color: TreatmentColors.primaryColor, width: 2),
        ),
      ),
    );
  }

  TextEditingController _getControllerForLabel(String label) {
    if (label.contains('Nom')) return _nameController;
    if (label.contains('Dosage')) return _dosageController;
    return _frequencyController;
  }

  void _submitForm() {
    if (_nameController.text.isEmpty ||
        _dosageController.text.isEmpty ||
        _frequencyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: TreatmentColors.dangerColor,
        ),
      );
      return;
    }

    widget.onMedicationAdded();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _frequencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TreatmentConstants.largePadding),
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
          const SizedBox(height: TreatmentConstants.mediumPadding),
          _buildFormField('Nom du médicament', Icons.medication),
          const SizedBox(height: TreatmentConstants.smallPadding),
          _buildFormField('Dosage (ex: 500mg)', Icons.science),
          const SizedBox(height: TreatmentConstants.smallPadding),
          _buildFormField('Fréquence (ex: 2 fois/jour)', Icons.access_time),
          const SizedBox(height: TreatmentConstants.defaultPadding),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: TreatmentColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(TreatmentConstants.buttonBorderRadius),
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
  }
}