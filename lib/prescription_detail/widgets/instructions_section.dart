import 'package:flutter/material.dart';
import '../../prescription/constants.dart';

class InstructionsSection extends StatelessWidget {
  final String instructions;
  final bool isDark;

  const InstructionsSection({
    super.key,
    required this.instructions,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructions particulières',
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
          padding: const EdgeInsets.all(PrescriptionConstants.mediumPadding),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF7CD).withOpacity(isDark ? 0.2 : 1),
            borderRadius: BorderRadius.circular(PrescriptionConstants.cardBorderRadius),
            border: Border.all(
              color: const Color(0xFFFFD54F).withOpacity(0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.lightbulb_rounded,
                color: PrescriptionColors.warningColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  instructions,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark 
                        ? const Color(0xFFE5E7EB) 
                        : const Color(0xFF78350F),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}