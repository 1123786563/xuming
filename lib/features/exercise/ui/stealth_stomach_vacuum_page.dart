import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// 隐形练腹指引页 (Variant 2)
class StealthStomachVacuumPage extends StatefulWidget {
  const StealthStomachVacuumPage({super.key});

  @override
  State<StealthStomachVacuumPage> createState() => _StealthStomachVacuumPageState();
}

class _StealthStomachVacuumPageState extends State<StealthStomachVacuumPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isBossMode = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Radar Background Decor
          _buildRadarBackground(),

          // 2. Main Content
          SafeArea(
            child: Column(
              children: [
                _buildTopAppBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        _buildHeadline(),
                        const SizedBox(height: 48),
                        _buildCentralVisual(),
                        const SizedBox(height: 48),
                        _buildProgressIndicator(),
                        const SizedBox(height: 40),
                        _buildQuoteText(),
                      ],
                    ),
                  ),
                ),
                _buildBottomControl(),
              ],
            ),
          ),

          // 3. Screen Overlay
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadarBackground() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.15,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF2B4F73), width: 1),
              ),
            ),
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF2B4F73), width: 1),
              ),
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF2B4F73), width: 1),
              ),
            ),
            // Horizontal Radar Line
            Container(
              width: double.infinity,
              height: 1,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Color(0x332B4F73), Colors.transparent],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.biotech, color: Color(0xFF2B4F73), size: 28),
          ),
          Column(
            children: [
              Text(
                "CURRENT PROTOCOL",
                style: AppTypography.monoDecorative.copyWith(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 10,
                  letterSpacing: 2,
                ),
              ),
              const Text(
                "隐蔽修复中",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Icon(
              Icons.visibility_off,
              color: Colors.white.withOpacity(0.6),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline() {
    return Column(
      children: [
        const Text(
          "腹部系统压缩",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
            ).animatePulse(),
            const SizedBox(width: 8),
            Text(
              "STOMACH VACUUM ACTIVE",
              style: AppTypography.monoDecorative.copyWith(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 10,
                letterSpacing: 3,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCentralVisual() {
    return Container(
      width: 320,
      height: 320,
      decoration: BoxDecoration(
        color: const Color(0xFF2B4F73).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF2B4F73).withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2B4F73).withValues(alpha: 0.4),
            blurRadius: 20,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // X-Ray Painter
            Positioned.fill(
              child: CustomPaint(
                painter: _XRayTorsoPainter(progress: _controller.value),
              ),
            ),
            // Scanner Line
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  top: 80 + (160 * math.sin(_controller.value * math.pi).abs()),
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          const Color(0x1A00BCD4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // HUD Text
            Positioned(
              top: 16,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AXIAL PLANE",
                    style: TextStyle(
                      color: const Color(0x9900BCD4),
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "T-09 ACTIVE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "DEPTH METRIC",
                    style: TextStyle(
                      color: Color(0xFF2B4F73),
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "8.2mm VAC",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "COMPRESSION DEPTH",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const Text(
                  "85%",
                  style: TextStyle(
                    color: Color(0xFF00BCD4),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.85,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2B4F73), Color(0xFF00BCD4)],
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ABDOMINAL SYSTEM ACTIVE",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontSize: 10,
                    fontFamily: 'monospace',
                    letterSpacing: -0.5,
                  ),
                ),
                const Text(
                  "SYNCHRONIZED",
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
          children: [
            const TextSpan(text: "\"Build your core while you build that useless "),
            TextSpan(
              text: "PowerPoint",
              style: const TextStyle(color: Color(0xFF2B4F73), fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: ".\""),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildBottomControl() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF2B4F73).withOpacity(0.1),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: const Color(0xFF2B4F73).withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2B4F73),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.security, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 12),
                Text(
                  "STEALTH MODE",
                  style: AppTypography.monoDecorative.copyWith(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "BOSS MODE",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 9,
                  ),
                ),
                const SizedBox(width: 8),
                Switch(
                  value: _isBossMode,
                  onChanged: (v) => setState(() => _isBossMode = v),
                  activeColor: Colors.white.withOpacity(0.2),
                  activeTrackColor: Colors.white.withOpacity(0.1),
                  inactiveThumbColor: Colors.white.withOpacity(0.2),
                  inactiveTrackColor: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _XRayTorsoPainter extends CustomPainter {
  final double progress;
  _XRayTorsoPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = const Color(0xFF2B4F73).withOpacity(0.4);

    final center = Offset(size.width / 2, size.height / 2);

    // 1. Back Profile
    final backPath = Path()
      ..moveTo(size.width * 0.7, size.height * 0.1)
      ..quadraticBezierTo(size.width * 0.8, size.height * 0.5, size.width * 0.7, size.height * 0.9);
    canvas.drawPath(backPath, paint);

    // 2. Spine (Dashed)
    final spinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFF2B4F73).withOpacity(0.2);
    _drawDashedPath(canvas, Offset(size.width * 0.65, size.height * 0.15), Offset(size.width * 0.65, size.height * 0.85), spinePaint);

    // 3. Abdominal Wall (Static Outline)
    final wallPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = const Color(0xFF2B4F73).withOpacity(0.15);
    final wallPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.1)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.5, size.width * 0.3, size.height * 0.9);
    canvas.drawPath(wallPath, wallPaint);

    // 4. Contracted Core (Animated)
    final cyanPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF00BCD4);
    
    // contract factor moves from 0.45 to 0.6
    final contractFactor = 0.45 + (0.15 * progress);
    final corePath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.1)
      ..quadraticBezierTo(size.width * contractFactor, size.height * 0.5, size.width * 0.3, size.height * 0.9);
    canvas.drawPath(corePath, cyanPaint);

    // 5. Internal Organ Glow
    final glowPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF2B4F73).withOpacity(0.2);
    canvas.drawCircle(center, 30, glowPaint);
  }

  void _drawDashedPath(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double currentY = start.dy;
    while (currentY < end.dy) {
      canvas.drawLine(Offset(start.dx, currentY), Offset(start.dx, currentY + dashWidth), paint);
      currentY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _XRayTorsoPainter oldDelegate) => oldDelegate.progress != progress;
}

extension _PulseExtension on Widget {
  Widget animatePulse() {
    return _PulseAnimation(child: this);
  }
}

class _PulseAnimation extends StatefulWidget {
  final Widget child;
  const _PulseAnimation({required this.child});

  @override
  State<_PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<_PulseAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}
