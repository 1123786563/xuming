import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/pixel_corner_container.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../../shared/providers/user_state_provider.dart';
import '../../report/ui/weekly_report_dialog.dart';
import 'widgets/segmented_health_bar.dart';
import 'widgets/dashboard_visualizer.dart';
import 'widgets/dashboard_bottom_nav.dart';

/// 生存仪表盘主页 - 终极版
/// 
/// 核心监控界面，展示 HP、人体模型热力图
/// 采用赛博朋克风格，强调视觉冲击力和沉浸感
class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  // 移除硬编码的 _currentHP，改从 Provider 读取
  int _currentIndex = 0; // 0: Monitor, 1: Library, 2: Stats, 3: Profile

  Color _getHPColor(double hp) {
    if (hp > 60) return AppColors.lifeSignal;
    if (hp > 30) return AppColors.accentYellow;
    return AppColors.nuclearWarning;
  }

  String _getBioStatusText(double hp) {
    if (hp > 80) return '${AppStrings.bioStatusLabel}: ${AppStrings.bioStatusOptimal}';
    if (hp > 50) return '${AppStrings.bioStatusLabel}: ${AppStrings.bioStatusStable}';
    if (hp > 20) return '${AppStrings.bioStatusLabel}: ${AppStrings.bioStatusWarning}';
    return '${AppStrings.bioStatusLabel}: ${AppStrings.bioStatusCritical}';
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.monoDecorative.copyWith(
            color: color.withOpacity(0.7),
            fontSize: 10,
            letterSpacing: 1.5,
          ),
        ),
        Text(
          value,
          style: AppTypography.monoDecorative.copyWith(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            shadows: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 5,
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // 启动久坐监测服务
    ref.read(sedentaryMonitorProvider);
    
    final userState = ref.watch(userStateProvider);
    final currentHP = userState.hp;

    return Scaffold(
      backgroundColor: Colors.black, // Darkest background
      body: Stack(
        children: [
          // Background Gradient & Grid
          Positioned.fill(
             child: Container(
               decoration: const BoxDecoration(
                 gradient: LinearGradient(
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                   colors: [Colors.black, Colors.transparent, Colors.black],
                 ),
               ),
            ),
          ),
           // Background Grid Effect (Full Screen)
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: CustomPaint(
                painter: _BackgroundGridPainter(),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Top Status Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                  child: Column(
                    children: [
                      // Label Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _getBioStatusText(currentHP), // Dynamic Status
                              style: TextStyle(
                                color: _getHPColor(currentHP), // Dynamic Color
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                fontFamily: 'Space Grotesk',
                                shadows: [
                                  BoxShadow(
                                    color: _getHPColor(currentHP).withOpacity(0.8),
                                    blurRadius: 5,
                                  )
                                ]
                              ),
                            ),
                          ),
                          _buildStatItem(AppStrings.hpLabel, '${currentHP.toInt()}%', _getHPColor(currentHP)),
                          const SizedBox(width: 12),
                          _buildStatItem(AppStrings.coinsLabel, '${userState.coins}', AppColors.gluteOrange),
                          const SizedBox(width: 12),
                          _buildStatItem(AppStrings.levelLabel, '${userState.level}', AppColors.accentYellow),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Segmented HP Bar
                      SegmentedHealthBar(current: _currentHP),
                    ],
                  ),
                ),

                // Spacer
                const SizedBox(height: 16),

                // 2. Main Central Visualizer (Takes remaining space)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Stack(
                      children: [
                        DashboardVisualizer(hp: currentHP),
                        // Test Buttons Removed
                        const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),

                // Spacer before Nav
                const SizedBox(height: 4),
              ],
            ),
          ),

          // 3. Bottom Navigation (Overlay)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DashboardBottomNav(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() => _currentIndex = index);
                _handleNavigation(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleNavigation(int index) {
    switch (index) {
      case 0:
        // Already here
        break;
      case 1:
        // Library -> Recovery / Exercise
        context.push(AppRoutes.recoveryRecommendation);
        break;
      case 2:
        // Stats
        context.push(AppRoutes.statistics);
        break;
      case 3:
        // Profile
        context.push(AppRoutes.profile);
        break;
    }
  }
}

class _BackgroundGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Only paint a subtle grid in the background
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.05)
      ..strokeWidth = 1;

    // Use larger grid for background
    const gridSize = 40.0;
    
    for (var x = 0.0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    
    for (var y = 0.0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// _TestButton removed
