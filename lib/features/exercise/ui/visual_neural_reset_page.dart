import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'base_exercise_page.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cyber_decorations.dart';

/// 视觉神经重置指引页 (Variant 1) - 使用基类重构
class VisualNeuralResetPage extends ConsumerWidget {
  const VisualNeuralResetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const BaseExercisePage(
      title: AppStrings.visualNeuralTitle,
      taskName: AppStrings.visualNeuralTask,
      procedureId: "VISUAL_RESET_01",
      themeColor: AppColors.visualResetGreen,
      quote: AppStrings.visualNeuralQuote,
      durationSeconds: 45,
      visualFeedback: _VisualNeuralVisuals(),
    );
  }
}

class _VisualNeuralVisuals extends StatefulWidget {
  const _VisualNeuralVisuals();

  @override
  State<_VisualNeuralVisuals> createState() => _VisualNeuralVisualsState();
}

class _VisualNeuralVisualsState extends State<_VisualNeuralVisuals> with SingleTickerProviderStateMixin {
  late AnimationController _arrowController;

  @override
  void initState() {
    super.initState();
    _arrowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _arrowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        iconTheme: const IconThemeData(color: AppColors.visualResetGreen),
      ),
      child: Column(
        children: [
          Expanded(child: _buildMainVisual()),
          const SizedBox(height: 24),
          _buildStatsCards(),
        ],
      ),
    );
  }

  Widget _buildMainVisual() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorative Corners
          const Positioned(top: 0, left: 0, child: CyberCorner(isTop: true, isLeft: true, size: 32, color: AppColors.visualResetGreen)),
          const Positioned(top: 0, right: 0, child: CyberCorner(isTop: true, isLeft: false, size: 32, color: AppColors.visualResetGreen)),
          const Positioned(bottom: 0, left: 0, child: CyberCorner(isTop: false, isLeft: true, size: 32, color: AppColors.visualResetGreen)),
          const Positioned(bottom: 0, right: 0, child: CyberCorner(isTop: false, isLeft: false, size: 32, color: AppColors.visualResetGreen)),

          // Central Visual (Placeholder for 3D Head)
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuCKt1rRUnkpzF_N8c5RaaTrXTMQ96FIc2txGfeCsIbDJ6YdzrZCchYsXP9A_BltS0mpYm9bmhcHV26blIP89_xIbaViTKMY76QUrkDh9foJlXn-3-PmYl9SCV0MJtxKHEVuy_tPXLzSsbjKfvAxKVqAiaOKYnjTmAfl8fCiGzifkFnn0MmyYZsjqjQhf8apC-f3SbUWSEfpd1pWXmq-HAutjSDHUO2B-CCCi1eznCBftC6cCVeg52y4W5ytTvgPYXjyvuutRRv6gxY"),
                fit: BoxFit.contain,
              ),
              boxShadow: [
                 BoxShadow(
                   color: AppColors.visualResetGreen.withOpacity(0.4),
                   blurRadius: 15,
                   spreadRadius: 0,
                 )
              ]
            ),
          ),
          
          // Directional Arrows
          Positioned(
            top: 20,
            child: FadeTransition(
              opacity: _arrowController,
              child: const Icon(Icons.keyboard_double_arrow_up, size: 48, color: AppColors.visualResetGreen),
            ),
          ),
          Positioned(
            bottom: 20,
            child: Opacity(
              opacity: 0.4,
              child: const Icon(Icons.keyboard_double_arrow_down, size: 48, color: AppColors.visualResetGreen),
            ),
          ),
          Positioned(
            left: 20,
            child: Opacity(
              opacity: 0.4,
              child: const Icon(Icons.keyboard_double_arrow_left, size: 48, color: AppColors.visualResetGreen),
            ),
          ),
          Positioned(
            right: 20,
            child: Opacity(
              opacity: 0.4,
              child: const Icon(Icons.keyboard_double_arrow_right, size: 48, color: AppColors.visualResetGreen),
            ),
          ),

          // Phase Indicator
           Positioned(
            bottom: 80,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.visualResetGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.visualResetGreen.withOpacity(0.3)),
              ),
              child: Text(
                "PHASE: LOOK UP",
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.visualResetGreen,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 12,
                  shadows: [
                    Shadow(color: AppColors.visualResetGreen.withOpacity(0.5), blurRadius: 5),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: _buildStatCard(AppStrings.latencyLabel, "0.04ms")),
          const SizedBox(width: 8),
          Expanded(child: _buildStatCard(AppStrings.refreshLabel, "120HZ")),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        border: Border.all(color: AppColors.visualResetGreen.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: AppColors.visualResetGreen.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.monoDecorative.copyWith(
              color: AppColors.visualResetGreen.withOpacity(0.6),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.pixelHeadline.copyWith(
              color: AppColors.visualResetGreen,
              fontSize: 24,
              shadows: [
                Shadow(color: AppColors.visualResetGreen.withOpacity(0.8), blurRadius: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
