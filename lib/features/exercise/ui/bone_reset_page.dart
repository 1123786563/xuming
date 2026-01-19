import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import 'dart:async';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../../shared/widgets/grid_background.dart';

/// 音效同步-骨骼复位执行页
class BoneResetPage extends StatefulWidget {
  const BoneResetPage({super.key});

  @override
  State<BoneResetPage> createState() => _BoneResetPageState();
}

class _BoneResetPageState extends State<BoneResetPage> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _oscController;
  late Timer _timer;
  int _milliseconds = 22450; // 起始时间：22.45s
  double _vibrationIntensity = 0.8;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _oscController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (mounted) {
        setState(() {
          _milliseconds += 10;
        });
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _oscController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // 基础背景
          const GridBackground(
            lineColor: Color(0xFF00E6FF),
            lineOpacity: 0.05,
          ),
          
          // 扫描线滤镜
          const ScanlineOverlay(opacity: 0.15),

          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Column(
                    children: [
                      _buildTechLabels(),
                      const Spacer(),
                      _buildCentralVisualizer(),
                      const Spacer(),
                      _buildTimer(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF00E6FF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF00E6FF).withOpacity(0.3)),
            ),
            child: const Icon(Icons.headphones, color: Color(0xFF00E6FF), size: 24),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "音效同步: 骨骼复位 [ASMR]",
                style: TextStyle(
                  color: Color(0xFF00E6FF),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0xFFA3FF00),
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(width: 6, height: 6),
                  ),
                  SizedBox(width: 6),
                  Text(
                    "SYNC_ACTIVE // SIGNAL_STRENGTH_MAX",
                    style: TextStyle(
                      color: Color(0xFFA3FF00),
                      fontFamily: 'monospace',
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.close, color: Colors.white, size: 24),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.05),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
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
    return SizedBox(
      height: 320,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 轨道圈
          AnimatedBuilder(
            animation: _oscController,
            builder: (context, child) {
              return Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF00E6FF).withOpacity(0.1),
                    width: 1,
                  ),
                ),
              );
            },
          ),
          
          // 脊柱图像
          Image.network(
            "https://lh3.googleusercontent.com/aida-public/AB6AXuDIhCzSUbdMnu9nGqpmCpBcCfvm6M1KdYCCeQNESLFFkadZTkhhZWeiVl91Y6SuZ4bW6RKB6qZ3H2Q2SagDPZUG2kJcY8AyIi0Gs4rBn0mYr1Yo9x6BZvJGknhE0PQvK75mCJbtvte75bQOwBXIR_u_Yr7Mn61gTKdPzix3GrLBmyskMPAJYVe1QXs7ZVoh1oUk65OI4GHP7JTETJFGREi1m4HwP7kmCGodgqPpDVJO9asxezCK62XTgsKyMBfiGavBNamaCen3XkY",
            height: 280,
            fit: BoxFit.contain,
            color: const Color(0xFF00E6FF).withOpacity(0.6),
            colorBlendMode: BlendMode.srcIn,
          ),

          // 示波器路径
          Positioned(
            child: SizedBox(
              width: double.infinity,
              height: 100,
              child: CustomPaint(
                painter: OscilloscopePainter(animationValue: _oscController.value),
              ),
            ),
          ),

          // CRACK 弹窗
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const GlitchText(text: "CRACK"),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF00E6FF).withOpacity(0.2),
                  border: Border.all(color: const Color(0xFF00E6FF)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "ALIGNMENT_SUCCESS",
                  style: TextStyle(color: Color(0xFF00E6FF), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimer() {
    String minutes = (_milliseconds ~/ 60000).toString().padLeft(2, '0');
    String seconds = ((_milliseconds % 60000) ~/ 1000).toString().padLeft(2, '0');
    String millis = ((_milliseconds % 1000) ~/ 10).toString().padLeft(2, '0');

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text("$minutes:$seconds.", style: const TextStyle(color: Color(0xFF00E6FF), fontSize: 48, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
            Text(millis, style: TextStyle(color: const Color(0xFF00E6FF).withOpacity(0.5), fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
          ],
        ),
        const Text("SESSION_ELAPSED", style: TextStyle(color: Colors.white24, fontSize: 10, letterSpacing: 4, fontFamily: 'monospace')),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, AppColors.void_.withOpacity(0.8), AppColors.void_],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildStatCard("SOUND INTENSITY", "74.2", "dB", AppColors.textPrimary)),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard("SYNC STABILITY", "99.8", "%", const Color(0xFFA3FF00))),
            ],
          ),
          const SizedBox(height: 32),
          _buildVibrationSlider(),
          const SizedBox(height: 24),
          _buildFooterMeta(),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, String unit, Color valueColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        border: Border.all(color: Colors.white10),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 9, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: TextStyle(color: valueColor, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              Text(unit, style: TextStyle(color: valueColor.withOpacity(0.5), fontSize: 10, fontStyle: FontStyle.italic)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVibrationSlider() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.vibration, color: Color(0xFFE6C319), size: 14),
                SizedBox(width: 8),
                Text("VIBRATION_INTENSITY", style: TextStyle(color: Color(0xFFE6C319), fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
              ],
            ),
            Text("LVL_${(_vibrationIntensity * 10).toInt().toString().padLeft(2, '0')}", 
                 style: const TextStyle(color: Color(0xFFE6C319), fontFamily: 'monospace', fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 32,
            activeTrackColor: const Color(0xFFE6C319).withOpacity(0.3),
            inactiveTrackColor: const Color(0xFF332D00),
            thumbColor: const Color(0xFFE6C319),
            thumbShape: const CustomSliderThumb(),
          ),
          child: Slider(
            value: _vibrationIntensity,
            onChanged: (v) => setState(() => _vibrationIntensity = v),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("MIN_SAFE", style: TextStyle(color: Colors.white24, fontSize: 8, fontStyle: FontStyle.italic)),
              Text("DANGER_ZONE", style: TextStyle(color: Colors.white24, fontSize: 8, fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooterMeta() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Text("OS_VER: 2.4.0_REV", style: TextStyle(color: Colors.white24, fontSize: 9, fontFamily: 'monospace')),
            SizedBox(width: 16),
            Text("BIO_AUTH: OK", style: TextStyle(color: Colors.white24, fontSize: 9, fontFamily: 'monospace')),
          ],
        ),
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Color(0xFF00E6FF),
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Color(0xFF00E6FF), blurRadius: 10)],
          ),
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
    double midY = size.height / 2;
    
    path.moveTo(0, midY);
    for (double i = 0; i < size.width; i++) {
      double angle = (i / size.width * 2 * math.pi * 4) + (animationValue * 2 * math.pi);
      double distFromCenter = (i - size.width/2).abs();
      double multiplier = math.max(0, 1 - distFromCenter / (size.width * 0.4));
      
      double y = midY + math.sin(angle) * 15 * multiplier;
      
      // 模拟中间突起的脉冲
      if (i > size.width * 0.45 && i < size.width * 0.55) {
        double pulseAngle = (i - size.width * 0.45) / (size.width * 0.1) * math.pi;
        y -= math.sin(pulseAngle) * 40 * math.sin(animationValue * 5);
      }
      
      path.lineTo(i, y);
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant OscilloscopePainter oldDelegate) => true;
}

class CustomSliderThumb extends SliderComponentShape {
  const CustomSliderThumb();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(32, 48);

  @override
  void paint(PaintingContext context, Offset center, {required Animation<double> activationAnimation, required Animation<double> enableAnimation, required bool isDiscrete, required TextPainter labelPainter, required RenderBox parentBox, required SliderThemeData sliderTheme, required TextDirection textDirection, required double value, required double textScaleFactor, required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    final paint = Paint()..color = const Color(0xFFE6C319);
    
    final rect = Rect.fromCenter(center: center, width: 32, height: 48);
    canvas.drawRect(rect, paint);
    
    final borderPaint = Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 2;
    canvas.drawRect(rect, borderPaint);

    final linePaint = Paint()..color = Colors.black.withOpacity(0.3)..strokeWidth = 2;
    for (int i = 0; i < 3; i++) {
      double y = rect.top + 12 + (i * 12);
      canvas.drawLine(Offset(rect.left + 8, y), Offset(rect.right - 8, y), linePaint);
    }
  }
}

class GlitchText extends StatelessWidget {
  final String text;
  const GlitchText({super.key, required this.text});

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
              fontSize: 72,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              letterSpacing: -4,
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(2, 0),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF00FFF9),
              fontSize: 72,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              letterSpacing: -4,
            ),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 72,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            letterSpacing: -4,
          ),
        ),
      ],
    );
  }
}
