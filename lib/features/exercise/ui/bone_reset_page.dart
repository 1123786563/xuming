import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import 'base_exercise_page.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/services/audio_service.dart';

/// 音效同步-骨骼复位执行页 - 使用基类重构
class BoneResetPage extends ConsumerWidget {
  const BoneResetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const BaseExercisePage(
      title: AppStrings.boneResetTitle,
      taskName: AppStrings.boneResetTask,
      procedureId: "SIGNAL_SYNC_0X22",
      themeColor: Color(0xFF00E6FF),
      quote: AppStrings.boneResetQuote,
      durationSeconds: 45,
      visualFeedback: _BoneVisuals(),
    );
  }
}

class _BoneVisuals extends StatefulWidget {
  const _BoneVisuals();

  @override
  State<_BoneVisuals> createState() => _BoneVisualsState();
}

class _BoneVisualsState extends State<_BoneVisuals> with SingleTickerProviderStateMixin {
  late AnimationController _oscController;

  @override
  void initState() {
    super.initState();
    _oscController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _oscController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTechLabels(),
        const SizedBox(height: 20),
        Expanded(child: _buildCentralVisualizer()),
      ],
    );
  }

  Widget _buildTechLabels() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMarkerText("AUDIO_FEEDBACK_LOCKED", "MODE: BONE_RESONANCE", alignment: CrossAxisAlignment.start, color: const Color(0xFF00E6FF)),
          _buildMarkerText("HAPTIC_SYNC_ENABLED", "LATENCY: 0.002ms", alignment: CrossAxisAlignment.end, color: const Color(0xFFA3FF00)),
        ],
      ),
    );
  }

  Widget _buildMarkerText(String label, String value, {required CrossAxisAlignment alignment, required Color color}) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(label, style: TextStyle(color: color.withOpacity(0.5), fontSize: 9, fontFamily: 'monospace')),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            border: Border(
              left: alignment == CrossAxisAlignment.start ? BorderSide(color: color, width: 2) : BorderSide.none,
              right: alignment == CrossAxisAlignment.end ? BorderSide(color: color, width: 2) : BorderSide.none,
            ),
          ),
          child: Text(value, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
        ),
      ],
    );
  }

  Widget _buildCentralVisualizer() {
    return GestureDetector(
      onTap: () {
        // 点击触发骨骼复位音效
        ref.read(audioServiceProvider).playBoneClick();
      },
      child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 260,
          height: 260,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF00E6FF).withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        Image.network(
          "https://lh3.googleusercontent.com/aida-public/AB6AXuDIhCzSUbdMnu9nGqpmCpBcCfvm6M1KdYCCeQNESLFFkadZTkhhZWeiVl91Y6SuZ4bW6RKB6qZ3H2Q2SagDPZUG2kJcY8AyIi0Gs4rBn0mYr1Yo9x6BZvJGknhE0PQvK75mCJbtvte75bQOwBXIR_u_Yr7Mn61gTKdPzix3GrLBmyskMPAJYVe1QXs7ZVoh1oUk65OI4GHP7JTETJFGREi1m4HwP7kmCGodgqPpDVJO9asxezCK62XTgsKyMBfiGavBNamaCen3XkY",
          height: 240,
          fit: BoxFit.contain,
          color: const Color(0xFF00E6FF).withOpacity(0.6),
          colorBlendMode: BlendMode.srcIn,
        ),
        Positioned(
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: CustomPaint(
              painter: OscilloscopePainter(animationValue: _oscController.value),
            ),
          ),
        ),
        const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             _GlitchText(text: "CRACK"),
             SizedBox(height: 8),
             Text(
              "ALIGNMENT_SUCCESS",
              style: TextStyle(color: Color(0xFF00E6FF), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
          ],
        ),
      ],
    );
  }
}

class OscilloscopePainter extends CustomPainter {
  final double animationValue;
  OscilloscopePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00E6FF).withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    final double midY = size.height / 2;
    
    path.moveTo(0, midY);
    for (double i = 0; i < size.width; i++) {
      final double angle = (i / size.width * 2 * math.pi * 4) + (animationValue * 2 * math.pi);
      final double distFromCenter = (i - size.width/2).abs();
      final double multiplier = math.max(0, 1 - distFromCenter / (size.width * 0.4));
      
      double y = midY + math.sin(angle) * 15 * multiplier;
      
      if (i > size.width * 0.45 && i < size.width * 0.55) {
        final double pulseAngle = (i - size.width * 0.45) / (size.width * 0.1) * math.pi;
        y -= math.sin(pulseAngle) * 40 * math.sin(animationValue * 5);
      }
      
      path.lineTo(i, y);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant OscilloscopePainter oldDelegate) => true;
}

class _GlitchText extends StatelessWidget {
  final String text;
  const _GlitchText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: const Offset(-2, 0),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFFFF00C1),
              fontSize: 48,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              letterSpacing: -2,
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(2, 0),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF00FFF9),
              fontSize: 48,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              letterSpacing: -2,
            ),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            letterSpacing: -2,
          ),
        ),
      ],
    );
  }
}
