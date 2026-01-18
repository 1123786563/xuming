import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// 头像光环组件
/// 
/// 赛博朋克风格的头像展示，带多层旋转光环动画
class AvatarRing extends StatefulWidget {
  const AvatarRing({
    super.key,
    this.imageUrl,
    this.size = 160,
    this.isOnline = true,
  });

  final String? imageUrl;
  final double size;
  final bool isOnline;

  @override
  State<AvatarRing> createState() => _AvatarRingState();
}

class _AvatarRingState extends State<AvatarRing>
    with TickerProviderStateMixin {
  late AnimationController _slowRotation;
  late AnimationController _fastRotation;

  @override
  void initState() {
    super.initState();
    _slowRotation = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    
    _fastRotation = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _slowRotation.dispose();
    _fastRotation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final avatarSize = widget.size * 0.75;
    
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 外层虚线光环 - 慢速旋转
          AnimatedBuilder(
            animation: _slowRotation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _slowRotation.value * 2 * math.pi,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.lifeSignal.withOpacity(0.3),
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              );
            },
          ),
          
          // 中层点状光环 - 反向慢速旋转
          AnimatedBuilder(
            animation: _slowRotation,
            builder: (context, child) {
              return Transform.rotate(
                angle: -_slowRotation.value * 2 * math.pi * 0.66,
                child: Container(
                  width: widget.size - 16,
                  height: widget.size - 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.cautionYellow.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
              );
            },
          ),
          
          // 内层扫描光环 - 快速旋转
          AnimatedBuilder(
            animation: _fastRotation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _fastRotation.value * 2 * math.pi,
                child: CustomPaint(
                  size: Size(widget.size + 16, widget.size + 16),
                  painter: _ScanRingPainter(),
                ),
              );
            },
          ),
          
          // 头像容器
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.lifeSignal,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lifeSignal.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // 头像图片
                  if (widget.imageUrl != null)
                    Image.network(
                      widget.imageUrl!,
                      fit: BoxFit.cover,
                      color: AppColors.lifeSignal.withOpacity(0.2),
                      colorBlendMode: BlendMode.overlay,
                    )
                  else
                    Container(
                      color: AppColors.cardBackground,
                      child: Icon(
                        Icons.person,
                        size: avatarSize * 0.5,
                        color: AppColors.lifeSignal.withOpacity(0.5),
                      ),
                    ),
                  
                  // 扫描线覆盖效果
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.lifeSignal.withOpacity(0.1),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // ONLINE 状态徽章
          if (widget.isOnline)
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.void_,
                  border: Border.all(color: AppColors.lifeSignal),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lifeSignal.withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Text(
                  'ONLINE',
                  style: TextStyle(
                    fontFamily: 'ZpixFont',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: AppColors.lifeSignal,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// 扫描光环画笔
class _ScanRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..shader = SweepGradient(
        colors: [
          Colors.transparent,
          AppColors.lifeSignal,
          Colors.transparent,
        ],
        stops: const [0.0, 0.1, 0.3],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
