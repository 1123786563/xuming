import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// 退出按钮组件
/// 
/// 红色警告风格的 SYSTEM SHUTDOWN 按钮
class LogoutButton extends StatefulWidget {
  const LogoutButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 56,
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.nuclearWarning.withOpacity(0.1)
                : Colors.transparent,
            border: Border.all(
              color: _isHovered
                  ? AppColors.nuclearWarning
                  : AppColors.nuclearWarning.withOpacity(0.6),
            ),
          ),
          child: Stack(
            children: [
              // 扫描线背景
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.nuclearWarning.withOpacity(0.05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              
              // 主内容
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 脉冲图标
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Icon(
                          Icons.power_settings_new,
                          color: AppColors.nuclearWarning.withOpacity(
                            0.5 + 0.5 * _pulseController.value,
                          ),
                          size: 24,
                        );
                      },
                    ),
                    
                    const SizedBox(width: 12),
                    
                    const Text(
                      'SYSTEM SHUTDOWN (LOGOUT)',
                      style: TextStyle(
                        fontFamily: 'ZpixFont',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: AppColors.nuclearWarning,
                      ),
                    ),
                  ],
                ),
              ),
              
              // 角落装饰
              const Positioned(
                top: 0,
                left: 0,
                child: _CornerDecor(isTopLeft: true),
              ),
              const Positioned(
                bottom: 0,
                right: 0,
                child: _CornerDecor(isTopLeft: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CornerDecor extends StatelessWidget {
  const _CornerDecor({required this.isTopLeft});
  
  final bool isTopLeft;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 8,
      height: 8,
      child: CustomPaint(
        painter: _CornerPainter(isTopLeft: isTopLeft),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  _CornerPainter({required this.isTopLeft});
  
  final bool isTopLeft;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.nuclearWarning
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    
    if (isTopLeft) {
      canvas.drawLine(Offset.zero, Offset(0, size.height), paint);
      canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);
    } else {
      canvas.drawLine(Offset(size.width, 0), Offset(size.width, size.height), paint);
      canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
