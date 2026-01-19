import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// 赛博朋克风格装饰组件库
class CyberCorner extends StatelessWidget {
  final bool isTop;
  final bool isLeft;
  final double size;
  final Color? color;
  final double strokeWidth;

  const CyberCorner({
    super.key,
    required this.isTop,
    required this.isLeft,
    this.size = 12,
    this.color,
    this.strokeWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.lifeSignal;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? BorderSide(color: effectiveColor, width: strokeWidth) : BorderSide.none,
          bottom: !isTop ? BorderSide(color: effectiveColor, width: strokeWidth) : BorderSide.none,
          left: isLeft ? BorderSide(color: effectiveColor, width: strokeWidth) : BorderSide.none,
          right: !isLeft ? BorderSide(color: effectiveColor, width: strokeWidth) : BorderSide.none,
        ),
      ),
    );
  }
}

/// 脉冲光环标记
class CyberPulseMarker extends StatelessWidget {
  final Animation<double> animation;
  final Color color;
  final double size;

  const CyberPulseMarker({
    super.key,
    required this.animation,
    this.color = AppColors.lifeSignal,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 脉冲环
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Container(
              width: size * animation.value + (size * 0.4),
              height: size * animation.value + (size * 0.4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: color.withOpacity(1 - animation.value),
                  width: 1.5,
                ),
              ),
            );
          },
        ),
        // 中心点
        Container(
          width: size * 0.25,
          height: size * 0.25,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: color, blurRadius: 15, spreadRadius: 2),
            ],
          ),
        ),
      ],
    );
  }
}

/// 带有连接线的 HUD 标签
class CyberHudLabel extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const CyberHudLabel({
    super.key,
    required this.label,
    required this.value,
    this.color = AppColors.lifeSignal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        border: Border(left: BorderSide(color: color, width: 2)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontFamily: 'JetBrains Mono',
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 8,
              fontFamily: 'JetBrains Mono',
            ),
          ),
        ],
      ),
    );
  }
}
