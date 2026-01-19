import 'package:flutter/material.dart';

/// 扫描线覆盖效果组件
class ScanlineOverlay extends StatelessWidget {
  final double opacity;
  final Color color;

  const ScanlineOverlay({
    super.key,
    this.opacity = 0.1,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _ScanlinePainter(opacity: opacity, color: color),
        size: Size.infinite,
      ),
    );
  }
}

class _ScanlinePainter extends CustomPainter {
  final double opacity;
  final Color color;

  _ScanlinePainter({required this.opacity, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..strokeWidth = 1.0;

    // 绘制水平扫描线
    for (double i = 0; i < size.height; i += 4) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
    
    // 绘制极淡的 RGB 垂直条纹 (可选，模拟子像素)
    final stripePaint = Paint()
      ..color = Colors.white.withOpacity(opacity * 0.2)
      ..strokeWidth = 1.0;
    
    for (double i = 0; i < size.width; i += 3) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), stripePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
