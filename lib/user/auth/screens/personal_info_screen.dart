import 'package:flutter/material.dart';
import '../../../shared/app_colors.dart';

class PersonalInfoScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onDataChanged;
  final Map<String, dynamic>? initialData;
  
  const PersonalInfoScreen({
    super.key,
    required this.onDataChanged,
    this.initialData,
  });

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _socialSecurityController = TextEditingController();
  final _lastConsultationController = TextEditingController();
  final _doctorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    if (widget.initialData != null) {
      _firstNameController.text = widget.initialData!['firstName'] ?? '';
      _lastNameController.text = widget.initialData!['lastName'] ?? '';
      _emailController.text = widget.initialData!['email'] ?? '';
      _phoneController.text = widget.initialData!['phone'] ?? '';
      _birthDateController.text = widget.initialData!['birthDate'] ?? '';
      _socialSecurityController.text = widget.initialData!['socialSecurityNumber'] ?? '';
      _lastConsultationController.text = widget.initialData!['lastConsultation'] ?? '';
      _doctorController.text = widget.initialData!['doctorName'] ?? '';
    }
  }

  bool _validateForm() {
    return _firstNameController.text.isNotEmpty &&
           _lastNameController.text.isNotEmpty &&
           _emailController.text.isNotEmpty &&
           RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text) &&
           _phoneController.text.isNotEmpty &&
           _birthDateController.text.isNotEmpty &&
           _socialSecurityController.text.isNotEmpty;
  }

  Map<String, dynamic> _collectData() {
    return {
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'birthDate': _birthDateController.text,
      'socialSecurityNumber': _socialSecurityController.text.trim(),
      'lastConsultation': _lastConsultationController.text.isNotEmpty 
          ? _lastConsultationController.text 
          : null,
      'doctorName': _doctorController.text.isNotEmpty 
          ? _doctorController.text.trim()
          : null,
    };
  }

  void _notifyDataChanged() {
    widget.onDataChanged(_collectData());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Text(
                  'Informations personnelles',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ces informations sont essentielles pour votre dossier médical.',
                  style: TextStyle(
                    color: isDark ? AppColors.textHint : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                
                _buildTextFieldRow(
                  firstController: _firstNameController,
                  firstLabel: 'Prénom',
                  firstHint: 'Jean',
                  secondController: _lastNameController,
                  secondLabel: 'Nom',
                  secondHint: 'Dupont',
                  isDark: isDark,
                  onChanged: _notifyDataChanged,
                ),
                const SizedBox(height: 16),
                
                _buildTextField(
                  controller: _emailController,
                  label: 'Adresse email',
                  hint: 'jean.dupont@email.com',
                  isDark: isDark,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: _notifyDataChanged,
                ),
                const SizedBox(height: 16),
                
                _buildTextField(
                  controller: _phoneController,
                  label: 'Numéro de téléphone',
                  hint: '06 12 34 56 78',
                  isDark: isDark,
                  keyboardType: TextInputType.phone,
                  onChanged: _notifyDataChanged,
                ),
                const SizedBox(height: 16),
                
                _buildTextField(
                  controller: _birthDateController,
                  label: 'Date de naissance',
                  hint: 'JJ/MM/AAAA',
                  isDark: isDark,
                  onTap: () => _showDatePicker(_birthDateController),
                  onChanged: _notifyDataChanged,
                ),
                const SizedBox(height: 16),
                
                _buildTextField(
                  controller: _socialSecurityController,
                  label: 'Numéro de sécurité sociale',
                  hint: '1 85 01 01 234 567 89',
                  isDark: isDark,
                  keyboardType: TextInputType.number,
                  onChanged: _notifyDataChanged,
                ),
                const SizedBox(height: 16),
                
                _buildTextField(
                  controller: _lastConsultationController,
                  label: 'Dernière consultation (optionnel)',
                  hint: 'JJ/MM/AAAA',
                  isDark: isDark,
                  onTap: () => _showDatePicker(_lastConsultationController),
                  optional: true,
                  onChanged: _notifyDataChanged,
                ),
                const SizedBox(height: 16),
                
                _buildTextField(
                  controller: _doctorController,
                  label: 'Nom du praticien (optionnel)',
                  hint: 'Dr. Martin / Grippe...',
                  isDark: isDark,
                  optional: true,
                  onChanged: _notifyDataChanged,
                ),
              ],
            ),
          ),
          
          // SUPPRIMEZ le bouton "Continuer" ici
          // Le bouton est maintenant uniquement dans register_screen.dart
        ],
      ),
    );
  }

  Widget _buildTextFieldRow({
    required TextEditingController firstController,
    required String firstLabel,
    required String firstHint,
    required TextEditingController secondController,
    required String secondLabel,
    required String secondHint,
    required bool isDark,
    required VoidCallback onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            controller: firstController,
            label: firstLabel,
            hint: firstHint,
            isDark: isDark,
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildTextField(
            controller: secondController,
            label: secondLabel,
            hint: secondHint,
            isDark: isDark,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isDark,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onTap,
    bool optional = false,
    VoidCallback? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? AppColors.white : AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            children: optional
                ? [const TextSpan(text: ' (optionnel)', style: TextStyle(fontWeight: FontWeight.normal))]
                : [],
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onTap: onTap,
          readOnly: onTap != null,
          onChanged: (value) {
            if (onChanged != null) onChanged();
          },
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: isDark
                ? AppColors.cardBackgroundDark
                : AppColors.cardBackgroundLight,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
            suffixIcon: onTap != null
                ? const Icon(Icons.calendar_today_outlined, size: 20)
                : null,
          ),
          style: TextStyle(
            color: isDark ? AppColors.white : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Future<void> _showDatePicker(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      controller.text =
          '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      _notifyDataChanged();
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _socialSecurityController.dispose();
    _lastConsultationController.dispose();
    _doctorController.dispose();
    super.dispose();
  }
}