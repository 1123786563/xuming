import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/grid_background.dart';
import '../../../shared/widgets/scanline_overlay.dart';

/// 臀部机能唤醒指引页 (Variant 3)
class GluteActivationPage extends StatefulWidget {
  const GluteActivationPage({super.key});

  @override
  State<GluteActivationPage> createState() => _GluteActivationPageState();
}

class _GluteActivationPageState extends State<GluteActivationPage> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // 1. Grid Background
          const GridBackground(
            lineColor: AppColors.surface_dark,
            gridSize: 20,
            lineOpacity: 0.2,
          ),

          // 2. Scanline Overlay
          ScanlineOverlay(
            opacity: 0.1,
            color: AppColors.gluteOrange.withOpacity(0.05),
          ),

          // 3. Main Content
          Column(
            children: [
              _buildTopBar(context),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      _build3DViewer(),
                      const SizedBox(height: 24),
                      _buildHeadlineCard(),
                      const SizedBox(height: 24),
                      _buildStatsGrid(),
                      const SizedBox(height: 24),
                      _buildTimerSection(),
                      const SizedBox(height: 100), // 为底部操作栏留空间
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 4. Bottom Action Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomActionBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.void_.withOpacity(0.8),
          border: const Border(bottom: BorderSide(color: Colors.white12)),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "SYSTEM: ACTIVE",
                    style: AppTypography.monoDecorative.copyWith(
                      color: const Color(0xFF00FFFF), // neon-cyan
                      fontSize: 10,
                      letterSpacing: 2,
                    ),
                  ),
                  const Text(
                    "任务: 臀部机能唤醒",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.share, color: Colors.white, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _build3DViewer() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0D1218),
          border: Border.all(color: Colors.white10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            // Background Grid
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: CustomPaint(painter: _DotGridPainter()),
              ),
            ),
          
          // Model Placeholder (Wireframe represented by an icon/image)
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Inner Glow for Highlighting Glutes
                Positioned(
                  bottom: 100,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildPulseRing(),
                      const SizedBox(width: 40),
                      _buildPulseRing(),
                    ],
                  ),
                ),
                // The Model Image
                Image.network(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuD_IKpPWTTUcQxiLb2XvtRxAY-Y2VSBCxRRZ13pG0KFg6Cl0SjY0VIHnm_afgZbqYREw-Fmd7wJAgkpN_lmTdkznKsFq3-Oy-IRBzxxoerb51G8sv5RLi-caUgB_sigx892JInJvNv-i8Mw_VnR1zdIxlY4Wzv3x10R0q2-yf1gPEbIR0AG_xb8UmpwNbVviitzDN1JANEbjdGo1FmEF49IzgdQ6C3PdveZXmcmrW25hi09rQ5hjyluK1tQ7CPDt-f05lryrKPn5aQ",
                  width: 240,
                  height: 240,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.accessibility_new,
                    size: 160,
                    color: Colors.white10,
                  ),
                ),
              ],
            ),
          ),

          // HUD Accents
          Positioned(top: 16, left: 16, child: _buildHUDCorner(top: true, left: true)),
          Positioned(top: 16, right: 16, child: _buildHUDCorner(top: true, left: false)),
          Positioned(bottom: 16, left: 16, child: _buildHUDCorner(top: false, left: true)),
          Positioned(bottom: 16, right: 16, child: _buildHUDCorner(top: false, left: false)),

          // Viewport Tag
          Positioned(
            top: 24,
            left: 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "VIEWPORT: 01_SIT_POS",
                  style: AppTypography.monoDecorative.copyWith(
                    color: const Color(0xFF00FFFF),
                    fontSize: 10,
                  ),
                ),
                const Text(
                  "LAT: 34.0522° N",
                  style: TextStyle(color: Colors.white54, fontSize: 10, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildPulseRing() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: 50 + (20 * _pulseController.value),
          height: 50 + (20 * _pulseController.value),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.gluteOrange.withOpacity(1 - _pulseController.value),
              width: 2,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHUDCorner({required bool top, required bool left}) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        border: Border(
          top: top ? const BorderSide(color: Color(0xFF00FFFF), width: 2) : BorderSide.none,
          bottom: !top ? const BorderSide(color: Color(0xFF00FFFF), width: 2) : BorderSide.none,
          left: left ? const BorderSide(color: Color(0xFF00FFFF), width: 2) : BorderSide.none,
          right: !left ? const BorderSide(color: Color(0xFF00FFFF), width: 2) : BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildHeadlineCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface_dark.withOpacity(0.4),
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
        border: const Border(left: BorderSide(color: AppColors.gluteOrange, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "PRIORITY INSTRUCTION",
            style: AppTypography.monoDecorative.copyWith(
              color: Colors.white60,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3),
              children: [
                const TextSpan(text: "Stop letting your glutes turn into office chair cushions. "),
                TextSpan(
                  text: "Squeeze!",
                  style: TextStyle(color: AppColors.gluteOrange, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildStatItem("ENGAGEMENT", "85%", "+12%", Icons.bolt)),
            const SizedBox(width: 12),
            Expanded(child: _buildStatItem("SYMMETRY", "98%", "STABLE", Icons.balance, iconColor: const Color(0xFF00FFFF))),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface_dark,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSimpleStat("CURRENT PROTOCOL", "05 / 10 REPS"),
              _buildSimpleStat("TARGET HOLD", "5.0s", valueColor: AppColors.gluteOrange),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, String subValue, IconData icon, {Color? iconColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface_dark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold)),
              Icon(icon, color: iconColor ?? AppColors.gluteOrange, size: 14),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Text(subValue, style: TextStyle(color: const Color(0xFF00FFFF).withOpacity(0.8), fontSize: 10, fontFamily: 'monospace')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleStat(String label, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: valueColor ?? Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTimerSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface_dark,
        borderRadius: BorderRadius.circular(12),
        border: Border(top: BorderSide(color: AppColors.gluteOrange.withOpacity(0.4), width: 2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("CONTRACTION TIMER", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  Text("ISOMETRIC LOAD PHASE", style: TextStyle(color: Colors.white54, fontSize: 10, letterSpacing: 1)),
                ],
              ),
              const Text("03.2s", style: TextStyle(color: AppColors.gluteOrange, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 12,
            width: double.infinity,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.void_,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white10),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.65,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.gluteOrange,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(color: AppColors.gluteOrange.withOpacity(0.4), blurRadius: 8),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.radio_button_checked, color: AppColors.gluteOrange, size: 16),
                  SizedBox(width: 8),
                  Text("Hold Maximum Tension", style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
              Text(
                "CALIBRATING...",
                style: AppTypography.monoDecorative.copyWith(
                  color: const Color(0xFF00FFFF),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 8),
      decoration: BoxDecoration(
        color: AppColors.void_.withOpacity(0.95),
        border: const Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {}, // TODO: Implement activation logic
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.gluteOrange,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: AppColors.gluteOrange.withOpacity(0.4), blurRadius: 12),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ENGAGE GLUTES",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.offline_bolt, color: Colors.white, size: 24),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Tab Navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.fitness_center, "Mission", isActive: true),
              _buildNavItem(Icons.monitor_heart, "Biometrics"),
              _buildNavItem(Icons.settings_input_component, "Hardware"),
              _buildNavItem(Icons.person_pin, "Profile"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? AppColors.gluteOrange : Colors.white24, size: 24),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: isActive ? AppColors.gluteOrange : Colors.white24,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2E3A4B)
      ..strokeWidth = 1;

    const spacing = 20.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
