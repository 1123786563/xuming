import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/cyber_button.dart';
import '../../../shared/widgets/scanline_overlay.dart';

/// 音效同步-骨骼复位页
class BoneResetPage extends StatefulWidget {
  const BoneResetPage({super.key});

  @override
  State<BoneResetPage> createState() => _BoneResetPageState();
}

class _BoneResetPageState extends State<BoneResetPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<double> _waveforms = List.generate(20, (index) => 0.2);
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..addListener(() {
      setState(() {
        for (int i = 0; i < _waveforms.length; i++) {
          _waveforms[i] = _random.nextDouble();
        }
      });
    });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          const ScanlineOverlay(opacity: 0.05),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("PHASE_02: AUDIO_SYNC", style: AppTypography.monoDecorative),
                const SizedBox(height: 16),
                const Text("声波校准：骨骼复位中", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 64),
                
                // 声波可视化器
                _buildWaveform(),
                
                const SizedBox(height: 64),
                const Text("ASMR 骨骼校正音效加载中...", style: TextStyle(color: AppColors.lifeSignal, fontSize: 12)),
                const SizedBox(height: 8),
                Text("[ HAPTIC_FEEDBACK_ACTIVE ]", style: AppTypography.monoLabel),
                
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: CyberButton(
                    text: "完成校准",
                    onPressed: () => context.push(AppRoutes.pressureReport),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaveform() {
    return SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _waveforms.map((value) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: 8,
            height: 20 + (value * 100),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: AppColors.lifeSignal,
              boxShadow: [
                BoxShadow(color: AppColors.lifeSignal.withOpacity(0.5), blurRadius: 10),
              ],
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }).toList(),
      ),
    );
  }
}
