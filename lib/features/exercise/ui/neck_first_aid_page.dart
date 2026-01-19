import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cyber_decorations.dart'; // New import
import 'base_exercise_page.dart'; // New import

/// 颈椎急救指引 (男) - 使用基类重构
class NeckFirstAidPage extends StatelessWidget {
  const NeckFirstAidPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseExercisePage(
      title: "颈部后收",
      taskName: "NECK RETRACTION",
      procedureId: "MALE_BIO_SYNC_v2.0",
      themeColor: AppColors.lifeSignal,
      quote: "If you can't even move your neck, how will you dodge the bullet of overwork?",
      visualFeedback: const _NeckVisuals(),
      headerActions: const _HeaderStatus(),
      rightStats: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "INTENSITY_LVL",
                style: AppTypography.pixelBody.copyWith(
                  color: AppColors.lifeSignal.withOpacity(0.6),
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.lifeSignal.withOpacity(0.05),
                  border: Border.all(color: AppColors.lifeSignal),
                ),
                child: Text(
                  "Level 1: Gentle",
                  style: AppTypography.monoBody.copyWith(
                    color: AppColors.lifeSignal,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "REMAINING_CYCLE",
                style: AppTypography.pixelBody.copyWith(
                  color: AppColors.lifeSignal.withOpacity(0.6),
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.black.withOpacity(0.6),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: AppColors.lifeSignal, width: 2)),
                  ),
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                       Row(
                         mainAxisSize: MainAxisSize.min,
                         crossAxisAlignment: CrossAxisAlignment.baseline,
                         textBaseline: TextBaseline.alphabetic,
                         children: [
                           Text(
                             "00:45",
                             style: AppTypography.pixelHeadline.copyWith(
                               color: AppColors.lifeSignal,
                               fontSize: 48,
                               height: 1,
                               shadows: [
                                 Shadow(color: AppColors.lifeSignal.withOpacity(0.7), blurRadius: 10),
                               ],
                             ),
                           ),
                           Text(
                             ".88",
                             style: AppTypography.pixelBody.copyWith(
                               color: AppColors.lifeSignal.withOpacity(0.7),
                               fontSize: 24,
                             ),
                           ),
                         ],
                       ),
                       const SizedBox(height: 4),
                       Text(
                         "MS_ACCURACY_ENABLED",
                         style: AppTypography.monoDecorative.copyWith(
                           color: AppColors.lifeSignal.withOpacity(0.4),
                           fontSize: 8,
                           letterSpacing: 2,
                         ),
                       ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderStatus extends StatelessWidget {
  const _HeaderStatus();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: AppColors.lifeSignal,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: AppColors.lifeSignal, blurRadius: 8, spreadRadius: 0),
        ],
      ),
    );
  }
}

class _NeckVisuals extends StatefulWidget {
  const _NeckVisuals();

  @override
  State<_NeckVisuals> createState() => _NeckVisualsState();
}

class _NeckVisualsState extends State<_NeckVisuals> with SingleTickerProviderStateMixin {
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
    return Stack(
      alignment: Alignment.center,
      children: [
        // 背景 3D 模型渲染
        Opacity(
          opacity: 0.8,
          child: Image.network(
            "https://lh3.googleusercontent.com/aida-public/AB6AXuCQOz-M1MswPCn_rbU0DDlXwER96ITjjoEmJRzFZDqDNU1OKcQkAHV4lg-eP6FGa3YPBj5HKrKjbT584_HRinbEsbWn5GO0e32ejvyiMkdRdr-vfhY--hEgnHHMlw3MSy2HRpmPkO_OAZpznUFJVznNcsbGV565VlvXkI1xt7xxlOSYhGRr33CCSQvaigComBa0Cy-M1J0M64ZHmDrtK68cYs5rCBujY9BLhvA4dasHyA8AvU8MO_NeqAHiYZDqx7n4a2QzWURAEQk",
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.person,
              size: 200,
              color: AppColors.lifeSignal.withOpacity(0.2),
            ),
          ),
        ),

        // C-Spine Marker
        Positioned(
          top: 120,
          left: 180,
          child: Row(
            children: [
              CyberPulseMarker(animation: _pulseController),
              Container(width: 30, height: 1, color: AppColors.lifeSignal.withOpacity(0.5)),
              const CyberHudLabel(
                label: "C_SPINE_ALIGMENT",
                value: "STRETCH_RATIO: 1.12x",
              ),
            ],
          ),
        ),

        // Scapula Marker
        Positioned(
          top: 260,
          left: 140,
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              const Icon(Icons.adjust, color: AppColors.lifeSignal, size: 12),
              Container(width: 20, height: 1, color: AppColors.lifeSignal.withOpacity(0.3)),
              Text(
                "Scapula_Lock",
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.lifeSignal.withOpacity(0.6),
                  fontSize: 8,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),

        // 测边状态
        Positioned(
          left: 16,
          top: 24,
          child: _buildSideStats(),
        ),
      ],
    );
  }

  Widget _buildSideStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CyberHudLabel(label: "ANATOMICAL_ACCURACY", value: "98%"),
        const SizedBox(height: 8),
        const CyberHudLabel(label: "POSTURE_RECOGNITION", value: "ACTIVE"),
        const SizedBox(height: 12),
        Container(
          width: 60,
          height: 2,
          color: AppColors.lifeSignal.withOpacity(0.2),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.75,
            child: Container(color: AppColors.lifeSignal),
          ),
        ),
      ],
    );
  }
}
```
