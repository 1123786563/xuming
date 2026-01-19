import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// 六边形硬币组件
class HexagonCoin extends StatelessWidget {
  final double size;
  final Widget? child;

  const HexagonCoin({
    super.key,
    this.size = 200,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.lifeSignal.withOpacity(0.3),
            blurRadius: 50,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 外圈装饰管 (仿 ping 动画通过外部容器控制，这里只画静态)
          _HexagonShape(
            size: size,
            color: AppColors.lifeSignal.withOpacity(0.2),
            isOutline: true,
            strokeWidth: 1,
          ),
          // 核心硬币
          _HexagonShape(
            size: size * 0.85,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.lifeSignal,
                Color(0xFF04A68B),
                AppColors.void_,
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              child: _HexagonShape(
                size: double.infinity,
                color: AppColors.void_,
                child: Center(
                  child: child ??
                      const Icon(
                        Icons.dangerous,
                        color: AppColors.lifeSignal,
                        size: 80,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HexagonShape extends StatelessWidget {
  final double size;
  final Color? color;
  final Gradient? gradient;
  final Widget? child;
  final bool isOutline;
  final double strokeWidth;

  const _HexagonShape({
    required this.size,
    this.color,
    this.gradient,
    this.child,
    this.isOutline = false,
    this.strokeWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipPath(
        clipper: _HexagonClipper(),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            gradient: gradient,
            border: isOutline
                ? null // ClipPath 无法直接渲染 border，需要通过 CustomPainter 如果需要精细线框
                : null,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;

    path.moveTo(width * 0.25, 0);
    path.lineTo(width * 0.75, 0);
    path.lineTo(width, height * 0.5);
    path.lineTo(width * 0.75, height);
    path.lineTo(width * 0.25, height);
    path.lineTo(0, height * 0.5);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
