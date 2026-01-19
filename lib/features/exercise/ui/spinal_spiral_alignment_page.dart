import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../exercise/ui/base_exercise_page.dart';
import '../widgets/spinal/mechanical_soundwave.dart';
import '../widgets/spinal/spinal_hud_view.dart';
import '../widgets/spinal/spinal_stats_card.dart';
import '../widgets/spinal/warning_quote_panel.dart';

/// 脊柱螺旋对齐指引页 (Variant 3)
/// 
/// Refactored to use [BaseExercisePage] for consistent behavior.
class SpinalSpiralAlignmentPage extends StatefulWidget {
  const SpinalSpiralAlignmentPage({super.key});

  @override
  State<SpinalSpiralAlignmentPage> createState() => _SpinalSpiralAlignmentPageState();
}

class _SpinalSpiralAlignmentPageState extends State<SpinalSpiralAlignmentPage> with TickerProviderStateMixin {
  late AnimationController _soundwaveController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _soundwaveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(_pulseController);
  }

  @override
  void dispose() {
    _soundwaveController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseExercisePage(
      title: "脊柱螺旋对齐",
      taskName: "SYSTEM_ACTIVATE_V3",
      procedureId: "PROCEDURE_SPINAL_03",
      durationSeconds: 90, // Inherited from original logic implicitly or set standard
      hpReward: 8,
      coinReward: 150,
      themeColor: AppColors.industrialYellow,
      quote: "Align your axis. The system demands stability.",
      visualFeedback: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // HUD 引导区域
              SpinalHudView(pulseAnimation: _pulseAnimation),
              
              const SizedBox(height: 16),
              
              // 统计卡片
              const SpinalStatsCard(),
              
              const SizedBox(height: 16),
              
              // 机械声波
              MechanicalSoundwave(animation: _soundwaveController),
              
              const SizedBox(height: 16),
              
              // 警告引用
              const WarningQuotePanel(),
            ],
          ),
        ),
      ),
    );
  }
}
