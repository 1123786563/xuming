import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../report/ui/weekly_report_dialog.dart';
import 'widgets/segmented_health_bar.dart';
import 'widgets/dashboard_visualizer.dart';
import 'widgets/dashboard_bottom_nav.dart';

/// 生存仪表盘主页 - 终极版
/// 
/// 核心监控界面，展示 HP、人体模型热力图
/// 采用赛博朋克风格，强调视觉冲击力和沉浸感
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // 模拟数据
  double _currentHP = 85;
  int _currentIndex = 0; // 0: Monitor, 1: Library, 2: Stats, 3: Profile

  @override
  Widget build(BuildContext context) {
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Changed to spaceBetween in design but spaceEvenly works nicely for 2 items
                        children: [
                          Expanded(
                            child: Text(
                              'BIO_STATUS: STABLE',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                fontFamily: 'Space Grotesk',
                                shadows: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.8),
                                    blurRadius: 5,
                                  )
                                ]
                              ),
                            ),
                          ),
                          Text(
                            '${_currentHP.toInt()}%',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontFamily: 'Space Mono', // or decorative
                            ),
                          ),
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
                        const DashboardVisualizer(),
                        // Temporary Test Buttons
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _TestButton(
                                label: "TEST: STEALTH",
                                icon: Icons.biotech,
                                color: const Color(0xFF00BCD4),
                                onTap: () => context.push(AppRoutes.stealthStomachVacuum),
                              ),
                              const SizedBox(height: 10),
                              _TestButton(
                                label: "SIMULATE ALERT",
                                icon: Icons.warning_amber_rounded,
                                color: AppColors.nuclearWarning,
                                onTap: () => context.push(AppRoutes.sedentaryReminder),
                              ),
                              const SizedBox(height: 10),
                              _TestButton(
                                label: "TEST: WELCOME",
                                icon: Icons.new_releases,
                                color: AppColors.primary,
                                onTap: () => context.push(AppRoutes.featureReadyWelcome),
                              ),
                            ],
                          ),
                        ),
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

class _TestButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _TestButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color, width: 1),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.3), blurRadius: 10),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTypography.monoDecorative.copyWith(
                color: Colors.white,
                fontSize: 10,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
