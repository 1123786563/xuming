import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class WarningQuotePanel extends StatelessWidget {
  const WarningQuotePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.nuclearWarning.withOpacity(0.1),
        border: const Border(
          left: BorderSide(color: AppColors.nuclearWarning, width: 4),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Diagnostic Warning // Error_Code_404_SPINE",
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.nuclearWarning,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "\"Your spine isn't a straight line anymore; it's a disaster. Twist it back.\"",
                style: AppTypography.monoBody.copyWith(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              ),
            ],
          ),
           Positioned(
             bottom: -16,
             right: -16,
             child: Transform.rotate(
               angle: 12 * 3.14 / 180,
               child: Icon(
                 Icons.warning,
                 size: 80,
                 color: AppColors.nuclearWarning.withOpacity(0.2),
               ),
             ),
           ),
        ],
      ),
    );
  }
}
