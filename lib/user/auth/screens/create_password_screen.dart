import 'package:flutter/material.dart';
import '../../../shared/app_colors.dart';

class CreatePasswordScreen extends StatefulWidget {
  final Function(String) onPasswordChanged;
  final String? initialPassword;
  
  const CreatePasswordScreen({
    super.key,
    required this.onPasswordChanged,
    this.initialPassword,
  });

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  
  bool _hasMinLength = false;
  bool _hasUpperLower = false;
  bool _hasNumberOrSpecial = false;
  
  bool get _isPasswordValid => _hasMinLength && _hasUpperLower && _hasNumberOrSpecial;
  bool get _doPasswordsMatch => _passwordController.text.isNotEmpty && 
      _passwordController.text == _confirmPasswordController.text;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
    _confirmPasswordController.addListener(_validatePassword);
    
    if (widget.initialPassword != null) {
      _passwordController.text = widget.initialPassword!;
      _confirmPasswordController.text = widget.initialPassword!;
      _validatePassword();
    }
  }

  void _validatePassword() {
    final password = _passwordController.text;
    
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUpperLower = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])').hasMatch(password);
      _hasNumberOrSpecial = RegExp(r'^(?=.*\d|.*[!@#$%^&*(),.?":{}|<>])').hasMatch(password);
    });
    
    // Notifier le parent des changements
    widget.onPasswordChanged(_passwordController.text);
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
                  'Sécurité du compte',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Choisissez un mot de passe fort pour protéger vos données médicales.',
                  style: TextStyle(
                    color: isDark ? AppColors.textHint : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),
                
                _buildPasswordField(
                  controller: _passwordController,
                  label: 'Mot de passe',
                  hint: 'Saisissez votre mot de passe',
                  showPassword: _showPassword,
                  onToggleVisibility: () {
                    setState(() => _showPassword = !_showPassword);
                  },
                  isDark: isDark,
                ),
                const SizedBox(height: 24),
                
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  label: 'Confirmer le mot de passe',
                  hint: 'Répétez le mot de passe',
                  showPassword: _showConfirmPassword,
                  onToggleVisibility: () {
                    setState(() => _showConfirmPassword = !_showConfirmPassword);
                  },
                  isDark: isDark,
                  showValidation: true,
                  isValid: _doPasswordsMatch,
                ),
                
                const SizedBox(height: 32),
                
                // Checklist de sécurité
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.cardBackgroundDark
                        : AppColors.cardBackgroundLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EXIGENCES DE SÉCURITÉ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.textHint : AppColors.textSecondary,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      _buildChecklistItem(
                        label: 'Au moins 8 caractères',
                        isChecked: _hasMinLength,
                        isDark: isDark,
                      ),
                      const SizedBox(height: 12),
                      
                      _buildChecklistItem(
                        label: 'Une majuscule et une minuscule',
                        isChecked: _hasUpperLower,
                        isDark: isDark,
                      ),
                      const SizedBox(height: 12),
                      
                      _buildChecklistItem(
                        label: 'Un chiffre ou caractère spécial',
                        isChecked: _hasNumberOrSpecial,
                        isDark: isDark,
                      ),
                    ],
                  ),
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

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool showPassword,
    required VoidCallback onToggleVisibility,
    required bool isDark,
    bool showValidation = false,
    bool isValid = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? AppColors.white : AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackgroundLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: showValidation
                  ? isValid
                      ? AppColors.successGreen
                      : AppColors.alertRed
                  : isDark ? AppColors.borderDark : AppColors.borderLight,
              width: showValidation ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: !showPassword,
                  onChanged: (value) => _validatePassword(),
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintStyle: TextStyle(
                      color: isDark ? AppColors.textHint : AppColors.textSecondary,
                    ),
                  ),
                  style: TextStyle(
                    color: isDark ? AppColors.white : AppColors.textPrimary,
                  ),
                ),
              ),
              IconButton(
                onPressed: onToggleVisibility,
                icon: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
        ),
        if (showValidation)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Icon(
                  isValid ? Icons.check_circle : Icons.error,
                  size: 16,
                  color: isValid ? AppColors.successGreen : AppColors.alertRed,
                ),
                const SizedBox(width: 4),
                Text(
                  isValid ? 'Correspond' : 'Ne correspond pas',
                  style: TextStyle(
                    fontSize: 12,
                    color: isValid ? AppColors.successGreen : AppColors.alertRed,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildChecklistItem({
    required String label,
    required bool isChecked,
    required bool isDark,
  }) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isChecked ? AppColors.successGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isChecked ? AppColors.successGreen : (isDark ? AppColors.borderDark : AppColors.borderLight),
              width: 2,
            ),
          ),
          child: isChecked
              ? const Icon(
                  Icons.check,
                  size: 14,
                  color: Colors.white,
                )
              : null,
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark 
                ? (isChecked ? AppColors.white : AppColors.textHint)
                : (isChecked ? AppColors.textPrimary : AppColors.textSecondary),
            fontWeight: isChecked ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}