import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// 五维雷达图组件
class RadarChart extends StatelessWidget {
  final List<double> values; // 0.0 到 1.0 的百分比值
  final List<String> labels; // 5个顶点的标签
  final double size;

  const RadarChart({
    super.key,
    required this.values,
    required this.labels,
    this.size = 260,
  }) : assert(values.length == 5 && labels.length == 5);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // 渲染图形
          CustomPaint(
            size: Size(size, size),
            painter: _RadarPainter(values: values),
          ),
          // 渲染标签
          ..._buildLabels(),
        ],
      ),
    );
  }

  List<Widget> _buildLabels() {
    final List<Widget> widgets = [];
    final double radius = size / 2;
    final double labelDistance = radius + 20;

    for (int i = 0; i < 5; i++) {
      // 这里的角度计算需要与 Painter 一致 (-pi/2 开始，顺时针)
      final double angle = (i * 2 * math.pi / 5) - (math.pi / 2);
      final double x = radius + labelDistance * math.cos(angle);
      final double y = radius + labelDistance * math.sin(angle);

      widgets.add(
        Positioned(
          left: x - 40, // 给予足够的宽度居中
          top: y - 10,
          child: Container(
            width: 80,
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.void_,
                border: Border.all(color: AppColors.lifeSignal.withOpacity(0.5), width: 0.5),
              ),
              child: Text(
                labels[i],
                style: AppTypography.monoLabel.copyWith(
                  color: AppColors.lifeSignal,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }
}

class _RadarPainter extends CustomPainter {
  final List<double> values;

  _RadarPainter({required this.values});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final gridPaint = Paint()
      ..color = const Color(0xFF1A2A17)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // 1. 绘制背景圆圈 (3个)
    canvas.drawCircle(center, radius * 1.0, gridPaint);
    canvas.drawCircle(center, radius * 0.66, gridPaint);
    canvas.drawCircle(center, radius * 0.33, gridPaint);

    // 2. 绘制轴线
    for (int i = 0; i < 5; i++) {
      final angle = (i * 2 * math.pi / 5) - (math.pi / 2);
      final axisPoint = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(center, axisPoint, gridPaint);
    }

    // 3. 绘制数据多边形
    final dataPath = Path();
    final dataPaint = Paint()
      ..color = AppColors.lifeSignal.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = AppColors.lifeSignal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final points = <Offset>[];
    for (int i = 0; i < 5; i++) {
      final angle = (i * 2 * math.pi / 5) - (math.pi / 2);
      final distance = radius * values[i];
      final point = Offset(
        center.dx + distance * math.cos(angle),
        center.dy + distance * math.sin(angle),
      );
      points.add(point);
      if (i == 0) {
        dataPath.moveTo(point.dx, point.dy);
      } else {
        dataPath.lineTo(point.dx, point.dy);
      }
    }
    dataPath.close();

    canvas.drawPath(dataPath, dataPaint);
    canvas.drawPath(dataPath, outlinePaint);

    // 4. 绘制顶点圆点
    final dotPaint = Paint()
      ..color = AppColors.lifeSignal
      ..style = PaintingStyle.fill;

    for (var point in points) {
      canvas.drawCircle(point, 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _RadarPainter oldDelegate) {
    return oldDelegate.values != values;
  }
}
