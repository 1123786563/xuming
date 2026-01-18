import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/cyber_button.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F5), // background-light
      body: Stack(
        children: [
          // Background grid
          Positioned.fill(
            child: CustomPaint(
              painter: _BackgroundPainter(),
            ),
          ),
          
          // Dark mode override wrapper
          Theme(
            data: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: const Color(0xFF000000), // background-dark
            ),
            child: Builder(
              builder: (context) {
                // Determine if we are in dark mode or force it for the 'monitoring' feel
                // The design code.html has <html class="dark"> so we should use dark theme colors mostly
                // But the body has "bg-background-light dark:bg-background-dark".
                // Let's assume we are mostly dark for this cyber interface.
                return Container(
                  color: const Color(0xFF000000),
                  child: SafeArea(
                    child: Column(
                      children: [
                        _buildHeader(),
                        const Divider(height: 1, color: AppColors.primary, thickness: 0.5),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSystemLogsOverlay(),
                                const SizedBox(height: 20),
                                _buildHPTrend(),
                                const SizedBox(height: 24),
                                _buildIndustrialDataCards(),
                                const SizedBox(height: 24),
                                _buildAchievements(),
                                const SizedBox(height: 24),
                                _buildSystemAdvice(),
                                const SizedBox(height: 80), // Padding for nav
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
          
          // Floating artifacts
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: 0,
            child: Container(width: 1, height: 80, color: AppColors.primary.withOpacity(0.4)),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            right: 0,
            child: Container(width: 1, height: 128, color: AppColors.secondary.withOpacity(0.4)),
          ),
          
          // Bottom Nav
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNav(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.black.withOpacity(0.8), // backdrop blur simulated
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.terminal, color: AppColors.primary, size: 24),
              const SizedBox(width: 8),
              Text(
                'SYS_V2.04\nSTATUS: ACTIVE',
                style: AppTypography.monoLabel.copyWith(
                  color: AppColors.primary.withOpacity(0.5),
                  fontSize: 10,
                  height: 1.0,
                ),
              ),
            ],
          ),
          Text(
            '生命监控中心',
            style: AppTypography.monoDecorative.copyWith(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.settings_input_component, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemLogsOverlay() {
    return Align(
      alignment: Alignment.centerRight,
      child: Opacity(
        opacity: 0.3, // Reduced opacity as per design intent "opacity-10" but visible enough
        child: Text(
          'LOG_ANALYSIS_SYNCING...\nCORE_TEMP_STABLE: 36.5C\nPOSTURE_ENGINE: POLLING\nENCRYPTED_LINK: ESTABLISHED\nPACKET_LOSS: 0.002%',
          textAlign: TextAlign.right,
          style: AppTypography.monoLabel.copyWith(
            color: AppColors.primary,
            fontSize: 8,
            height: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildHPTrend() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HEALTH POINT HISTORY',
                  style: AppTypography.monoLabel.copyWith(
                    color: AppColors.primary.withOpacity(0.6),
                    fontSize: 10,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'HP Trend',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.0,
                    fontFamily: 'Space Grotesk', // Fallback to sans
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '92%',
                  style: AppTypography.monoDecorative.copyWith(
                    color: AppColors.primary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '+5.2% VS LAST_WEEK',
                  style: TextStyle(
                    color: Color(0xFF0BDA2E),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 240,
          decoration: BoxDecoration(
            color: const Color(0xFF121A0A).withOpacity(0.4), // surface/40
            borderRadius: BorderRadius.circular(12), // xl
            border: Border.all(color: const Color(0xFF4D6B2E)), // pixel-border color
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Chart Content
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CustomPaint(
                    painter: _ChartPainter(),
                  ),
                ),
              ),
              // Top right dots
              Positioned(
                top: 8,
                right: 8,
                child: Row(
                  children: [
                    Container(width: 4, height: 4, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Container(width: 4, height: 4, color: AppColors.primary.withOpacity(0.3)),
                    const SizedBox(width: 4),
                    Container(width: 4, height: 4, color: AppColors.primary.withOpacity(0.3)),
                  ],
                ),
              ),
              // X-Axis Labels
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildChartLabel('05/01'),
                    _buildChartLabel('05/03'),
                    _buildChartLabel('05/05'),
                    _buildChartLabel('TODAY'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChartLabel(String text) {
    return Text(
      text,
      style: AppTypography.monoLabel.copyWith(
        color: AppColors.primary.withOpacity(0.6),
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildIndustrialDataCards() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.4, // Adjusted for card shape
      children: [
        // Total Life Extended
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF121A0A).withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primary.withOpacity(0.4)),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer, color: AppColors.primary, size: 14),
                      const SizedBox(width: 8),
                      Text(
                        '累计续命时长',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '48:22:15',
                    style: AppTypography.monoDecorative.copyWith(
                      color: AppColors.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ESTIMATED_RECOVERY: +12H',
                    style: AppTypography.monoLabel.copyWith(
                      color: AppColors.primary.withOpacity(0.4),
                      fontSize: 9,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Icon(Icons.hourglass_empty, color: AppColors.primary.withOpacity(0.2), size: 36),
              ),
              // Progress bar at bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 4,
                  color: AppColors.primary.withOpacity(0.1),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.75,
                    child: Container(color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Spine Warning Frequency
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF121A0A).withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.nuclearWarning.withOpacity(0.4)),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: AppColors.nuclearWarning, size: 14),
                      const SizedBox(width: 8),
                      Text(
                        '脊椎预警频率',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Bar Chart
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildMiniBar(0.3, AppColors.nuclearWarning.withOpacity(0.2)),
                        const SizedBox(width: 4),
                        _buildMiniBar(0.5, AppColors.nuclearWarning.withOpacity(0.4)),
                        const SizedBox(width: 4),
                        _buildMiniBar(0.8, AppColors.nuclearWarning.withOpacity(0.6)),
                        const SizedBox(width: 4),
                        _buildMiniBar(1.0, AppColors.nuclearWarning),
                        const SizedBox(width: 4),
                        _buildMiniBar(0.6, AppColors.nuclearWarning.withOpacity(0.5)),
                        const SizedBox(width: 4),
                        _buildMiniBar(0.4, AppColors.nuclearWarning.withOpacity(0.3)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '12 次/周',
                    style: AppTypography.monoDecorative.copyWith(
                      color: AppColors.nuclearWarning,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: -8,
                right: -8,
                child: Opacity(
                  opacity: 0.1,
                  child: Icon(Icons.person_pin, color: AppColors.nuclearWarning, size: 60),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMiniBar(double heightFactor, Color color) {
    return Expanded(
      child: FractionallySizedBox(
        heightFactor: heightFactor,
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ),
    );
  }

  Widget _buildAchievements() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'SURVIVAL ACHIEVEMENT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontFamily: 'Space Grotesk',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(child: Container(height: 1, color: AppColors.primary.withOpacity(0.2))),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAchievementItem(Icons.build, '首次修复', true),
            _buildAchievementItem(Icons.visibility_off, '潜行大师', true),
            _buildAchievementItem(Icons.bolt, '极限平衡', false),
            _buildAchievementItem(Icons.security, '终极防御', false),
          ],
        ),
      ],
    );
  }

  Widget _buildAchievementItem(IconData icon, String label, bool unlocked) {
    final color = unlocked ? AppColors.primary : Colors.white;
    final bgColor = unlocked ? AppColors.primary.withOpacity(0.2) : Colors.white.withOpacity(0.05);
    final borderColor = unlocked ? AppColors.primary : Colors.white.withOpacity(0.2);
    final opacity = unlocked ? 1.0 : 0.4;

    return Opacity(
      opacity: opacity,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: borderColor),
              boxShadow: unlocked ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 2,
                )
              ] : [],
            ),
            child: ClipPath(
              clipper: _BadgeClipper(),
              child: Container(
                alignment: Alignment.center,
                child: Icon(icon, color: color, size: 28),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTypography.monoLabel.copyWith(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemAdvice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.05),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        border: const Border(
          left: BorderSide(color: AppColors.secondary, width: 2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info, color: AppColors.secondary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SYSTEM ADVICE',
                  style: AppTypography.monoLabel.copyWith(
                    color: AppColors.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(text: '检测到脊椎 S3 区域压力过载。建议执行 '),
                      TextSpan(
                        text: '"深海呼吸"',
                        style: TextStyle(color: AppColors.primary),
                      ),
                      const TextSpan(text: ' 序列以恢复 HP 稳定性。'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        border: Border(top: BorderSide(color: AppColors.primary.withOpacity(0.2))),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavIcon(Icons.home, 'Home', false, () {
             context.go(AppRoutes.dashboard);
          }),
          _buildNavIcon(Icons.analytics, 'Monitor', true, () {}),
          Container(
            width: 56,
            height: 56,
            margin: const EdgeInsets.only(top: -32),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.4),
                  blurRadius: 20,
                ),
              ],
            ),
            child: const Icon(Icons.add, color: Colors.black, size: 32),
          ),
          _buildNavIcon(Icons.military_tech, 'Badge', false, () {
             context.push(AppRoutes.medalWall);
          }),
          _buildNavIcon(Icons.person, 'User', false, () {
             context.push(AppRoutes.profile);
          }),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, String label, bool isActive, VoidCallback onTap) {
    final color = isActive ? AppColors.primary : Colors.white.withOpacity(0.4);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: AppTypography.monoLabel.copyWith(
              color: color,
              fontSize: 9,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 2),
              width: 4,
              height: 4,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}

// Custom Painter for Chart
class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = AppColors.primary;

    final path = Path();
    
    // Hardcoded control points to mimic curve: "0 100 Q 40 100, 80 40 T 160 80 T 240 30 T 320 120 T 400 20 T 480 60"
    // Normalizing coordinates to size
    final width = size.width;
    final height = size.height;
    
    // Scale factors (original SVG viewed in HTML seems to be 480x150)
    final sx = width / 480;
    final sy = height / 150;

    path.moveTo(0, 100 * sy);
    path.quadraticBezierTo(40 * sx, 100 * sy, 80 * sx, 40 * sy);
    path.quadraticBezierTo(120 * sx, -20 * sy, 160 * sx, 80 * sy); // Approximated smooth curve for T
    path.quadraticBezierTo(200 * sx, 180 * sy, 240 * sx, 30 * sy);
    path.quadraticBezierTo(280 * sx, -20 * sy, 320 * sx, 120 * sy);
    path.quadraticBezierTo(360 * sx, 260 * sy, 400 * sx, 20 * sy);
    path.quadraticBezierTo(440 * sx, -20 * sy, 480 * sx, 60 * sy);

    // Glow effect
    final glowPaint = Paint()
      ..color = AppColors.primary.withOpacity(0.5)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      
    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);

    // Area fill
    final fillPath = Path.from(path);
    fillPath.lineTo(width, height);
    fillPath.lineTo(0, height);
    fillPath.close();

    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.primary.withOpacity(0.3),
        AppColors.primary.withOpacity(0.0),
      ],
    );

    final rect = Rect.fromLTWH(0, 0, width, height);
    final fillPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // Grid lines
    final gridPaint = Paint()
      ..color = AppColors.primary.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
      
      // Dashed line manual implementation omitted for brevity, using solid low opacity
      canvas.drawLine(Offset(0, 30 * sy), Offset(width, 30 * sy), gridPaint);
      canvas.drawLine(Offset(0, 75 * sy), Offset(width, 75 * sy), gridPaint);
      canvas.drawLine(Offset(0, 120 * sy), Offset(width, 120 * sy), gridPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.03)
      ..strokeWidth = 1;

    // Grid pattern
    const step = 20.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BadgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // clip-path: polygon(10% 0, 100% 0, 100% 70%, 90% 100%, 0 100%, 0% 30%);
    final w = size.width;
    final h = size.height;
    final path = Path();
    path.moveTo(w * 0.1, 0);
    path.lineTo(w, 0);
    path.lineTo(w, h * 0.7);
    path.lineTo(w * 0.9, h);
    path.lineTo(0, h);
    path.lineTo(0, h * 0.3);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
