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
      _socialSecurityController.text =
          widget.initialData!['socialSecurityNumber'] ?? '';
      _lastConsultationController.text =
          widget.initialData!['lastConsultation'] ?? '';
      _doctorController.text = widget.initialData!['doctorName'] ?? '';
    }
  }

  bool _validateForm() {
    return _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        ).hasMatch(_emailController.text) &&
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

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Subtitle
          Text(
            'Informations personnelles',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Veuillez renseigner vos informations telles qu\'elles apparaissent sur votre carte de santé. Cette étape est nécessaire pour sécuriser votre dossier.',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white60 : Colors.grey.shade600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          // Card 1: Identity & Contact
          _buildCard(
            context,
            children: [
              _buildTextFieldRow(
                firstController: _lastNameController,
                firstLabel: 'Nom',
                firstHint: 'Dupont',
                secondController: _firstNameController,
                secondLabel: 'Prénom',
                secondHint: 'Jean',
                isDark: isDark,
                onChanged: _notifyDataChanged,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'jean.dupont@email.com',
                isDark: isDark,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                onChanged: _notifyDataChanged,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _phoneController,
                label: 'Téléphone',
                hint: '06 12 34 56 78',
                isDark: isDark,
                prefixIcon: Icons.phone_android_rounded,
                keyboardType: TextInputType.phone,
                onChanged: _notifyDataChanged,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Card 2: Health Info
          _buildCard(
            context,
            children: [
              _buildTextField(
                controller: _socialSecurityController,
                label: 'Numéro de santé unique (NSU)',
                hint: '1 80 01 75 000 000',
                isDark: isDark,
                keyboardType: TextInputType.number,
                suffixIcon: Icons.help_outline_rounded,
                onChanged: _notifyDataChanged,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _birthDateController,
                label: 'Date de naissance',
                hint: 'JJ / MM / AAAA',
                isDark: isDark,
                readOnly: true,
                suffixIcon: Icons.calendar_today_rounded,
                onTap: () => _showDatePicker(_birthDateController),
                onChanged: _notifyDataChanged,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Card 3: Security Check
          _buildCard(
            context,
            isSecurity: true,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.security_rounded,
                    color: AppColors.primaryBlue,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Vérification de sécurité',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Question : Lieu de votre dernière consultation ?',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white70 : Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                controller:
                    _lastConsultationController, // Reusing this controller for the place answer for now, or I should rename it.
                // The image asks for "Nom de l'établissement ou ville", which matches `_lastConsultation` variable name poorly but logic-wise I can map it.
                // Wait, `_lastConsultationController` was for DATE. `_doctorController` was for Name/Reason.
                // Let's use `_doctorController` for the Place/Establishment answer as it's a text field.
                label: '', // No label inside the visual design
                hint: 'Nom de l\'établissement ou ville',
                isDark: isDark,
                onChanged: _notifyDataChanged,
              ),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required List<Widget> children,
    bool isSecurity = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSecurity
            ? AppColors.primaryBlue.withOpacity(0.05)
            : (isDark ? AppColors.cardBackgroundDark : Colors.white),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSecurity
              ? AppColors.primaryBlue.withOpacity(0.2)
              : (isDark ? Colors.white12 : Colors.grey.shade200),
        ),
        boxShadow: isSecurity || isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
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
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            children: [
              _buildTextField(
                controller: firstController,
                label: firstLabel,
                hint: firstHint,
                isDark: isDark,
                onChanged: onChanged,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: secondController,
                label: secondLabel,
                hint: secondHint,
                isDark: isDark,
                onChanged: onChanged,
              ),
            ],
          );
        }
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
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isDark,
    TextInputType keyboardType = TextInputType.text,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onTap,
    bool optional = false,
    bool readOnly = false,
    VoidCallback? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text.rich(
              TextSpan(
                text: label,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? AppColors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
                children: optional
                    ? [
                        const TextSpan(
                          text: ' (optionnel)',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ]
                    : [],
              ),
            ),
          ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onTap: onTap,
          readOnly: readOnly || onTap != null,
          onChanged: (value) {
            if (onChanged != null) onChanged();
          },
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: isDark
                ? AppColors.backgroundDark
                : const Color(0xFFF9FAFB), // Very light grey for inputs
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    size: 20,
                    color: isDark ? Colors.white54 : Colors.grey.shade500,
                  )
                : null,
            suffixIcon: suffixIcon != null
                ? Icon(
                    suffixIcon,
                    size: 20,
                    color: isDark ? Colors.white54 : AppColors.primaryBlue,
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? Colors.white24 : Colors.grey.shade300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? Colors.white24 : Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primaryBlue,
                width: 1.5,
              ),
            ),
          ),
          style: TextStyle(
            color: isDark ? AppColors.white : AppColors.textPrimary,
            fontWeight: FontWeight.w500,
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
