import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../../shared/widgets/cyber_button.dart';

class NeckStretchPage extends StatelessWidget {
  const NeckStretchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Image.network(
                "https://lh3.googleusercontent.com/aida-public/AB6AXuArroUHE3eR7BYbzSXK7GeuOzVuc59ajrYN9FAeUlTWgEUFPVQzinn8Xau4HGIfYJy-GU69vQZUeXGz-ab7kJ1btpVV5q2aV_DMMzQp32tklUNHHBz346aBQybhJgss8yCoN6WRUNLwbWWNH9bT69UnrteuAW5ub-hmZEsU0yMF9DzUkxaDANlKbOyUGAPjROrO9RTx-DnVmYzfOAzJcugrzBxStk_WAY1nOLxPXIsTdJm72sTEMV-_bPNp0LkCjRQgG_BOZ1txbnk",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFF1a1a1a),
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.white24, size: 48),
                  ),
                ),
              ),
            ),
          ),
          
          // Scanline Overlay
          ScanlineOverlay(opacity: 0.1, color: AppColors.primary.withOpacity(0.1)),

          // 2. Main Content
          SafeArea(
            child: Column(
              children: [
                // Top Bar
                _buildTopBar(context),
                
                // Meta Data / HUD
                _buildHUD(),

                const Spacer(),

                // Central Overlay Guide (Visual Only)
                _buildOverlayGuide(),

                const Spacer(),

                // Headline
                _buildHeadline(),
                
                const SizedBox(height: 16),

                // Toxic Quote
                _buildToxicQuote(),

                // Bottom Control Panel
                _buildBottomPanel(),
              ],
            ),
          ),
          
          // Decorative Corners
          const Positioned(
            top: 0, left: 0,
            child: _CornerDecoration(isTopLeft: true),
          ),
          const Positioned(
            bottom: 0, right: 0,
            child: _CornerDecoration(isTopLeft: false),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.backgroundDark.withOpacity(0.8),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.white),
            ),
          ),
          
          Expanded(
            child: Column(
              children: [
                Text(
                  "PROJECT: CERVICAL_REPAIR_V2",
                  style: AppTypography.monoDecorative.copyWith(
                    color: AppColors.primary,
                    fontSize: 10,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "STATUS: ACTIVE_RECOVERY",
                  style: AppTypography.monoDecorative.copyWith(
                    color: AppColors.primary.withOpacity(0.5),
                    fontSize: 8,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),

          // Status Indicator
          Row(
            children: [
              Text(
                "BIO_SYNC",
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.primary,
                  fontSize: 10,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8, height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHUD() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SYS_CALIBRATING...",
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.primary,
                  fontSize: 10,
                ),
              ),
              Text(
                "LATENCY: 12ms",
                style: AppTypography.monoDecorative.copyWith(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 9,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "STRETCH_ANGLE: 45°",
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.nuclearWarning,
                  fontSize: 10,
                ),
              ),
              Text(
                "HEART_RATE: SYNCED",
                style: AppTypography.monoDecorative.copyWith(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverlayGuide() {
    return SizedBox(
      width: 200, height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Frame
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: AppColors.primary.withOpacity(0.2)),
                right: BorderSide(color: AppColors.primary.withOpacity(0.2)),
              ),
            ),
          ),
          
          // Dash Line
          Positioned(
            top: 60,
            child: Container(
              width: 100, height: 2,
              color: AppColors.nuclearWarning.withOpacity(0.8),
            ),
          ),
          
          // Arrow Icon
          const Positioned(
            right: 40, top: 40,
            child: Icon(Icons.keyboard_double_arrow_right, color: AppColors.nuclearWarning, size: 40),
          ),

          // Circle Outline Ghost
          Positioned(
            top: 70,
            child: Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary.withOpacity(0.4), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          child: Text(
            "侧向颈部拉伸",
            style: AppTypography.pixelHeadline.copyWith(
              color: Colors.white,
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 120, height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                AppColors.primary.withOpacity(0.5),
                Colors.transparent
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToxicQuote() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: AppColors.backgroundDark.withOpacity(0.9),
      child: Column(
        children: [
          const Icon(Icons.format_quote, color: Colors.white24, size: 32),
          Text(
            '"Stop pretending to work; your neck is screaming louder than your boss."',
            textAlign: TextAlign.center,
            style: AppTypography.bodySmall.copyWith(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "(别装在加班了，你的脖子叫得比老板还响。)",
            textAlign: TextAlign.center,
            style: AppTypography.monoBody.copyWith(
              color: AppColors.primary.withOpacity(0.7),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.backgroundDark,
        border: Border(top: BorderSide(color: Colors.white12)),
      ),
      child: Column(
        children: [
          // HP Recovery
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("RECOVERY UNIT", style: AppTypography.monoDecorative.copyWith(fontSize: 10, color: AppColors.primary.withOpacity(0.6))),
                  Text("HP RECOVERY", style: AppTypography.pixelHeadline.copyWith(fontSize: 18, color: AppColors.primary)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("00:42", style: AppTypography.monoHead.copyWith(fontSize: 24, color: Colors.white)),
                  Text("SEC_REMAINING", style: AppTypography.monoDecorative.copyWith(fontSize: 10, color: Colors.white38)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress Bar
          Container(
            height: 16,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white12),
              color: Colors.white.withOpacity(0.05),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.65,
              child: Container(color: AppColors.primary),
            ),
          ),
          const SizedBox(height: 24),

          // Buttons
          Row(
            children: [
              Expanded(
                child: CyberButton(
                  text: "ABORT_TASK",
                  onPressed: () => context.pop(),
                  primaryColor: Colors.white.withOpacity(0.1),
                  textColor: Colors.white,
                  icon: Icons.close,
                  isOutlined: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CyberButton(
                  text: "PAUSE_SYNC",
                  onPressed: () {},
                  primaryColor: AppColors.primary,
                  textColor: Colors.black,
                  icon: Icons.pause,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CornerDecoration extends StatelessWidget {
  final bool isTopLeft;
  const _CornerDecoration({required this.isTopLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64, height: 64,
      decoration: BoxDecoration(
        border: isTopLeft 
          ? const Border(
              top: BorderSide(color: AppColors.primary, width: 2),
              left: BorderSide(color: AppColors.primary, width: 2),
            )
          : const Border(
              bottom: BorderSide(color: AppColors.primary, width: 2),
              right: BorderSide(color: AppColors.primary, width: 2),
            ),
      ),
    );
  }
}
