import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// 故障艺术文字组件
/// 
/// 实现 RGB 分离和随机偏移的赛博朋克文字效果
class GlitchText extends StatefulWidget {
  const GlitchText({
    super.key,
    required this.text,
    this.style,
    this.isActive = true,
    this.glitchIntensity = 1.0,
  });

  /// 显示的文字
  final String text;
  
  /// 文字样式
  final TextStyle? style;
  
  /// 是否激活故障效果
  final bool isActive;
  
  /// 故障强度 (0.0 - 2.0)
  final double glitchIntensity;

  @override
  State<GlitchText> createState() => _GlitchTextState();
}

class _GlitchTextState extends State<GlitchText> {
  Timer? _timer;
  double _offsetX = 0;
  double _offsetY = 0;
  bool _showGlitch = false;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      _startGlitchTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startGlitchTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_random.nextDouble() < 0.15 * widget.glitchIntensity) {
        setState(() {
          _showGlitch = true;
          _offsetX = (_random.nextDouble() - 0.5) * 4 * widget.glitchIntensity;
          _offsetY = (_random.nextDouble() - 0.5) * 2 * widget.glitchIntensity;
        });
        
        // 快速恢复
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            setState(() {
              _showGlitch = false;
              _offsetX = 0;
              _offsetY = 0;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = widget.style ?? const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    );

    if (!widget.isActive || !_showGlitch) {
      return Text(widget.text, style: baseStyle);
    }

    return Stack(
      children: [
        // 红色通道 - 向左偏移
        Transform.translate(
          offset: Offset(-2 * widget.glitchIntensity + _offsetX, _offsetY),
          child: Text(
            widget.text,
            style: baseStyle.copyWith(
              color: AppColors.nuclearWarning.withOpacity(0.7),
            ),
          ),
        ),
        // 青色通道 - 向右偏移
        Transform.translate(
          offset: Offset(2 * widget.glitchIntensity + _offsetX, -_offsetY),
          child: Text(
            widget.text,
            style: baseStyle.copyWith(
              color: AppColors.lifeSignal.withOpacity(0.7),
            ),
          ),
        ),
        // 主文字
        Text(widget.text, style: baseStyle),
      ],
    );
  }
}
