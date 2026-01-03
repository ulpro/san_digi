import 'package:flutter/material.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  // Couleurs du thème
  static const Color primaryColor = Color(0xFF13EC13);
  static const Color primaryDark = Color(0xFF0FDC0F);
  static const Color backgroundColorLight = Color(0xFFF6F8F6);
  static const Color backgroundColorDark = Color(0xFF102210);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color borderLight = Color(0xFFDBE6DB);
  static const Color borderDark = Color(0xFF374151);
  static const Color textMainLight = Color(0xFF111811);
  static const Color textMainDark = Color(0xFFFFFFFF);
  static const Color textSecondaryLight = Color(0xFF618961);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);

  // Variables d'état
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  
  // État des exigences de sécurité
  bool _hasMinLength = false;
  bool _hasUpperLower = false;
  bool _hasNumberOrSpecial = false;
  
  // Validation
  bool get _isPasswordValid => _hasMinLength && _hasUpperLower && _hasNumberOrSpecial;
  bool get _doPasswordsMatch => _passwordController.text.isNotEmpty && 
      _passwordController.text == _confirmPasswordController.text;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
    _confirmPasswordController.addListener(_validatePasswordMatch);
  }

  void _validatePassword() {
    final password = _passwordController.text;
    
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUpperLower = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])').hasMatch(password);
      _hasNumberOrSpecial = RegExp(r'^(?=.*\d|.*[!@#$%^&*(),.?":{}|<>])').hasMatch(password);
    });
  }

  void _validatePasswordMatch() {
    setState(() {});
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  void _createAccount() {
    if (!_isPasswordValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Le mot de passe ne respecte pas toutes les exigences de sécurité'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!_doPasswordsMatch) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Les mots de passe ne correspondent pas'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Naviguer vers l'écran suivant
    // Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Compte créé avec succès'),
        backgroundColor: primaryColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? backgroundColorDark : backgroundColorLight,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            _buildAppBar(isDark),
            
            // Contenu principal avec défilement
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Texte d'instructions
                    _buildInstructionText(isDark),
                    
                    // Champs de mot de passe
                    _buildPasswordFields(isDark),
                    
                    // Checklist de sécurité
                    _buildSecurityChecklist(isDark),
                    
                    // Lien d'aide
                    _buildHelpLink(isDark),
                  ],
                ),
              ),
            ),
            
            // Bouton en bas
            _buildBottomButton(isDark),
          ],
        ),
      ),
    );
  }

  // App Bar
  Widget _buildAppBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      decoration: BoxDecoration(
        color: isDark ? backgroundColorDark : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.transparent : borderLight.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          // Bouton retour
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isDark ? Colors.transparent : Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: isDark ? textMainDark : textMainLight,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
          
          Expanded(
            child: Text(
              'Sécurisez votre compte',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? textMainDark : textMainLight,
                letterSpacing: -0.3,
              ),
            ),
          ),
          
          // Espace vide pour équilibrer
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  // Texte d'instructions
  Widget _buildInstructionText(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 32),
      child: Text(
        'Veuillez définir un mot de passe pour protéger vos données de santé.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: isDark ? Colors.grey.shade300 : textMainLight,
          height: 1.5,
        ),
      ),
    );
  }

  // Champs de mot de passe
  Widget _buildPasswordFields(bool isDark) {
    return Column(
      children: [
        // Nouveau mot de passe
        _buildPasswordField(
          label: 'Nouveau mot de passe',
          hintText: 'Saisissez votre mot de passe',
          controller: _passwordController,
          showPassword: _showPassword,
          onToggleVisibility: _togglePasswordVisibility,
          isDark: isDark,
        ),
        
        const SizedBox(height: 24),
        
        // Confirmation du mot de passe
        _buildPasswordField(
          label: 'Confirmer le mot de passe',
          hintText: 'Répétez le mot de passe',
          controller: _confirmPasswordController,
          showPassword: _showConfirmPassword,
          onToggleVisibility: _toggleConfirmPasswordVisibility,
          isDark: isDark,
          showValidation: true,
          isValid: _doPasswordsMatch,
        ),
      ],
    );
  }

  // Champ de mot de passe individuel
  Widget _buildPasswordField({
    required String label,
    required String hintText,
    required TextEditingController controller,
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
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? textMainDark : textMainLight,
          ),
        ),
        const SizedBox(height: 8),
        
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: isDark ? surfaceDark : surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: showValidation
                  ? isValid
                      ? primaryColor
                      : Colors.red
                  : isDark ? borderDark : borderLight,
              width: showValidation ? 1.5 : 1,
            ),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: !showPassword,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? textMainDark : textMainLight,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: isDark ? textSecondaryDark : textSecondaryLight,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              
              // Bouton de visibilité
              IconButton(
                onPressed: onToggleVisibility,
                icon: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                  color: isDark ? textSecondaryDark : textSecondaryLight,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
        
        // Indicateur de validation
        if (showValidation)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Icon(
                  isValid ? Icons.check_circle : Icons.error,
                  size: 16,
                  color: isValid ? primaryColor : Colors.red,
                ),
                const SizedBox(width: 4),
                Text(
                  isValid ? 'Correspond' : 'Ne correspond pas',
                  style: TextStyle(
                    fontSize: 12,
                    color: isValid ? primaryColor : Colors.red,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // Checklist de sécurité
  Widget _buildSecurityChecklist(bool isDark) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? surfaceDark : surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? borderDark : borderLight,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EXIGENCES DE SÉCURITÉ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? textSecondaryDark : textSecondaryLight,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),
          
          // Item 1: Longueur minimale
          _buildChecklistItem(
            label: 'Au moins 8 caractères',
            isChecked: _hasMinLength,
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          
          // Item 2: Majuscule et minuscule
          _buildChecklistItem(
            label: 'Une majuscule et une minuscule',
            isChecked: _hasUpperLower,
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          
          // Item 3: Chiffre ou caractère spécial
          _buildChecklistItem(
            label: 'Un chiffre ou caractère spécial',
            isChecked: _hasNumberOrSpecial,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  // Item de checklist
  Widget _buildChecklistItem({
    required String label,
    required bool isChecked,
    required bool isDark,
  }) {
    return Row(
      children: [
        // Checkbox personnalisé
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isChecked ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isChecked ? primaryColor : (isDark ? borderDark : borderLight),
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
            fontWeight: FontWeight.w500,
            color: isDark 
                ? (isChecked ? Colors.white : Colors.grey.shade400)
                : (isChecked ? textMainLight : textSecondaryLight),
          ),
        ),
      ],
    );
  }

  // Lien d'aide
  Widget _buildHelpLink(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 16),
      child: GestureDetector(
        onTap: () {
          // Afficher l'aide
          _showHelpDialog(isDark);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.help_outline,
              size: 16,
              color: isDark ? textSecondaryDark : textSecondaryLight,
            ),
            const SizedBox(width: 8),
            Text(
              'Besoin d\'aide ?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? textSecondaryDark : textSecondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bouton en bas
  Widget _buildBottomButton(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? backgroundColorDark : surfaceLight,
        border: Border(
          top: BorderSide(
            color: isDark ? borderDark : borderLight,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: _createAccount,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            shadowColor: primaryColor.withOpacity(0.3),
          ),
          child: Text(
            'Créer mon compte',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Dialogue d'aide
  void _showHelpDialog(bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? surfaceDark : surfaceLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.security,
                color: primaryColor,
              ),
              const SizedBox(width: 12),
              Text(
                'Conseils de sécurité',
                style: TextStyle(
                  color: isDark ? textMainDark : textMainLight,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pour un mot de passe sécurisé :',
                style: TextStyle(
                  color: isDark ? textMainDark : textMainLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              _buildHelpTip('Utilisez une combinaison unique', isDark),
              _buildHelpTip('Évitez les informations personnelles', isDark),
              _buildHelpTip('Changez régulièrement votre mot de passe', isDark),
              _buildHelpTip('N\'utilisez pas le même mot de passe sur plusieurs sites', isDark),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Compris',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHelpTip(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            size: 16,
            color: primaryColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isDark ? textSecondaryDark : textSecondaryLight,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}