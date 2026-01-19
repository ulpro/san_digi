// lib/user/auth/screens/vpn_certificate_screen.dart
import 'package:flutter/material.dart';
import '../../../shared/app_colors.dart';

class VPNCertificateScreen extends StatefulWidget {
  final Function(bool) onCertificateDownloaded;

  const VPNCertificateScreen({
    super.key,
    required this.onCertificateDownloaded,
  });

  @override
  State<VPNCertificateScreen> createState() => _VPNCertificateScreenState();
}

class _VPNCertificateScreenState extends State<VPNCertificateScreen> {
  bool _isDownloading = false;
  double _downloadProgress = 0.0;

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
                // Icône de succès
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.successGreen.withOpacity(0.2),
                          const Color(0xFF4CD964).withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.successGreen.withOpacity(0.15),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      size: 60,
                      color: AppColors.successGreen,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Titre
                Text(
                  'Compte créé avec succès !',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // Description
                Text(
                  'Votre compte San Digi est maintenant prêt. '
                  'Vous pouvez télécharger votre certificat de sécurité pour un accès optimal.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: isDark
                        ? Colors.grey.shade400
                        : AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 48),

                // Carte du certificat
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.cardBackgroundDark
                        : AppColors.cardBackgroundLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? Colors.white12 : AppColors.borderLight,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.vpn_key_outlined,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Certificat de sécurité',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Fichier .p12 • 48 KB',
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.grey.shade400
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Bouton de téléchargement
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _isDownloading
                              ? null
                              : _downloadCertificate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: _isDownloading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Icon(Icons.download_outlined),
                          label: Text(
                            _isDownloading
                                ? 'Téléchargement... ${(_downloadProgress * 100).toInt()}%'
                                : 'Télécharger le certificat',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Note d'information
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryBlue.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: AppColors.primaryBlue,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Ce certificat est optionnel. Vous pouvez le télécharger plus tard depuis vos paramètres.',
                          style: TextStyle(
                            color: isDark ? Colors.white70 : Colors.black87,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadCertificate() async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    // Simulation de téléchargement
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _downloadProgress = i / 100;
      });
    }

    setState(() {
      _isDownloading = false;
    });

    // Notifier le parent que le certificat a été téléchargé
    widget.onCertificateDownloaded(true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Certificat téléchargé avec succès'),
        backgroundColor: AppColors.successGreen,
      ),
    );
  }
}
