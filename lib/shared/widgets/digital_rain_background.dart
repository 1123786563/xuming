import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// 数字雨背景组件
class DigitalRainBackground extends StatefulWidget {
  final double opacity;

  const DigitalRainBackground({
    super.key,
    this.opacity = 0.2,
  });

  @override
  State<DigitalRainBackground> createState() => _DigitalRainBackgroundState();
}

class _DigitalRainBackgroundState extends State<DigitalRainBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_RainDrop> _drops = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initDrops(Size size) {
    if (_drops.isNotEmpty) return;
    final columnCount = (size.width / 20).floor();
    for (int i = 0; i < columnCount; i++) {
      _drops.add(_RainDrop(
        x: i * 20.0,
        y: _random.nextDouble() * size.height,
        speed: 2.0 + _random.nextDouble() * 5.0,
        chars: List.generate(10 + _random.nextInt(20), (_) => _getRandomChar()),
      ));
    }
  }

  String _getRandomChar() {
    const chars = '0123456789ABCDEFHIJKLMNOPQRSTUVWXYZ!@#\$%^&*()';
    return chars[_random.nextInt(chars.length)];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _initDrops(size);

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            for (var drop in _drops) {
              drop.update(size.height);
            }
            return CustomPaint(
              painter: _DigitalRainPainter(
                drops: _drops,
                opacity: widget.opacity,
              ),
              size: size,
            );
          },
        );
      },
    );
  }
}

class _RainDrop {
  double x;
  double y;
  double speed;
  List<String> chars;

  _RainDrop({
    required this.x,
    required this.y,
    required this.speed,
    required this.chars,
  });

  void update(double maxHeight) {
    y += speed;
    if (y > maxHeight + (chars.length * 20)) {
      y = -chars.length * 20.0;
    }
  }
}

class _DigitalRainPainter extends CustomPainter {
  final List<_RainDrop> drops;
  final double opacity;

  _DigitalRainPainter({
    required this.drops,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: AppColors.lifeSignal.withOpacity(opacity),
      fontSize: 14,
      fontFamily: 'Zpix', // 假设项目中已配置该像素字体
      fontWeight: FontWeight.bold,
    );

    for (var drop in drops) {
      for (int i = 0; i < drop.chars.length; i++) {
        final charOpacity = (1.0 - (i / drop.chars.length)) * opacity;
        final span = TextSpan(
          text: drop.chars[i],
          style: textStyle.copyWith(
            color: AppColors.lifeSignal.withOpacity(charOpacity),
            shadows: i == 0
                ? [
                    const Shadow(
                      color: AppColors.lifeSignal,
                      blurRadius: 10,
                    )
                  ]
                : null,
          ),
        );

        final tp = TextPainter(
          text: span,
          textDirection: TextDirection.ltr,
        );
        tp.layout();
        tp.paint(canvas, Offset(drop.x, drop.y - (i * 20)));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
