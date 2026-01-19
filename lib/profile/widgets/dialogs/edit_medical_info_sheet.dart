import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../../models/health_model.dart';

class EditMedicalInfoSheet extends StatefulWidget {
  final MedicalInfo medicalInfo;
  final Function(MedicalInfo) onSave;

  const EditMedicalInfoSheet({
    super.key,
    required this.medicalInfo,
    required this.onSave,
  });

  @override
  State<EditMedicalInfoSheet> createState() => _EditMedicalInfoSheetState();
}

class _EditMedicalInfoSheetState extends State<EditMedicalInfoSheet> {
  late TextEditingController _allergiesController;
  late TextEditingController _bloodTypeController;
  late TextEditingController _treatmentsController;

  @override
  void initState() {
    super.initState();
    _allergiesController = TextEditingController(
      text: widget.medicalInfo.allergies,
    );
    _bloodTypeController = TextEditingController(
      text: widget.medicalInfo.bloodType,
    );
    _treatmentsController = TextEditingController(
      text: widget.medicalInfo.importantTreatments.join(', '),
    );
  }

  @override
  void dispose() {
    _allergiesController.dispose();
    _bloodTypeController.dispose();
    _treatmentsController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final updatedInfo = MedicalInfo(
      allergies: _allergiesController.text,
      bloodType: _bloodTypeController.text,
      importantTreatments: _treatmentsController.text
          .split(',')
          .map((t) => t.trim())
          .toList(),
    );
    widget.onSave(updatedInfo);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Informations mises à jour'),
        backgroundColor: ProfileColors.successColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Modifier les informations',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: ProfileColors.textMainColor,
            ),
          ),
          const SizedBox(height: 20),
          _buildEditField('Allergies', _allergiesController),
          const SizedBox(height: 12),
          _buildEditField('Groupe sanguin', _bloodTypeController),
          const SizedBox(height: 12),
          _buildEditField('Traitements importants', _treatmentsController),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: ProfileColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    ProfileConstants.buttonBorderRadius,
                  ),
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
  }

  Widget _buildEditField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ProfileConstants.buttonBorderRadius,
          ),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ProfileConstants.buttonBorderRadius,
          ),
          borderSide: const BorderSide(
            color: ProfileColors.primaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
