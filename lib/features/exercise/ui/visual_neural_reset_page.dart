import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/grid_background.dart';
import '../../../shared/widgets/scanline_overlay.dart';

/// 视觉神经重置指引页 (Variant 1)
class VisualNeuralResetPage extends StatefulWidget {
  const VisualNeuralResetPage({super.key});

  @override
  State<VisualNeuralResetPage> createState() => _VisualNeuralResetPageState();
}

class _VisualNeuralResetPageState extends State<VisualNeuralResetPage> with SingleTickerProviderStateMixin {
  late AnimationController _arrowController;

  @override
  void initState() {
    super.initState();
    _arrowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _arrowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Theme(
        data: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.void_,
          primaryColor: AppColors.visualResetGreen,
          iconTheme: const IconThemeData(color: AppColors.visualResetGreen),
        ),
        child: Stack(
          children: [
            // 1. Grid Background (Wireframe)
            const GridBackground(
              lineColor: AppColors.visualResetGreen,
              gridSize: 20,
              lineOpacity: 0.05,
            ),

            // 2. Scanline Overlay
            ScanlineOverlay(
              opacity: 0.2,
              color: AppColors.visualResetGreen.withOpacity(0.1),
            ),

            // 3. Main Content
            SafeArea(
              child: Column(
                children: [
                  _buildTopBar(context),
                  _buildHeadline(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildMainVisual(),
                          _buildPhaseIndicator(),
                          const SizedBox(height: 24),
                          _buildQuote(),
                          const SizedBox(height: 16),
                          _buildStatsCards(),
                          const SizedBox(height: 24),
                          _buildProgressBar(),
                        ],
                      ),
                    ),
                  ),
                  _buildBottomNav(),
                ],
              ),
            ),
            
            // Decorative corner glow/vignette could be added here if needed
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
            color: AppColors.visualResetGreen,
          ),
          Column(
            children: [
              Text(
                "SYSTEM ACTIVE",
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.visualResetGreen,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 12,
                  shadows: [
                    Shadow(color: AppColors.visualResetGreen.withOpacity(0.8), blurRadius: 10),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 48,
                height: 4,
                color: AppColors.visualResetGreen,
              ),
            ],
          ),
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            child: const Icon(Icons.memory, color: AppColors.visualResetGreen),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "任务:\n视觉神经重置",
            style: AppTypography.pixelHeadline.copyWith(
              color: AppColors.visualResetGreen,
              height: 1.1,
              fontStyle: FontStyle.italic,
              shadows: [
                Shadow(color: AppColors.visualResetGreen.withOpacity(0.8), blurRadius: 10),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                color: AppColors.visualResetGreen,
              ),
              const SizedBox(width: 8),
              Text(
                "PROTOCOL: OCULAR_CALIBRATION_V1.0.4",
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.visualResetGreen.withOpacity(0.8),
                  fontSize: 10,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainVisual() {
    return Container(
      height: 320,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorative Corners
          Positioned(top: 20, left: 20, child: _buildCorner(true, true)),
          Positioned(top: 20, right: 20, child: _buildCorner(true, false)),
          Positioned(bottom: 20, left: 20, child: _buildCorner(false, true)),
          Positioned(bottom: 20, right: 20, child: _buildCorner(false, false)),

          // Central Visual (Placeholder for 3D Head)
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuCKt1rRUnkpzF_N8c5RaaTrXTMQ96FIc2txGfeCsIbDJ6YdzrZCchYsXP9A_BltS0mpYm9bmhcHV26blIP89_xIbaViTKMY76QUrkDh9foJlXn-3-PmYl9SCV0MJtxKHEVuy_tPXLzSsbjKfvAxKVqAiaOKYnjTmAfl8fCiGzifkFnn0MmyYZsjqjQhf8apC-f3SbUWSEfpd1pWXmq-HAutjSDHUO2B-CCCi1eznCBftC6cCVeg52y4W5ytTvgPYXjyvuutRRv6gxY"),
                fit: BoxFit.contain,
              ),
              boxShadow: [
                 BoxShadow(
                   color: AppColors.visualResetGreen.withOpacity(0.4),
                   blurRadius: 15,
                   spreadRadius: 0,
                 )
              ]
            ),
          ),
          
          // Directional Arrows
          Positioned(
            top: 0,
            child: FadeTransition(
              opacity: _arrowController,
              child: const Icon(Icons.keyboard_double_arrow_up, size: 48, color: AppColors.visualResetGreen),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: 0.4,
              child: const Icon(Icons.keyboard_double_arrow_down, size: 48, color: AppColors.visualResetGreen),
            ),
          ),
          Positioned(
            left: 0,
            child: Opacity(
              opacity: 0.4,
              child: const Icon(Icons.keyboard_double_arrow_left, size: 48, color: AppColors.visualResetGreen),
            ),
          ),
          Positioned(
            right: 0,
            child: Opacity(
              opacity: 0.4,
              child: const Icon(Icons.keyboard_double_arrow_right, size: 48, color: AppColors.visualResetGreen),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner(bool top, bool left) {
    const double size = 32;
    const double thickness = 2;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border(
          top: top ? const BorderSide(color: AppColors.visualResetGreen, width: thickness) : BorderSide.none,
          bottom: !top ? const BorderSide(color: AppColors.visualResetGreen, width: thickness) : BorderSide.none,
          left: left ? const BorderSide(color: AppColors.visualResetGreen, width: thickness) : BorderSide.none,
          right: !left ? const BorderSide(color: AppColors.visualResetGreen, width: thickness) : BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPhaseIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.visualResetGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.visualResetGreen.withOpacity(0.3)),
      ),
      child: Text(
        "PHASE: LOOK UP",
        style: AppTypography.monoDecorative.copyWith(
          color: AppColors.visualResetGreen,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          fontSize: 12,
          shadows: [
            Shadow(color: AppColors.visualResetGreen.withOpacity(0.5), blurRadius: 5),
          ],
        ),
      ),
    );
  }

  Widget _buildQuote() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: AppColors.visualResetGreen.withOpacity(0.4), width: 2),
          ),
        ),
        child: Text(
          "\"Your eyes are frying from the blue light. Give them a break or buy a braille keyboard.\"",
          style: AppTypography.monoBody.copyWith(
            color: AppColors.visualResetGreen.withOpacity(0.7),
            fontStyle: FontStyle.italic,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: _buildStatCard("LATENCY", "0.04ms")),
          const SizedBox(width: 8),
          Expanded(child: _buildStatCard("REFRESH", "120HZ")),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        border: Border.all(color: AppColors.visualResetGreen.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: AppColors.visualResetGreen.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.monoDecorative.copyWith(
              color: AppColors.visualResetGreen.withOpacity(0.6),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.pixelHeadline.copyWith(
              color: AppColors.visualResetGreen,
              fontSize: 24,
              shadows: [
                Shadow(color: AppColors.visualResetGreen.withOpacity(0.8), blurRadius: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      height: 4,
      width: double.infinity,
      color: AppColors.visualResetGreen.withOpacity(0.1),
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: 0.66,
            child: Container(
              color: AppColors.visualResetGreen,
              boxShadow: const [
                BoxShadow(color: AppColors.visualResetGreen, blurRadius: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        border: Border(top: BorderSide(color: AppColors.visualResetGreen.withOpacity(0.2))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.home, color: AppColors.visualResetGreen.withOpacity(0.4)),
          Icon(Icons.grid_view, color: AppColors.visualResetGreen, size: 32, shadows: const [Shadow(color: AppColors.visualResetGreen, blurRadius: 10)]),
          Icon(Icons.person, color: AppColors.visualResetGreen.withOpacity(0.4)),
        ],
      ),
    );
  }
}
