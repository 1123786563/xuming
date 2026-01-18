import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SegmentedHealthBar extends StatelessWidget {
  final double current;
  final double max;

  const SegmentedHealthBar({
    super.key,
    required this.current,
    this.max = 100,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate percentage 0.0 to 1.0
    final double percentage = (current / max).clamp(0.0, 1.0);

    return Container(
      height: 16,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0A1409),
        border: Border.all(color: const Color(0xFF1C3617)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Stack(
        children: [
          // Glowing Fill
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth * percentage,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              );
            },
          ),
          // Segmentation Mask
          Row(
            children: List.generate(10, (index) {
              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: index < 9
                          ? BorderSide(color: Colors.black.withOpacity(0.8), width: 1)
                          : BorderSide.none,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
