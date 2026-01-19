import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'base_exercise_page.dart';

/// 隐形练腹指引页 (Variant 2) - 使用基类重构
class StealthStomachVacuumPage extends ConsumerWidget {
  const StealthStomachVacuumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const BaseExercisePage(
      title: "腹部系统压缩",
      taskName: "STOMACH VACUUM ACTIVE",
      procedureId: "VAC_SYSTEM_X9",
      themeColor: Color(0xFF2B4F73),
      quote: "Build your core while you build that useless PowerPoint.",
      durationSeconds: 30,
      visualFeedback: _StealthVisuals(),
    );
  }
}

class _StealthVisuals extends StatefulWidget {
  const _StealthVisuals();

  @override
  State<_StealthVisuals> createState() => _StealthVisualsState();
}

class _StealthVisualsState extends State<_StealthVisuals> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildRadarBackground(),
        _buildCentralVisual(),
      ],
    );
  }

  Widget _buildRadarBackground() {
    return Opacity(
      opacity: 0.15,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 300, height: 300,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF2B4F73), width: 1)),
          ),
          Container(
            width: 200, height: 200,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF2B4F73), width: 1)),
          ),
          Container(
            width: double.infinity, height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.transparent, Color(0x332B4F73), Colors.transparent]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCentralVisual() {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        color: const Color(0xFF2B4F73).withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF2B4F73).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(color: const Color(0xFF2B4F73).withOpacity(0.4), blurRadius: 20),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _XRayTorsoPainter(progress: _controller.value),
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  top: 60 + (140 * math.sin(_controller.value * math.pi).abs()),
                  left: 0, right: 0,
                  child: Container(
                    height: 48,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0x1A00BCD4), Colors.transparent],
                      ),
                    ),
                  ),
                );
              },
            ),
            const Positioned(
              top: 16, left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("AXIAL PLANE", style: TextStyle(color: Color(0x9900BCD4), fontSize: 8, fontWeight: FontWeight.bold)),
                  Text("T-09 ACTIVE", style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'monospace')),
                ],
              ),
            ),
            const Positioned(
              bottom: 16, right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("DEPTH METRIC", style: TextStyle(color: Color(0xFF2B4F73), fontSize: 8, fontWeight: FontWeight.bold)),
                  Text("8.2mm VAC", style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'monospace')),
                ],
              ),
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

    final backPath = Path()
      ..moveTo(size.width * 0.7, size.height * 0.1)
      ..quadraticBezierTo(size.width * 0.8, size.height * 0.5, size.width * 0.7, size.height * 0.9);
    canvas.drawPath(backPath, paint);

    final wallPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = const Color(0xFF2B4F73).withOpacity(0.15);
    final wallPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.1)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.5, size.width * 0.3, size.height * 0.9);
    canvas.drawPath(wallPath, wallPaint);

    final cyanPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF00BCD4);
    
    final contractFactor = 0.45 + (0.15 * progress);
    final corePath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.1)
      ..quadraticBezierTo(size.width * contractFactor, size.height * 0.5, size.width * 0.3, size.height * 0.9);
    canvas.drawPath(corePath, cyanPaint);

    final glowPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF2B4F73).withOpacity(0.2);
    canvas.drawCircle(center, 30, glowPaint);
  }

  @override
  bool shouldRepaint(covariant _XRayTorsoPainter oldDelegate) => oldDelegate.progress != progress;
}
