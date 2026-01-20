import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import 'base_exercise_page.dart';

class WristRestructurePage extends ConsumerWidget {
  const WristRestructurePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseExercisePage(
      title: "手腕结构重组",
      taskName: "TASK: WRIST_RESTRUCTURE",
      procedureId: "ENCRYPTED_SIGNAL_0X4F",
      quote: "Don't let your hands turn into rigid claws.",
      durationSeconds: 30, // 示例时长
      visualFeedback: _WristVisuals(),
    );
  }
}

class _WristVisuals extends StatefulWidget {
  @override
  State<_WristVisuals> createState() => _WristVisualsState();
}

class _WristVisualsState extends State<_WristVisuals> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHUDStats(),
        const SizedBox(height: 20),
        Expanded(child: _buildCentralVisual()),
      ],
    );
  }

  Widget _buildHUDStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: AppColors.lifeSignal.withOpacity(0.2),
      padding: const EdgeInsets.all(1),
      child: Row(
        children: [
          Expanded(child: _buildStatItem('Joint Tension', '42', 'PSI', false)),
          const SizedBox(width: 1),
          Expanded(child: _buildStatItem('Sync Rate', '98.4', '%', true)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, String unit, bool isPrimary) {
    return Container(
      color: AppColors.void_,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.lifeSignal.withOpacity(0.6),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: GoogleFonts.spaceGrotesk(
                  color: isPrimary ? AppColors.lifeSignal : Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  unit,
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCentralVisual() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pulse Rings
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                _buildPulseRing(1, 0.0),
                _buildPulseRing(1.5, 0.5),
              ],
            );
          },
        ),

        // Main Image
        Image.network(
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAbQ5rd_XUmGkEaHdmUg8WDr8elpRnxatr1aPIcJBKrT0pbKhzhbkrg-tuUn6yQKxE-IgCeR-6TFpMO7MRZi9KjEEpG5vWsjZ5QieW50GMhOdpAFhQ8ZQ9V0CahGwZ45jbfsfDt7iNLmnfs7ChppdIMDWtzvRMe4-hjcyjBNiEr2hg_ZDLHEwJbd-xMdnejFeNcYH9S3I6--IhO42-qN3-fTOUEvJ9n7t-PwoK1H4Y62ljOV5dHYQTXuP-NBKZQ5i1kSWh9SoRRJeM',
          fit: BoxFit.contain,
          width: 260,
          height: 260,
          color: Colors.white.withOpacity(0.9),
          colorBlendMode: BlendMode.modulate,
        ),

        // Joint Nodes (Hardcoded positions roughly matching image)
        // top: 40%, left: 45% -> relative to the 300x300 box
        // Ideally these should be relative to image, but hardcoding for now
        const Positioned(
          top: 130, // 40% of ~320ish area
          left: 0, right: 0,
          child: IgnorePointer(
            child: Center(
              child: SizedBox(
                width: 320, height: 320,
                child: Stack(
                  children: [
                    Positioned(
                      top: 100, left: 145,
                      child: _GlowingDot(size: 12, color: AppColors.lifeSignal),
                    ),
                    Positioned(
                      top: 145, left: 175,
                      child: _GlowingDot(size: 8, color: Color(0x9900FF41)),
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

  Widget _buildPulseRing(double scaleBase, double delay) {
    // simple ring simplified
    // Actually using AnimationController
    final double value = (_pulseController.value + delay) % 1.0;
    final double scale = 1.0 + (value * 0.1); // 1.0 to 1.1
    final double opacity = 1.0 - value; // 1.0 to 0.0

    return Transform.scale(
      scale: scale,
      child: Opacity(
        opacity: opacity * 0.5,
        child: Container(
          width: 128 * scaleBase,
          height: 128 * scaleBase,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.lifeSignal.withOpacity(0.5), width: 1),
          ),
        ),
      ),
    );
  }
}

class _GlowingDot extends StatelessWidget {
  final double size;
  final Color color;
  
  const _GlowingDot({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.8),
            blurRadius: size,
            spreadRadius: size * 0.3,
          ),
        ],
      ),
    );
  }
}
