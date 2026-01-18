import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/cyber_button.dart';
import '../../../shared/widgets/grid_background.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../../shared/widgets/glitch_text.dart';

/// 脊椎解压任务执行页
class ExerciseExecutionPage extends StatefulWidget {
  const ExerciseExecutionPage({super.key});

  @override
  State<ExerciseExecutionPage> createState() => _ExerciseExecutionPageState();
}

class _ExerciseExecutionPageState extends State<ExerciseExecutionPage> {
  double _progress = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startExercise();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startExercise() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_progress < 1.0) {
        setState(() => _progress += 0.01);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          const GridBackground(),
          const ScanlineOverlay(opacity: 0.05),
          
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(child: _build3DPreview()),
                _buildProgressSection(),
                _buildFooterActions(),
              ],
            ),
          ),
          
          // Boss Mode 极速切换按钮 (红色常驻)
          _buildBossModeButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("REPAIR_PROTOCOL_01", style: AppTypography.monoDecorative),
              const SizedBox(height: 4),
              const Text("脊椎解压: 颈后伸展", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(border: Border.all(color: AppColors.nuclearWarning)),
            child: const Text("LIVE_SCAN", style: TextStyle(color: AppColors.nuclearWarning, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _build3DPreview() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.accessibility_new, size: 240, color: AppColors.lifeSignal.withOpacity(0.4)),
          const SizedBox(height: 24),
          const GlitchText(
            text: "[ 3D 动作引导中 ]",
            style: TextStyle(color: AppColors.lifeSignal, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("COMPLETION", style: TextStyle(color: Colors.white60, fontSize: 12)),
              Text("${(_progress * 100).toInt()}%", style: const TextStyle(color: AppColors.lifeSignal, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: _progress,
            backgroundColor: AppColors.cardBackground,
            color: AppColors.lifeSignal,
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: CyberButton(
        text: _progress >= 1.0 ? "进入阶段二: 骨骼复位" : "正在校验动作...",
        onPressed: _progress >= 1.0 ? () => context.push(AppRoutes.boneReset) : null,
        color: _progress >= 1.0 ? AppColors.lifeSignal : AppColors.cardBackground,
      ),
    );
  }

  Widget _buildBossModeButton() {
    return Positioned(
      right: 16,
      bottom: 100,
      child: GestureDetector(
        onTap: () => context.push(AppRoutes.bossMode),
        child: Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            color: AppColors.nuclearWarning,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: AppColors.nuclearWarning, blurRadius: 15)],
          ),
          child: const Center(
            child: Icon(Icons.security, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
