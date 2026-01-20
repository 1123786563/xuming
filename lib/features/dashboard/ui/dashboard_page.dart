import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/user_state_provider.dart';
import '../../../shared/widgets/grid_background.dart';
import 'widgets/dashboard_bottom_nav.dart';
import 'widgets/dashboard_visualizer.dart';
import 'widgets/segmented_health_bar.dart';

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
    if (hp > 30) return AppColors.cautionYellow;
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
            letterSpacing: 1.5,
          ),
        ),
        Text(
          value,
          style: AppTypography.pixelBody.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
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
    
    final userStateAsync = ref.watch(userStateNotifierProvider);
    final userState = userStateAsync.valueOrNull ?? const UserState();
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
          const Positioned.fill(
            child: GridBackground(
              gridSize: 40,
              lineColor: AppColors.primary,
              lineOpacity: 0.05,
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
                              style: AppTypography.pixelData.copyWith(
                                color: _getHPColor(currentHP), // Dynamic Color
                                fontSize: 18,
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
                            _buildStatItem(AppStrings.levelLabel, '${userState.level}', AppColors.cautionYellow),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Segmented HP Bar
                      SegmentedHealthBar(current: currentHP),
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

// _TestButton removed
