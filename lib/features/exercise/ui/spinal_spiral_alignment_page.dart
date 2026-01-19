import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/grid_background.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../../shared/widgets/cyber_button.dart';
import '../widgets/spinal/spinal_hud_view.dart';
import '../widgets/spinal/spinal_stats_card.dart';
import '../widgets/spinal/mechanical_soundwave.dart';
import '../widgets/spinal/warning_quote_panel.dart';

/// 脊柱螺旋对齐指引页 (Variant 3)
class SpinalSpiralAlignmentPage extends StatefulWidget {
  const SpinalSpiralAlignmentPage({super.key});

  @override
  State<SpinalSpiralAlignmentPage> createState() => _SpinalSpiralAlignmentPageState();
}

class _SpinalSpiralAlignmentPageState extends State<SpinalSpiralAlignmentPage> with SingleTickerProviderStateMixin {
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
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      // 使用 theme 判断 dark mode，这里强制为 dark mode 以匹配设计
      body: Theme(
        data: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.void_,
          primaryColor: AppColors.industrialYellow,
        ),
        child: Builder(
          builder: (context) {
            return Stack(
              children: [
                // 1. 底层背景
                const GridBackground(
                  lineColor: Color(0xFF26333b), 
                  gridSize: 40,
                  lineOpacity: 1.0, 
                ),
                
                // 2. 扫描线效果
                ScanlineOverlay(opacity: 0.2, color: AppColors.industrialYellow.withOpacity(0.2)),

                // 3. 全局布局
                SafeArea(
                  child: Column(
                    children: [
                       // 顶栏
                      _buildTopBar(context),
                      
                      // 主内容区
                      Expanded(
                        child: SingleChildScrollView(
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
                                
                                // 进度条
                                _buildProgressBar(),
                                
                                const SizedBox(height: 16),
                                
                                // 警告引用
                                const WarningQuotePanel(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      // 底部栏
                      _buildFooterActions(context),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.void_.withOpacity(0.8),
        border: Border(bottom: BorderSide(color: AppColors.industrialYellow.withOpacity(0.3))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.industrialYellow.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(2),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.industrialYellow),
              onPressed: () => context.pop(),
              padding: EdgeInsets.zero,
            ),
          ),
          Column(
            children: [
              Text(
                "SYSTEM_ACTIVATE_V3",
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.industrialYellow.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 10,
                ),
              ),
              Text(
                "任务: 脊柱螺旋对齐",
                style: AppTypography.pixelHeadline.copyWith(
                  color: AppColors.industrialYellow,
                  fontSize: 20,
                  height: 1.2,
                ),
              ),
            ],
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.industrialYellow.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(2),
            ),
            child: IconButton(
              icon: const Icon(Icons.info_outline, color: AppColors.industrialYellow),
              onPressed: () {},
               padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildProgressBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.industrialYellow.withOpacity(0.05),
        border: Border.all(color: AppColors.industrialYellow.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Active Alignment",
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.industrialYellow,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "65",
                      style: AppTypography.pixelHeadline.copyWith(
                        color: AppColors.industrialYellow,
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextSpan(
                      text: "%",
                      style: AppTypography.monoDecorative.copyWith(
                        color: AppColors.industrialYellow,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF26333b)),
              color: const Color(0xFF26333b).withOpacity(0.5),
            ),
            child: Row(
               children: [
                 Expanded(
                   flex: 65,
                   child: Container(height: 12, color: AppColors.industrialYellow),
                 ),
                 const Expanded(
                   flex: 35,
                   child: SizedBox(height: 12),
                 ),
               ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: const BoxDecoration(
        color: AppColors.void_,
        border: Border(top: BorderSide(color: Color(0xFF26333b))),
      ),
      child: Column(
        children: [
          CyberButton(
            text: "ACTIVATE TORSION",
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('TORSION ACTIVATED')),
              );
            },
            color: AppColors.industrialYellow,
            textColor: Colors.black,
            icon: Icons.bolt,
            height: 60,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(Icons.fitness_center, "Workouts", true),
              _buildBottomNavItem(Icons.analytics, "Vitals", false),
              _buildBottomNavItem(Icons.settings_suggest, "System", false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, bool isActive) {
    final color = isActive ? AppColors.industrialYellow : AppColors.industrialYellow.withOpacity(0.4);
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: AppTypography.monoDecorative.copyWith(
            color: color,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
