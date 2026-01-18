import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/grid_background.dart';
import '../../../shared/widgets/scanline_overlay.dart';

/// 脊椎解压任务执行页 V2
class ExerciseExecutionPage extends StatefulWidget {
  const ExerciseExecutionPage({super.key});

  @override
  State<ExerciseExecutionPage> createState() => _ExerciseExecutionPageState();
}

class _ExerciseExecutionPageState extends State<ExerciseExecutionPage> with TickerProviderStateMixin {
  double _progress = 0.65;
  int _seconds = 59;
  int _hundredths = 42;
  Timer? _timer;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (mounted) {
        setState(() {
          _hundredths--;
          if (_hundredths < 0) {
            _hundredths = 99;
            _seconds--;
            if (_seconds < 0) {
              _seconds = 0;
              _hundredths = 0;
              timer.cancel();
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // 1. 底层背景
          const GridBackground(),
          
          // 2. 扫描线效果
          const ScanlineOverlay(opacity: 0.1),

          // 3. 顶部状态栏
          _buildTopBar(),

          // 4. 左侧压力等级条
          _buildPressureSidebar(),

          // 5. 主内容区域
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 80), // 为 TopBar 留出空间
                
                // 计时器
                _buildTimerDisplay(),
                
                const SizedBox(height: 20),
                
                // 生物视觉反馈区域 (脊椎图)
                Expanded(child: _buildBioVisualArea()),
                
                // 任务说明
                _buildTaskInfo(),
                
                // 进度状态
                _buildStatusSection(),
                
                // 底部操作栏
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
                  const Icon(Icons.radio_button_checked, color: AppColors.lifeSignal, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    "脊椎解压任务执行中",
                    style: AppTypography.monoDecorative.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("SIGNAL: 98%", style: AppTypography.monoDecorative.copyWith(color: AppColors.lifeSignal.withOpacity(0.6))),
                  const SizedBox(width: 16),
                  const Icon(Icons.settings_input_component, color: AppColors.lifeSignal, size: 20),
                ],
              ),
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
              "PRESSURE_LEVEL",
              style: AppTypography.monoDecorative.copyWith(
                fontSize: 9,
                color: AppColors.lifeSignal,
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
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 180, // 模拟 65% 的高度
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AppColors.lifeSignal,
                          AppColors.cautionYellow,
                          AppColors.nuclearWarning,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "CRIT",
            style: AppTypography.monoDecorative.copyWith(
              fontSize: 10,
              color: AppColors.nuclearWarning,
              fontWeight: FontWeight.bold,
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
              "00:${_seconds.toString().padLeft(2, '0')}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 60,
                fontWeight: FontWeight.bold,
                letterSpacing: -2,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              _hundredths.toString().padLeft(2, '0'),
              style: TextStyle(
                color: AppColors.lifeSignal.withOpacity(0.8),
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("MINUTES", style: AppTypography.monoDecorative.copyWith(color: Colors.white.withOpacity(0.4), letterSpacing: 3)),
            const SizedBox(width: 32),
            Text("SECONDS", style: AppTypography.monoDecorative.copyWith(color: Colors.white.withOpacity(0.4), letterSpacing: 3)),
          ],
        ),
      ],
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
              
              // 脊椎示意图 (使用 Icon 模拟，实际开发应使用 SVG 或图片)
              Center(
                child: Icon(
                  Icons.accessibility_new,
                  size: 240,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),

              // 热力点 1 (红色 - 严重)
              _buildHeatpoint(top: 150, left: 140, color: AppColors.nuclearWarning),
              
              // 热力点 2 (橙色 - 中等)
              _buildHeatpoint(top: 100, left: 160, color: AppColors.warningOrange),
              
              // 热力点 3 (绿色 - 舒缓)
              _buildHeatpoint(bottom: 100, right: 140, color: AppColors.lifeSignal),

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
              Positioned(bottom: 8, left: 8, child: Text("X: 142.09 Y: 88.11", style: AppTypography.monoDecorative.copyWith(color: AppColors.lifeSignal.withOpacity(0.4), fontSize: 8))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeatpoint({double? top, double? left, double? right, double? bottom, required Color color}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: FadeTransition(
        opacity: _pulseController,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.3),
            boxShadow: [
              BoxShadow(color: color, blurRadius: 15, spreadRadius: 2),
            ],
          ),
        ),
      ),
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
              Text(
                "Task: Structural Realignment",
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.lifeSignal,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text("PROCEDURE_01", style: AppTypography.monoDecorative.copyWith(color: Colors.white.withOpacity(0.4), fontSize: 10)),
            ],
          ),
          const SizedBox(height: 4),
          Container(height: 1, color: AppColors.lifeSignal.withOpacity(0.2)),
          const SizedBox(height: 8),
          Text(
            "\"Listen to your joints screaming for mercy. Don't stop now.\"",
            style: AppTypography.monoBody.copyWith(
              color: Colors.white.withOpacity(0.8),
              fontStyle: FontStyle.italic,
              fontSize: 13,
            ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("REALIGNMENT STATUS", style: AppTypography.monoDecorative.copyWith(color: AppColors.lifeSignal.withOpacity(0.6), fontSize: 10)),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "65% ", style: AppTypography.pixelHeadline.copyWith(color: Colors.white, fontSize: 20)),
                        TextSpan(text: "DECOMPRESSED", style: AppTypography.monoDecorative.copyWith(color: Colors.white.withOpacity(0.4), fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
              Text("STABILITY: NOMINAL", style: AppTypography.monoDecorative.copyWith(color: Colors.white.withOpacity(0.4), fontSize: 10)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.white.withOpacity(0.1),
              color: AppColors.lifeSignal,
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => context.push(AppRoutes.bossMode),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.nuclearWarning,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: AppColors.nuclearWarning.withOpacity(0.3), blurRadius: 20),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.visibility_off, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "BOSS MODE",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "SKIP_PROCEDURE",
                style: AppTypography.monoDecorative.copyWith(
                  color: Colors.white.withOpacity(0.3),
                  decoration: TextDecoration.underline,
                ),
              ),
              Row(
                children: [
                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.lifeSignal, shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

