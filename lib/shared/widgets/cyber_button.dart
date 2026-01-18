import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// 赛博风格按钮
/// 
/// 带发光效果和下沉反馈的高级按钮组件
class CyberButton extends StatefulWidget {
  const CyberButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.lifeSignal,
    this.width,
    this.height = 56,
    this.isLoading = false,
    this.isOutlined = false,
  });

  /// 按钮文字
  final String text;
  
  /// 点击回调
  final VoidCallback? onPressed;
  
  /// 按钮主色
  final Color color;
  
  /// 宽度（默认填满）
  final double? width;
  
  /// 高度
  final double height;
  
  /// 是否加载中
  final bool isLoading;
  
  /// 是否为边框样式
  final bool isOutlined;

  @override
  State<CyberButton> createState() => _CyberButtonState();
}

class _CyberButtonState extends State<CyberButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.isLoading ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.width,
        height: widget.height,
        // 下沉效果
        transform: Matrix4.translationValues(0, _isPressed ? 2 : 0, 0),
        decoration: BoxDecoration(
          color: widget.isOutlined 
              ? Colors.transparent 
              : (_isPressed ? widget.color.withOpacity(0.8) : widget.color),
          borderRadius: BorderRadius.circular(4),
          border: widget.isOutlined 
              ? Border.all(color: widget.color, width: 2)
              : null,
          // 发光效果
          boxShadow: _isPressed ? [] : [
            BoxShadow(
              color: widget.color.withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 2,
            ),
            BoxShadow(
              color: widget.color.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: widget.isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: widget.isOutlined ? widget.color : AppColors.void_,
                  ),
                )
              : Text(
                  widget.text.toUpperCase(),
                  style: AppTypography.monoButton.copyWith(
                    color: widget.isOutlined ? widget.color : AppColors.void_,
                  ),
                ),
        ),
      ),
    );
  }
}
