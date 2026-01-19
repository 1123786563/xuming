import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/user_state_provider.dart';

class HpRecoverySuccessPage extends ConsumerStatefulWidget {
  const HpRecoverySuccessPage({super.key});

  @override
  ConsumerState<HpRecoverySuccessPage> createState() => _HpRecoverySuccessPageState();
}

class _HpRecoverySuccessPageState extends ConsumerState<HpRecoverySuccessPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1.0, curve: Curves.easeInOut)),
    );

    _controller.forward();
    _controller.repeat(reverse: true, min: 0.8, max: 1.0, period: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // Background Watermark
          Positioned.fill(
             child: Center(
               child: Transform.rotate(
                 angle: 1.5708, // 90 degrees
                 child: Text(
                   'XUMING',
                   style: TextStyle(
                     fontSize: 120,
                     fontWeight: FontWeight.w900,
                     color: Colors.white.withOpacity(0.03),
                     fontFamily: 'ZpixFont',
                   ),
                 ),
               ),
             ),
          ),

          // Scanline Overlay
          const ScanlineOverlay(opacity: 0.15),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTitle(),
                        const SizedBox(height: 32),
                        _buildSilhouette(),
                        const SizedBox(height: 32),
                        _buildProgressSection(),
                      ],
                    ),
                  ),
                ),
                _buildFooter(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.lifeSignal.withOpacity(0.2))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.terminal, color: AppColors.lifeSignal, size: 24),
          Column(
            children: [
              Text(
                'BIO_DATA_SYNC_COMPLETE',
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.lifeSignal,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.lifeSignal,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'LATENCY: 0.04ms // SECURE_LINK',
                    style: AppTypography.monoDecorative.copyWith(
                       fontSize: 8,
                       color: AppColors.lifeSignal.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Icon(Icons.qr_code_2, color: AppColors.lifeSignal, size: 24),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: Column(
        children: [
          Text(
            'LIFE EXTENDED:',
            style: AppTypography.pixelHeadline.copyWith(
              color: Colors.white,
              fontSize: 32,
              height: 1.0,
            ),
          ),
          Text(
            '+5 MINUTES',
            style: AppTypography.pixelHeadline.copyWith(
              color: AppColors.lifeSignal,
              fontSize: 48, // Slightly larger for emphasis
              height: 1.0,
              shadows: [
                Shadow(color: AppColors.lifeSignal.withOpacity(0.5), blurRadius: 20),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Current HP: ${ref.watch(userStateProvider).hp.toInt()}%',
            style: AppTypography.monoLabel.copyWith(
              color: AppColors.lifeSignal.withOpacity(0.8),
              letterSpacing: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSilhouette() {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glitch corners
          Positioned(top: 0, left: 0, child: _buildCorner(true, true)),
          Positioned(top: 0, right: 0, child: _buildCorner(true, false)),
          Positioned(bottom: 0, left: 0, child: _buildCorner(false, true)),
          Positioned(bottom: 0, right: 0, child: _buildCorner(false, false)),

          // Image (Placeholder for now, using a network image if needed or just an icon)
          // Using a container with a color filter for now to mimic the green silhouette
          Opacity(
            opacity: 0.8,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [AppColors.primary, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcIn,
              child: const Icon(
                Icons.accessibility_new, // Placeholder for silhouette
                size: 200,
                color: Colors.white,
              ),
            ),
          ),

          // Overlay Stats
          Positioned(
            top: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  color: AppColors.lifeSignal,
                  child: const Text(
                    'PULSE: 72BPM',
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    border: Border.all(color: AppColors.lifeSignal.withOpacity(0.4)),
                  ),
                  child: const Text(
                    'OXY: 99.2%',
                    style: TextStyle(fontSize: 8, color: AppColors.lifeSignal),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner(bool top, bool left) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        border: Border(
          top: top ? const BorderSide(color: AppColors.lifeSignal, width: 2) : BorderSide.none,
          bottom: !top ? BorderSide(color: AppColors.lifeSignal.withOpacity(0.3), width: 2) : BorderSide.none,
          left: left ? const BorderSide(color: AppColors.lifeSignal, width: 2) : BorderSide.none,
          right: !left ? BorderSide(color: AppColors.lifeSignal.withOpacity(0.3), width: 2) : BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Biological Integrity',
                style: AppTypography.monoLabel.copyWith(
                  color: AppColors.lifeSignal,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              Text(
                '100% RECOVERED',
                style: AppTypography.monoLabel.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
             height: 24,
             width: double.infinity,
             decoration: BoxDecoration(
               color: AppColors.lifeSignal.withOpacity(0.1),
               border: Border.all(color: AppColors.lifeSignal.withOpacity(0.3)),
             ),
             child: Stack(
               children: [
                 Container(
                   color: AppColors.lifeSignal,
                   width: double.infinity,
                 ),
                 // Segment lines
                 Row(
                   children: List.generate(
                     20,
                     (index) => Expanded(
                       child: Container(
                         decoration: const BoxDecoration(
                           border: Border(right: BorderSide(color: Colors.black, width: 2)),
                         ),
                       ),
                     ),
                   ),
                 ),
               ],
             ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ID: 4402-B-SYNC', style: AppTypography.monoDecorative.copyWith(fontSize: 8, color: AppColors.primary.withOpacity(0.6))),
              Text('STATUS: OPTIMIZED', style: AppTypography.monoDecorative.copyWith(fontSize: 8, color: AppColors.primary.withOpacity(0.6))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        border: Border(top: BorderSide(color: AppColors.primary.withOpacity(0.2))),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: AppColors.primary.withOpacity(0.4), width: 2)),
            ),
            child: Text(
              '"You managed to delay the inevitable. Go back to your digital slave cabin."',
              style: AppTypography.monoBody.copyWith(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildActionButton(
            text: 'INJECT BIO-COINS',
            icon: Icons.token,
            onPressed: () => context.push(AppRoutes.coinInjection),
            primary: true,
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            text: 'Share Insurance Policy',
            icon: Icons.verified_user,
            onPressed: () {
               // Placeholder for share
               context.push(AppRoutes.socialViral);
            },
            primary: false,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('NODE_OS_v4.2.0', style: AppTypography.monoDecorative.copyWith(fontSize: 8, color: Colors.white.withOpacity(0.3))),
              Text('0xFF00-HP-SYNCED', style: AppTypography.monoDecorative.copyWith(fontSize: 8, color: Colors.white.withOpacity(0.3))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    required bool primary,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56, // Slightly taller
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? AppColors.lifeSignal : Colors.transparent,
          foregroundColor: primary ? Colors.black : AppColors.lifeSignal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: primary ? BorderSide.none : const BorderSide(color: AppColors.lifeSignal),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(
              text.toUpperCase(),
              style: const TextStyle(
                fontFamily: 'ZpixFont', // Or Space Grotesk if we mapped it, but designs use ZPixel or similar for emphasis usually
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
