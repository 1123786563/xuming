import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'base_exercise_page.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// 脊椎解压任务执行页 V2 - 使用基类重构
class ExerciseExecutionPage extends ConsumerWidget {
  const ExerciseExecutionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseExercisePage(
      title: "脊椎解压任务执行中",
      taskName: "Task: Structural Realignment",
      procedureId: "PROCEDURE_01",
      quote: "Listen to your joints screaming for mercy. Don't stop now.",
      visualFeedback: _buildBioVisualArea(),
    );
  }

  Widget _buildBioVisualArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lifeSignal.withOpacity(0.2)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // 背景光影
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.lifeSignal.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              
              // 脊椎示意图
              Center(
                child: Icon(
                  Icons.accessibility_new,
                  size: 240,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),

              // 热力点
              const _Heatpoint(top: 150, left: 140, color: AppColors.nuclearWarning),
              const _Heatpoint(top: 100, left: 160, color: AppColors.warningOrange),
              const _Heatpoint(bottom: 100, right: 140, color: AppColors.lifeSignal),

              // 边角文字
              Positioned(
                top: 8,
                left: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("BIO_LINK_ACTIVE", style: AppTypography.monoDecorative.copyWith(color: AppColors.lifeSignal, fontSize: 8)),
                    Row(
                      children: [
                        Container(width: 4, height: 4, color: AppColors.lifeSignal),
                        const SizedBox(width: 2),
                        Container(width: 4, height: 4, color: AppColors.lifeSignal.withOpacity(0.2)),
                        const SizedBox(width: 2),
                        Container(width: 4, height: 4, color: AppColors.lifeSignal.withOpacity(0.2)),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(top: 8, right: 8, child: Text("ID: SYSTEM_404", style: AppTypography.monoDecorative.copyWith(color: AppColors.lifeSignal.withOpacity(0.4), fontSize: 8))),
            ],
          ),
        ),
      ),
    );
  }
}

class _Heatpoint extends StatefulWidget {
  final double? top, left, right, bottom;
  final Color color;

  const _Heatpoint({this.top, this.left, this.right, this.bottom, required this.color});

  @override
  State<_Heatpoint> createState() => _HeatpointState();
}

class _HeatpointState extends State<_Heatpoint> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      right: widget.right,
      bottom: widget.bottom,
      child: FadeTransition(
        opacity: _controller,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color.withOpacity(0.3),
            boxShadow: [BoxShadow(color: widget.color, blurRadius: 15, spreadRadius: 2)],
          ),
        ),
      ),
    );
  }
}

