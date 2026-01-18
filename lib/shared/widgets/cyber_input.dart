import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

/// 赛博风格输入框
/// 
/// 带发光边框和前缀/后缀支持的输入组件
class CyberInput extends StatefulWidget {
  const CyberInput({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.onChanged,
    this.maxLength,
  });

  /// 控制器
  final TextEditingController? controller;
  
  /// 标签
  final String? label;
  
  /// 提示文字
  final String? hint;
  
  /// 前缀组件
  final Widget? prefix;
  
  /// 后缀组件
  final Widget? suffix;
  
  /// 键盘类型
  final TextInputType? keyboardType;
  
  /// 变更回调
  final ValueChanged<String>? onChanged;
  
  /// 最大长度
  final int? maxLength;

  @override
  State<CyberInput> createState() => _CyberInputState();
}

class _CyberInputState extends State<CyberInput> {
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标签
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 4),
            child: Text(
              widget.label!.toUpperCase(),
              style: GoogleFonts.jetBrainsMono(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: AppColors.lifeSignal.withOpacity(0.6),
              ),
            ),
          ),
        
        // 输入框容器
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColors.lifeSignal.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isFocused 
                  ? AppColors.lifeSignal 
                  : AppColors.lifeSignal.withOpacity(0.5),
              width: 1,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: AppColors.lifeSignal.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              // 前缀
              if (widget.prefix != null) widget.prefix!,
              
              // 输入框
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  keyboardType: widget.keyboardType,
                  onChanged: widget.onChanged,
                  maxLength: widget.maxLength,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                    letterSpacing: 2,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: GoogleFonts.jetBrainsMono(
                      fontSize: 14,
                      color: AppColors.lifeSignal.withOpacity(0.3),
                      letterSpacing: 2,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    counterText: '',
                  ),
                ),
              ),
              
              // 后缀
              if (widget.suffix != null) widget.suffix!,
            ],
          ),
        ),
      ],
    );
  }
}

/// 赛博风格前缀
/// 
/// 例如 "[ +86 ]" 样式
class CyberPrefix extends StatelessWidget {
  const CyberPrefix({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        '[ $text ]',
        style: GoogleFonts.jetBrainsMono(
          fontSize: 14,
          color: AppColors.lifeSignal.withOpacity(0.8),
        ),
      ),
    );
  }
}

/// 获取验证码按钮
class GetCodeButton extends StatelessWidget {
  const GetCodeButton({
    super.key,
    required this.onPressed,
    this.countdown = 0,
  });

  final VoidCallback? onPressed;
  final int countdown;

  @override
  Widget build(BuildContext context) {
    final isDisabled = countdown > 0;
    
    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.lifeSignal.withOpacity(0.1),
          border: Border.all(
            color: AppColors.lifeSignal,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          isDisabled ? '${countdown}s' : 'GET_CODE',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: isDisabled 
                ? AppColors.textSecondary 
                : AppColors.lifeSignal,
          ),
        ),
      ),
    );
  }
}
