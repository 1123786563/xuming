import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// 动画进度条组件
/// 
/// 使用 ValueNotifier 隔离高频更新，避免触发父组件重建
class AnimatedProgressBar extends StatelessWidget {
  final ValueNotifier<double> progressNotifier;
  final Color themeColor;
  final Color? backgroundColor;
  final double height;
  final BorderRadius? borderRadius;
  final bool showGlow;

  const AnimatedProgressBar({
    super.key,
    required this.progressNotifier,
    this.themeColor = AppColors.lifeSignal,
    this.backgroundColor,
    this.height = 4,
    this.borderRadius,
    this.showGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ValueListenableBuilder<double>(
        valueListenable: progressNotifier,
        builder: (context, progress, child) {
          return Container(
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white.withOpacity(0.1),
              borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
            ),
            child: ClipRRect(
              borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: themeColor,
                        boxShadow: showGlow
                            ? [
                                BoxShadow(
                                  color: themeColor.withOpacity(0.5),
                                  blurRadius: 8,
                                  spreadRadius: 0,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// 垂直动画进度条（用于侧边栏）
class VerticalAnimatedProgressBar extends StatelessWidget {
  final ValueNotifier<double> progressNotifier;
  final Color themeColor;
  final Color? secondaryColor;
  final double width;

  const VerticalAnimatedProgressBar({
    super.key,
    required this.progressNotifier,
    this.themeColor = AppColors.lifeSignal,
    this.secondaryColor,
    this.width = 8,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ValueListenableBuilder<double>(
        valueListenable: progressNotifier,
        builder: (context, progress, child) {
          return Container(
            width: width,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(width / 2),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                FractionallySizedBox(
                  heightFactor: progress.clamp(0.01, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width / 2),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          themeColor,
                          secondaryColor ?? AppColors.cautionYellow,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
