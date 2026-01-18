import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// 统计卡片组件
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String? subValue;
  final bool fullWidth;
  final Color? color;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.subValue,
    this.fullWidth = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.void_,
        border: Border.all(color: (color ?? AppColors.lifeSignal).withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          // 左侧装饰条
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 4,
              color: (color ?? AppColors.lifeSignal).withOpacity(0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: AppTypography.monoLabel.copyWith(
                    color: (color ?? AppColors.lifeSignal).withOpacity(0.7),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      value,
                      style: AppTypography.pixelData.copyWith(
                        fontSize: 24,
                        color: color ?? AppColors.lifeSignal,
                      ),
                    ),
                    if (subValue != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        subValue!,
                        style: AppTypography.monoLabel.copyWith(
                          color: (color ?? AppColors.lifeSignal).withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
