import 'package:flutter/material.dart';
import '../../prescription/constants.dart';

class QRCodeSection extends StatelessWidget {
  final bool isDark;

  const QRCodeSection({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Code pharmacie',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark 
                ? PrescriptionColors.textPrimaryLight 
                : PrescriptionColors.textPrimaryDark,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(PrescriptionConstants.defaultPadding),
          decoration: BoxDecoration(
            color: isDark 
                ? PrescriptionColors.cardDark 
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.1 : 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: PrescriptionConstants.qrCodeSize,
                height: PrescriptionConstants.qrCodeSize,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark 
                      ? PrescriptionColors.qrBgDark 
                      : PrescriptionColors.qrBgLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark
                        ? PrescriptionColors.borderDark
                        : PrescriptionColors.dividerLight,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.qr_code_scanner_rounded,
                      size: 80,
                      color: PrescriptionColors.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Présentez ce code à votre pharmacien',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? const Color(0xFFD1D5DB) 
                      : const Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Le QR code contient toutes les informations nécessaires pour le traitement',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark 
                      ? PrescriptionColors.textSecondaryLight 
                      : PrescriptionColors.textSecondaryDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}