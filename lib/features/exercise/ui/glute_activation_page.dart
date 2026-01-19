import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'base_exercise_page.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// 臀部机能唤醒指引页 (Variant 3) - 使用基类重构
class GluteActivationPage extends ConsumerWidget {
  const GluteActivationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseExercisePage(
      title: "臀部机能唤醒",
      taskName: "任务: 臀部机能唤醒",
      procedureId: "VIEWPORT: 01_SIT_POS",
      themeColor: AppColors.gluteOrange,
      quote: "Stop letting your glutes turn into office chair cushions. Squeeze!",
      visualFeedback: _GluteVisuals(),
    );
  }
}

class _GluteVisuals extends StatefulWidget {
  @override
  State<_GluteVisuals> createState() => _GluteVisualsState();
}

class _GluteVisualsState extends State<_GluteVisuals> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
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
        _build3DViewer(),
        const SizedBox(height: 20),
        _buildStatsGrid(),
      ],
    );
  }

  Widget _build3DViewer() {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0D1218),
          border: Border.all(color: Colors.white10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: 60,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildPulseRing(),
                        const SizedBox(width: 40),
                        _buildPulseRing(),
                      ],
                    ),
                  ),
                  Image.network(
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuD_IKpPWTTUcQxiLb2XvtRxAY-Y2VSBCxRRZ13pG0KFg6Cl0SjY0VIHnm_afgZbqYREw-Fmd7wJAgkpN_lmTdkznKsFq3-Oy-IRBzxxoerb51G8sv5RLi-caUgB_sigx892JInJvNv-i8Mw_VnR1zdIxlY4Wzv3x10R0q2-yf1gPEbIR0AG_xb8UmpwNbVviitzDN1JANEbjdGo1FmEF49IzgdQ6C3PdveZXmcmrW25hi09rQ5hjyluK1tQ7CPDt-f05lryrKPn5aQ",
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPulseRing() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: 40 + (10 * _pulseController.value),
          height: 40 + (10 * _pulseController.value),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.gluteOrange.withOpacity(1 - _pulseController.value),
              width: 2,
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(child: _buildStatItem("ENGAGEMENT", "85%")),
          const SizedBox(width: 12),
          Expanded(child: _buildStatItem("SYMMETRY", "98%")),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface_dark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
