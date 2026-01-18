import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/grid_background.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../../shared/widgets/cyber_button.dart';

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
                                _buildHUDView(),
                                
                                const SizedBox(height: 16),
                                
                                // 统计卡片
                                _buildStatsCards(),
                                
                                const SizedBox(height: 16),
                                
                                // 机械声波
                                _buildMechanicalSoundwave(),
                                
                                const SizedBox(height: 16),
                                
                                // 进度条
                                _buildProgressBar(),
                                
                                const SizedBox(height: 16),
                                
                                // 警告引用
                                _buildWarningQuote(),
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

  Widget _buildHUDView() {
    return Container(
      height: 340,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        border: Border.all(color: AppColors.industrialYellow, width: 2),
      ),
      child: Stack(
        children: [
          // 3D 角色图片 (替换为网络占位图，或本地资源)
          Positioned.fill(
            child: Image.network(
              "https://lh3.googleusercontent.com/aida-public/AB6AXuByxAGLm9N4wQ2IJ5fg91hJchi-5bipwPHinFkIhF1MYgJfNhhCCHLtX0fMq1bH5w-CnAp7mlbA0OXj5iJt5E6erH4RxozHInvQbzy4FAqvm1_nWOSruarVhkxRHYZs8oZJI_I-hmkBmb0y8coCMXCTQQwaRxp_oLFxmOldNfdPmJC75pqNe5JrZAVNxn7yW2f42QtwJ4ilzShTjB9ZUvbg9yxJoRf9PG_1pJOEVVdJCKXXI93gvDERGDy6FZhzqxUIu4_HVj4bOGs",
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
              errorBuilder: (context, error, stackTrace) => Center(
                child: Icon(Icons.accessibility_new, size: 100, color: AppColors.industrialYellow.withOpacity(0.2)),
              ),
            ),
          ),
          
          // HUD 左上角信息
          Positioned(
            top: 8,
            left: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 8, height: 8, color: AppColors.industrialYellow),
                    const SizedBox(width: 4),
                    Text(
                      "REC_MODE: DIAGNOSTIC",
                      style: AppTypography.monoDecorative.copyWith(
                        color: AppColors.industrialYellow,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Text(
                  "X: 124.52 Y: 88.01 Z: -4.10",
                  style: AppTypography.monoDecorative.copyWith(
                    color: AppColors.industrialYellow.withOpacity(0.6),
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          
          // HUD 右上角警告
          Positioned(
            top: 8,
            right: 8,
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _pulseAnimation.value,
                  child: Text(
                    "CALIBRATING SPINE...",
                    style: AppTypography.monoDecorative.copyWith(
                      color: AppColors.nuclearWarning,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          
          // 旋转图标叠加
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.industrialYellow.withOpacity(0.2), width: 4),
              ),
              child: const Icon(
                Icons.sync,
                color: AppColors.industrialYellow,
                size: 80,
                
              ),
            ),
          ),
          
          // 角落装饰
          Positioned(bottom: 8, right: 8, child: _buildCornerBracket(false)),
          Positioned(bottom: 8, left: 8, child: _buildCornerBracket(true)),
        ],
      ),
    );
  }

  Widget _buildCornerBracket(bool isLeft) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border(
          bottom: const BorderSide(color: AppColors.industrialYellow, width: 2),
          left: isLeft ? const BorderSide(color: AppColors.industrialYellow, width: 2) : BorderSide.none,
          right: isLeft ? BorderSide.none : const BorderSide(color: AppColors.industrialYellow, width: 2),
        ),
      ),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        // Rotation Degree
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF26333b).withOpacity(0.2),
              border: Border.all(color: const Color(0xFF26333b)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ROTATION_DEGREE",
                      style: AppTypography.monoDecorative.copyWith(
                        color: AppColors.industrialYellow.withOpacity(0.6),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(width: 8, height: 2, color: AppColors.industrialYellow),
                  ],
                ),
                Text(
                  "45°",
                  style: AppTypography.pixelHeadline.copyWith(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.keyboard_double_arrow_up, color: AppColors.industrialYellow, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      "MAX_TORQUE",
                      style: AppTypography.monoDecorative.copyWith(
                        color: AppColors.industrialYellow,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Torsion Level
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF26333b).withOpacity(0.2),
              border: Border.all(color: const Color(0xFF26333b)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TORSION_LEVEL",
                  style: AppTypography.monoDecorative.copyWith(
                    color: AppColors.industrialYellow.withOpacity(0.6),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "HIGH",
                  style: AppTypography.pixelHeadline.copyWith(
                    color: AppColors.industrialYellow,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(child: Container(height: 4, color: AppColors.industrialYellow, margin: const EdgeInsets.only(right: 2))),
                    Expanded(child: Container(height: 4, color: AppColors.industrialYellow, margin: const EdgeInsets.only(right: 2))),
                    Expanded(child: Container(height: 4, color: AppColors.industrialYellow, margin: const EdgeInsets.only(right: 2))),
                    Expanded(child: Container(height: 4, color: AppColors.industrialYellow.withOpacity(0.2))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMechanicalSoundwave() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Container(height: 1, color: const Color(0xFF26333b))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "MECHANICAL SOUNDWAVE STATUS",
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.industrialYellow,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            Expanded(child: Container(height: 1, color: const Color(0xFF26333b))),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 48,
          child: AnimatedBuilder(
            animation: _soundwaveController,
            builder: (context, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(20, (index) {
                   final randomHeight = math.Random(index).nextDouble();
                   final animatedHeight = (randomHeight + _soundwaveController.value) % 1.0;
                   return Container(
                     width: 3,
                     height: 48 * (0.3 + 0.7 * animatedHeight),
                     margin: const EdgeInsets.symmetric(horizontal: 1),
                     color: AppColors.industrialYellow,
                   );
                }),
              );
            },
          ),
        ),
      ],
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

  Widget _buildWarningQuote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.nuclearWarning.withOpacity(0.1),
        border: const Border(
          left: BorderSide(color: AppColors.nuclearWarning, width: 4),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Diagnostic Warning // Error_Code_404_SPINE",
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.nuclearWarning,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "\"Your spine isn't a straight line anymore; it's a disaster. Twist it back.\"",
                style: AppTypography.monoBody.copyWith(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              ),
            ],
          ),
           Positioned(
             bottom: -16,
             right: -16,
             child: Transform.rotate(
               angle: 12 * 3.14 / 180,
               child: Icon(
                 Icons.warning,
                 size: 80,
                 color: AppColors.nuclearWarning.withOpacity(0.2),
               ),
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
