import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/grid_background.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../../shared/providers/user_state_provider.dart';
import '../../../shared/services/audio_service.dart';

/// 动作执行基类
/// 
/// 统一处理计时器、奖励逻辑和基础赛博朋克 UI 框架
class BaseExercisePage extends ConsumerStatefulWidget {
  final String title;
  final String taskName;
  final String procedureId;
  final int durationSeconds;
  final int hpReward;
  final int coinReward;
  final Widget visualFeedback;
  final String quote;
  final Color themeColor;
  final Widget? headerActions; // 新增：自定义顶部区域右侧
  final Widget? statusActions; // 新增：自定义状态区域
  final Widget? rightStats; // 新增：自定义右侧区域

  const BaseExercisePage({
    super.key,
    required this.title,
    required this.taskName,
    this.procedureId = "PROCEDURE_01",
    this.durationSeconds = 60,
    this.hpReward = 5,
    this.coinReward = 100,
    required this.visualFeedback,
    this.quote = "Focus on the data. Ignore the pain.",
    this.themeColor = AppColors.lifeSignal,
    this.headerActions,
    this.statusActions,
    this.rightStats,
  });

  @override
  ConsumerState<BaseExercisePage> createState() => _BaseExercisePageState();
}

class _BaseExercisePageState extends ConsumerState<BaseExercisePage> with TickerProviderStateMixin {
  late int _remainingSeconds;
  int _hundredths = 0;
  Timer? _timer;
  late AnimationController _pulseController;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationSeconds;
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // 播放背景氛围音
    ref.read(audioServiceProvider).startAmbience();
    
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    // 停止背景音
    ref.read(audioServiceProvider).stopAmbience();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (mounted) {
        setState(() {
          _hundredths--;
          if (_hundredths < 0) {
            _hundredths = 99;
            _remainingSeconds--;
            
            // 更新进度条
            _progress = 1.0 - (_remainingSeconds / widget.durationSeconds);

            if (_remainingSeconds < 0) {
              _remainingSeconds = 0;
              _hundredths = 0;
              timer.cancel();
              _onComplete();
            }
          }
        });
      }
    });
  }

  void _onComplete() {
    // 更新全局状态：奖励 HP 和金币
    final notifier = ref.read(userStateProvider.notifier);
    notifier.addHp(widget.hpReward);
    notifier.addCoins(widget.coinReward);
    
    // 播放完成音效
    ref.read(audioServiceProvider).playComplete();
    
    context.push(AppRoutes.hpRecoverySuccess);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          const GridBackground(),
          const ScanlineOverlay(opacity: 0.1),
          _buildTopBar(),
          _buildPressureSidebar(),
          if (widget.rightStats != null)
            Positioned(
              right: 16,
              top: 120,
              child: widget.rightStats!,
            ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 80),
                _buildTimerDisplay(),
                const SizedBox(height: 20),
                Expanded(child: widget.visualFeedback),
                _buildTaskInfo(),
                _buildStatusSection(),
                _buildFooterActions(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          border: Border(bottom: BorderSide(color: AppColors.lifeSignal.withOpacity(0.2))),
        ),
        child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.radio_button_checked, color: widget.themeColor, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    widget.title,
                    style: AppTypography.monoDecorative.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              widget.headerActions ?? Text("SIGNAL: 98%", style: AppTypography.monoDecorative.copyWith(color: widget.themeColor.withOpacity(0.6))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPressureSidebar() {
    return Positioned(
      left: 16,
      top: 120,
      bottom: 240,
      width: 48,
      child: Column(
        children: [
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              AppStrings.recoveryLevel,
              style: AppTypography.monoDecorative.copyWith(
                fontSize: 9,
                color: widget.themeColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              width: 8,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  FractionallySizedBox(
                    heightFactor: _progress.clamp(0.01, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [widget.themeColor, AppColors.cautionYellow],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerDisplay() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              "00:${_remainingSeconds.toString().padLeft(2, '0')}",
              style: const TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            Text(
              _hundredths.toString().padLeft(2, '0'),
              style: TextStyle(color: widget.themeColor.withOpacity(0.8), fontSize: 30),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTaskInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.taskName, style: AppTypography.monoDecorative.copyWith(color: widget.themeColor, fontWeight: FontWeight.bold)),
              Text(widget.procedureId, style: AppTypography.monoDecorative.copyWith(color: Colors.white.withOpacity(0.4), fontSize: 10)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "\"${widget.quote}\"",
            style: AppTypography.monoBody.copyWith(color: Colors.white.withOpacity(0.8), fontSize: 13, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: _progress,
            backgroundColor: Colors.white.withOpacity(0.1),
            color: widget.themeColor,
            minHeight: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => context.push(AppRoutes.bossMode),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(color: AppColors.nuclearWarning, borderRadius: BorderRadius.circular(8)),
              child: const Center(child: Text(AppStrings.bossMode, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => _onComplete(),
            child: Text(AppStrings.skipProcedure, style: TextStyle(color: Colors.white.withOpacity(0.3))),
          ),
        ],
      ),
    );
  }
}
