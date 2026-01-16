import 'dart:math';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'share_button.dart';

class QRCodeSection extends StatelessWidget {
  final bool isDark;
  final double screenWidth;
  final VoidCallback onShare;
  final VoidCallback onDownload;

  const QRCodeSection({
    super.key,
    required this.isDark,
    required this.screenWidth,
    required this.onShare,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    final qrSize = min(
      screenWidth * ProfileConstants.qrSizeRatio,
      ProfileConstants.qrMaxSize,
    );

    return Column(
      children: [
        // QR Code Container
        Container(
          width: qrSize,
          height: qrSize,
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ProfileColors.primaryColor.withOpacity(0.1),
                ProfileColors.primaryColor.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ProfileColors.primaryColor.withOpacity(0.2), 
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: _buildQRCodeContent(qrSize),
          ),
        ),
        SizedBox(height: screenWidth * 0.05),

        // Description et boutons
        Column(
          children: [
            Text(
              'Mon QR Code Santé',
              style: TextStyle(
                fontSize: screenWidth < 360 ? 16 : 18,
                fontWeight: FontWeight.w700,
                color: isDark ? ProfileColors.textLight : ProfileColors.textMainColor,
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(height: screenWidth * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Text(
                'Scannez ce code pour accéder rapidement à mon dossier médical complet en cas d\'urgence',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth < 360 ? 12 : 14,
                  height: 1.5,
                  color: isDark ? ProfileColors.textSecondaryDark : ProfileColors.textSecondaryColor,
                ),
              ),
            ),
            SizedBox(height: screenWidth * 0.04),

            // Boutons de partage
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShareButton(
                  icon: Icons.share_rounded,
                  onPressed: onShare,
                  isDark: isDark,
                  size: screenWidth < 360 ? 44 : 48,
                ),
                SizedBox(width: screenWidth * 0.04),
                ShareButton(
                  icon: Icons.download_rounded,
                  onPressed: onDownload,
                  isDark: isDark,
                  size: screenWidth < 360 ? 44 : 48,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQRCodeContent(double qrSize) {
    return Container(
      width: qrSize * 0.85,
      height: qrSize * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ProfileColors.primaryColor.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: qrSize * 0.65,
          height: qrSize * 0.65,
          padding: EdgeInsets.all(qrSize * 0.05),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: ProfileColors.primaryColor.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.qr_code_scanner_rounded,
                size: qrSize * 0.25,
                color: ProfileColors.primaryColor,
              ),
              SizedBox(height: qrSize * 0.03),
              Text(
                '12345678',
                style: TextStyle(
                  fontSize: qrSize * 0.04,
                  fontWeight: FontWeight.w800,
                  color: ProfileColors.primaryColor,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: qrSize * 0.01),
              Text(
                'ID: HEALTH-2024-001',
                style: TextStyle(
                  fontSize: qrSize * 0.025,
                  fontWeight: FontWeight.w500,
                  color: ProfileColors.textSecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}