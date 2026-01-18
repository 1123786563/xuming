import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

/// 方块式进度条
/// 
/// 开屏页使用的系统完整性进度条
class BlockProgressBar extends StatelessWidget {
  const BlockProgressBar({
    super.key,
    required this.value,
    this.maxValue = 100,
    this.totalBlocks = 12,
    this.height = 20,
    this.label,
    this.showPercentage = true,
    this.subtitle,
  });

  /// 当前值
  final double value;
  
  /// 最大值
  final double maxValue;
  
  /// 总方块数
  final int totalBlocks;
  
  /// 高度
  final double height;
  
  /// 标签
  final String? label;
  
  /// 是否显示百分比
  final bool showPercentage;
  
  /// 副标题
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final percentage = (value / maxValue).clamp(0.0, 1.0);
    final activeBlocks = (percentage * totalBlocks).floor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标签和百分比
        if (label != null || showPercentage)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (label != null)
                  Text(
                    label!,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: AppColors.lifeSignal,
                    ),
                  ),
                if (showPercentage)
                  Text(
                    '${(percentage * 100).toInt()}%',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lifeSignal,
                      shadows: [
                        Shadow(
                          color: AppColors.lifeSignal.withOpacity(0.8),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        
        // 方块进度条
        Row(
          children: List.generate(totalBlocks, (index) {
            final isActive = index < activeBlocks;
            final isLoading = index >= activeBlocks && index < activeBlocks + 2;
            
            return Expanded(
              child: Container(
                height: height,
                margin: EdgeInsets.only(right: index < totalBlocks - 1 ? 4 : 0),
                decoration: BoxDecoration(
                  color: isActive 
                      ? AppColors.lifeSignal 
                      : (isLoading 
                          ? AppColors.lifeSignal.withOpacity(0.1 + (index - activeBlocks) * 0.1)
                          : AppColors.lifeSignal.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(2),
                  border: isLoading || !isActive
                      ? Border.all(
                          color: AppColors.lifeSignal.withOpacity(0.2 + (isLoading ? 0.1 : 0)),
                          width: 1,
                        )
                      : null,
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppColors.lifeSignal.withOpacity(0.6),
                            blurRadius: 8,
                            spreadRadius: 0,
                          ),
                        ]
                      : null,
                ),
              ),
            );
          }),
        ),
        
        // 副标题
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                subtitle!,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: AppColors.lifeSignal.withOpacity(0.7),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
