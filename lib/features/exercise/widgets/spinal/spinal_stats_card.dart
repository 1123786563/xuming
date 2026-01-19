import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class SpinalStatsCard extends StatelessWidget {
  const SpinalStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Rotation Degree
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF26333b).withOpacity(0.2), // Keeping theme specific color for now or replace with AppColor if available
              border: Border.all(color: const Color(0xFF26333b)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ROTATION_DEGREE",
                      style: AppTypography.monoDecorative.copyWith(
                        color: AppColors.industrialYellow.withOpacity(0.6),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(width: 8, height: 2, color: AppColors.industrialYellow),
                  ],
                ),
                Text(
                  "45°",
                  style: AppTypography.pixelHeadline.copyWith(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.keyboard_double_arrow_up, color: AppColors.industrialYellow, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      "MAX_TORQUE",
                      style: AppTypography.monoDecorative.copyWith(
                        color: AppColors.industrialYellow,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Torsion Level
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF26333b).withOpacity(0.2),
              border: Border.all(color: const Color(0xFF26333b)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TORSION_LEVEL",
                  style: AppTypography.monoDecorative.copyWith(
                    color: AppColors.industrialYellow.withOpacity(0.6),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "HIGH",
                  style: AppTypography.pixelHeadline.copyWith(
                    color: AppColors.industrialYellow,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(child: Container(height: 4, color: AppColors.industrialYellow, margin: const EdgeInsets.only(right: 2))),
                    Expanded(child: Container(height: 4, color: AppColors.industrialYellow, margin: const EdgeInsets.only(right: 2))),
                    Expanded(child: Container(height: 4, color: AppColors.industrialYellow, margin: const EdgeInsets.only(right: 2))),
                    Expanded(child: Container(height: 4, color: AppColors.industrialYellow.withOpacity(0.2))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
