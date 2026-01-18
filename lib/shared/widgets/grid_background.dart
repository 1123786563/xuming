import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// 网格背景组件
/// 
/// 赛博朋克风格的发光网格背景
class GridBackground extends StatelessWidget {
  const GridBackground({
    super.key,
    this.gridSize = 32,
    this.lineColor,
    this.lineOpacity = 0.07,
    this.showVignette = false,
  });

  /// 网格大小
  final double gridSize;
  
  /// 线条颜色
  final Color? lineColor;
  
  /// 线条透明度
  final double lineOpacity;
  
  /// 是否显示CRT暗角
  final bool showVignette;

  @override
  Widget build(BuildContext context) {
    final color = lineColor ?? AppColors.lifeSignal;
    
    return Stack(
      children: [
        // 网格图案
        Positioned.fill(
          child: CustomPaint(
            painter: _GridPainter(
              gridSize: gridSize,
              lineColor: color.withOpacity(lineOpacity),
            ),
          ),
        ),
        
        // CRT 暗角效果
        if (showVignette)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [
                    Colors.transparent,
                    AppColors.void_.withOpacity(0.8),
                  ],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// 网格绘制器
class _GridPainter extends CustomPainter {
  _GridPainter({
    required this.gridSize,
    required this.lineColor,
  });

  final double gridSize;
  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;

    // 绘制垂直线
    for (var x = 0.0; x < size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // 绘制水平线
    for (var y = 0.0; y < size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.gridSize != gridSize ||
        oldDelegate.lineColor != lineColor;
  }
}

/// 点阵背景组件
/// 
/// 登录页使用的点阵图案背景
class DotsBackground extends StatelessWidget {
  const DotsBackground({
    super.key,
    this.dotSpacing = 30,
    this.dotSize = 1,
    this.dotColor,
    this.opacity = 0.05,
  });

  /// 点间距
  final double dotSpacing;
  
  /// 点大小
  final double dotSize;
  
  /// 点颜色
  final Color? dotColor;
  
  /// 透明度
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Opacity(
        opacity: opacity,
        child: CustomPaint(
          painter: _DotsPainter(
            dotSpacing: dotSpacing,
            dotSize: dotSize,
            dotColor: dotColor ?? AppColors.lifeSignal,
          ),
        ),
      ),
    );
  }
}

/// 点阵绘制器
class _DotsPainter extends CustomPainter {
  _DotsPainter({
    required this.dotSpacing,
    required this.dotSize,
    required this.dotColor,
  });

  final double dotSpacing;
  final double dotSize;
  final Color dotColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;

    for (var x = 0.0; x < size.width; x += dotSpacing) {
      for (var y = 0.0; y < size.height; y += dotSpacing) {
        canvas.drawCircle(Offset(x, y), dotSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotsPainter oldDelegate) {
    return oldDelegate.dotSpacing != dotSpacing ||
        oldDelegate.dotSize != dotSize ||
        oldDelegate.dotColor != dotColor;
  }
}
