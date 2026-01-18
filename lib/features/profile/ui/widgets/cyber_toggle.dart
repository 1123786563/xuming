import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// 赛博风格开关组件
class CyberToggle extends StatefulWidget {
  const CyberToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 48,
    this.height = 24,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;

  @override
  State<CyberToggle> createState() => _CyberToggleState();
}

class _CyberToggleState extends State<CyberToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
      value: widget.value ? 1.0 : 0.0,
    );
    
    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    _colorAnimation = ColorTween(
      begin: AppColors.textDecorative,
      end: AppColors.lifeSignal,
    ).animate(_controller);
  }

  @override
  void didUpdateWidget(CyberToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onChanged(!widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final thumbWidth = widget.width * 0.4;
    
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: AppColors.void_,
              border: Border.all(
                color: _colorAnimation.value ?? AppColors.textDecorative,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Stack(
              children: [
                // 背景发光效果
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: (_colorAnimation.value ?? AppColors.textDecorative)
                          .withOpacity(0.2 * _controller.value),
                    ),
                  ),
                ),
                
                // 滑块
                Positioned(
                  left: _slideAnimation.value * (widget.width - thumbWidth - 4) + 2,
                  top: 2,
                  child: Container(
                    width: thumbWidth,
                    height: widget.height - 4,
                    decoration: BoxDecoration(
                      color: _colorAnimation.value,
                      boxShadow: widget.value
                          ? [
                              BoxShadow(
                                color: AppColors.lifeSignal.withOpacity(0.8),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ]
                          : null,
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
