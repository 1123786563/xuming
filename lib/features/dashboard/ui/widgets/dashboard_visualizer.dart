import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class DashboardVisualizer extends StatelessWidget {
  final double hp;

  const DashboardVisualizer({
    super.key,
    required this.hp,
  });

  Color _getIndicatorColor() {
    if (hp > 60) return AppColors.lifeSignal; // Green
    if (hp > 30) return AppColors.cautionYellow; // Yellow
    return AppColors.nuclearWarning; // Red
  }

  @override
  Widget build(BuildContext context) {
    final indicatorColor = _getIndicatorColor();

    return Stack(
      children: [
        // Main Container Frame
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF050505),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFF1C3617)),
          ),
          child: Stack(
            children: [
               // Background Grid
              Positioned.fill(
                child: CustomPaint(
                  painter: _GridPatternPainter(),
                ),
              ),
              
              // 3D Model Placeholder / Image
              Center(
                 child: Opacity(
                   opacity: 0.8,
                   child: Icon(
                     Icons.accessibility_new_rounded,
                     size: 300,
                     color: AppColors.primary.withOpacity(0.2),
                   ),
                 ),
              ),

              // Heat Map: Neck
              Positioned(
                top: 150, 
                left: 0, 
                right: 0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 120),
                    child: _HeatMapIndicator(
                      size: 80,
                      color: indicatorColor, // Dynamic color
                      isLarge: false,
                    ),
                  ),
                ),
              ),
               // Better positioning using Align
               Align(
                 alignment: const Alignment(0, -0.6), // Neck area
                 child: _HeatMapIndicator(
                    size: 80,
                    color: indicatorColor, // Dynamic color
                    isLarge: false,
                 ),
               ),
               Align(
                 alignment: const Alignment(0, 0.4), // Lower back area
                 child: _HeatMapIndicator(
                    size: 120,
                    color: indicatorColor, // Dynamic color
                    isLarge: true,
                 ),
               ),
            ],
          ),
        ),

        // Corner Decorations
        const Positioned(top: 0, left: 0, child: _Corner(isTop: true, isLeft: true)),
        const Positioned(top: 0, right: 0, child: _Corner(isTop: true, isLeft: false)),
        const Positioned(bottom: 0, left: 0, child: _Corner(isTop: false, isLeft: true)),
        const Positioned(bottom: 0, right: 0, child: _Corner(isTop: false, isLeft: false)),

        // Sys Status (Top Left)
        Positioned(
          top: 16,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SYS_STATUS',
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.primary.withOpacity(0.6),
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary,
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'ONLINE',
                    style: AppTypography.monoBody.copyWith(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Session Uptime (Top Right)
        Positioned(
          top: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'SESSION UPTIME',
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.primary.withOpacity(0.6),
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '04:22:15',
                style: AppTypography.pixelHeadline.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  shadows: [
                    const BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    )
                  ]
                ),
              ),
            ],
          ),
        ),
        
        // FAB: Emergency Repair
        Positioned(
          bottom: 24,
          right: 24,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context.push(AppRoutes.recoveryRecommendation),
              borderRadius: BorderRadius.circular(4),
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.alert, // Changed to alert per design (red)
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                  boxShadow: [
                     BoxShadow(
                        color: AppColors.alert.withOpacity(0.6),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.medical_services_outlined, color: Colors.white, size: 20),
                     const SizedBox(width: 12),
                     Text(
                      '紧急抢修',
                      style: AppTypography.monoButton.copyWith(
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Corner extends StatelessWidget {
  final bool isTop;
  final bool isLeft;

  const _Corner({required this.isTop, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    const double size = 32;
    const double thickness = 2;
    const color = AppColors.primary;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? const BorderSide(color: color, width: thickness) : BorderSide.none,
          bottom: !isTop ? const BorderSide(color: color, width: thickness) : BorderSide.none,
          left: isLeft ? const BorderSide(color: color, width: thickness) : BorderSide.none,
          right: !isLeft ? const BorderSide(color: color, width: thickness) : BorderSide.none,
        ),
      ),
    );
  }
}

class _HeatMapIndicator extends StatefulWidget {
  final double size;
  final Color color;
  final bool isLarge;

  const _HeatMapIndicator({required this.size, required this.color, this.isLarge = false});

  @override
  State<_HeatMapIndicator> createState() => _HeatMapIndicatorState();
}

class _HeatMapIndicatorState extends State<_HeatMapIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated Blob
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  width: widget.size * _animation.value,
                  height: widget.size * _animation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color.withOpacity((widget.isLarge ? 0.2 : 0.3) / _animation.value),
                    boxShadow: [
                      BoxShadow(
                        color: widget.color.withOpacity(0.5),
                        blurRadius: widget.size / 2,
                        spreadRadius: widget.size / 4,
                      ),
                    ],
                  ),
                );
              },
            ),
            // Core
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: widget.color, blurRadius: 10, spreadRadius: 2),
                ],
              ),
            ),
            // Decorative Ring (only for large)
            if (widget.isLarge)
              Container(
                width: widget.size * 0.5,
                height: widget.size * 0.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: widget.color.withOpacity(0.3)),
                ),
              ),
             // Crosshair (only for small)
             if (!widget.isLarge) ...[
                Container(width: widget.size * 0.6, height: 1, color: widget.color.withOpacity(0.4)),
                Container(width: 1, height: widget.size * 0.6, color: widget.color.withOpacity(0.4)),
             ] 
          ],
        ),
      );
  }
}

class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.05)
      ..strokeWidth = 1;

    const gridSize = 20.0;
    
    // 垂直线
    for (var x = 0.0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    
    // 水平线
    for (var y = 0.0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
