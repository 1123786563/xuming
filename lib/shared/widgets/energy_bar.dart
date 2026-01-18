import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// HP 能量槽组件
/// 
/// 格状填充、呼吸动效的生命值显示
class EnergyBar extends StatefulWidget {
  const EnergyBar({
    super.key,
    required this.value,
    this.maxValue = 100,
    this.segments = 10,
    this.width,
    this.height = 24,
    this.showLabel = true,
  });

  /// 当前值
  final double value;
  
  /// 最大值
  final double maxValue;
  
  /// 格子数量
  final int segments;
  
  /// 宽度
  final double? width;
  
  /// 高度
  final double height;
  
  /// 是否显示数值标签
  final bool showLabel;

  @override
  State<EnergyBar> createState() => _EnergyBarState();
}

class _EnergyBarState extends State<EnergyBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getBarColor() {
    final percentage = widget.value / widget.maxValue;
    if (percentage <= 0.25) {
      return AppColors.nuclearWarning;
    } else if (percentage <= 0.5) {
      return AppColors.cautionYellow;
    } else {
      return AppColors.lifeSignal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (widget.value / widget.maxValue).clamp(0.0, 1.0);
    final filledSegments = (percentage * widget.segments).floor();
    final barColor = _getBarColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showLabel)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'HP',
                  style: TextStyle(
                    fontFamily: 'ZpixFont',
                    fontSize: 12,
                    color: barColor,
                  ),
                ),
                Text(
                  '${widget.value.toInt()}/${widget.maxValue.toInt()}',
                  style: TextStyle(
                    fontFamily: 'ZpixFont',
                    fontSize: 12,
                    color: barColor,
                  ),
                ),
              ],
            ),
          ),
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: barColor.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Row(
                children: List.generate(widget.segments, (index) {
                  final isFilled = index < filledSegments;
                  final isLastFilled = index == filledSegments - 1;
                  
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: isFilled
                            ? barColor.withOpacity(
                                isLastFilled ? _pulseAnimation.value : 1.0)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(1),
                        boxShadow: isFilled
                            ? [
                                BoxShadow(
                                  color: barColor.withOpacity(0.5),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ],
    );
  }
}
