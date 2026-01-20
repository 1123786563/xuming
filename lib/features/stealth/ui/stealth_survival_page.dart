import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/user_state_provider.dart';
import '../../../shared/widgets/grid_background.dart';
import '../../../shared/widgets/scanline_overlay.dart';

class StealthSurvivalPage extends ConsumerStatefulWidget {
  const StealthSurvivalPage({super.key});

  @override
  ConsumerState<StealthSurvivalPage> createState() => _StealthSurvivalPageState();
}

class _StealthSurvivalPageState extends ConsumerState<StealthSurvivalPage> with SingleTickerProviderStateMixin {
  late AnimationController _radarController;
  late AnimationController _pulseController;
  
  // Stealth Theme Colors
  static const Color stealthGreen = Color(0xFF2E9D47);
  static const Color stealthBlue = Color(0xFF1A2530);
  static const Color stealthPrimary = Color(0xFF3B4A59);
  static const Color stealthBgDark = Color(0xFF000000);

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    
    _pulseController = AnimationController(
        vsync: this, 
        duration: const Duration(milliseconds: 1500)
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _radarController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stealthBgDark,
      body: Stack(
        children: [
          // 1. Background Grid
          const GridBackground(
            lineColor: stealthBlue,
            gridSize: 40,
            lineOpacity: 0.3,
          ),
          
          // 2. Scanlines
          ScanlineOverlay(
            opacity: 0.1, 
            color: stealthPrimary.withOpacity(0.2)
          ),

          // 3. Main Content
          SafeArea(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          _buildRadarSection(),
                          const SizedBox(height: 16),
                          _buildActionVisual(),
                          const SizedBox(height: 32),
                          _buildPhaseInfo(),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: stealthBgDark.withOpacity(0.8),
        border: Border(bottom: BorderSide(color: stealthPrimary.withOpacity(0.2))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Icon
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: stealthPrimary.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.terminal, color: stealthPrimary),
              onPressed: () => context.pop(),
            ),
          ),

          // Center Status
          Column(
            children: [
              Text(
                "SYSTEM STATUS",
                style: AppTypography.monoDecorative.copyWith(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 10,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  FadeTransition(
                    opacity: _pulseController,
                    child: Container(
                      width: 8, height: 8,
                      decoration: const BoxDecoration(
                        color: stealthGreen,
                        shape: BoxShape.circle,
                        boxShadow: [
                           BoxShadow(color: stealthGreen, blurRadius: 4, spreadRadius: 1)
                        ]
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "当前状态：隐蔽中",
                    style: TextStyle(
                      fontFamily: 'DotGothic16', // Fallback to a standard font if not loaded, used custom logic via TextStyle
                      color: stealthGreen,
                      fontSize: 14,
                      letterSpacing: 1.2,
                    ),
                  )
                ],
              )
            ],
          ),

          // Right Icon (Sync Button)
          GestureDetector(
            onTap: () {
              final notifier = ref.read(userStateNotifierProvider.notifier);
              notifier.addHp(5);
              notifier.addCoins(100);
              context.push(AppRoutes.hpRecoverySuccess);
            },
            child: Container(
              width: 50, height: 40,
              decoration: BoxDecoration(
                color: stealthGreen.withOpacity(0.1),
                border: Border.all(color: stealthGreen.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  "SYNC",
                  style: TextStyle(color: stealthGreen, fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadarSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Stats
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatBox("BOSS PROXIMITY", "12.4m", Colors.grey.shade300, stealthBlue.withOpacity(0.2), stealthPrimary.withOpacity(0.4)),
              const SizedBox(height: 12),
              _buildStatBox("DETECTION RISK", "MINIMAL", stealthGreen, stealthGreen.withOpacity(0.05), stealthGreen.withOpacity(0.4)),
            ],
          ),
          
          // Radar
          Container(
            width: 96, height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: stealthPrimary.withOpacity(0.3)),
              color: Colors.black,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Rings
                Container(
                  width: 72, height: 72,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: stealthPrimary.withOpacity(0.1))),
                ),
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: stealthPrimary.withOpacity(0.1))),
                ),
                // Center
                Container(width: 6, height: 6, decoration: const BoxDecoration(color: stealthGreen, shape: BoxShape.circle, boxShadow: [BoxShadow(color: stealthGreen, blurRadius: 6)])),
                // Sweep
                RotationTransition(
                  turns: _radarController,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [Colors.transparent, Color(0x4D2E9D47)], 
                        stops: [0.75, 1.0],
                      ),
                    ),
                  ),
                ),
                // Blip
                Positioned(
                  top: 20, right: 24,
                  child: FadeTransition(
                    opacity: _pulseController,
                    child: Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, String value, Color valueColor, Color bgColor, Color borderColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(left: BorderSide(color: borderColor, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.monoDecorative.copyWith(
              color: Colors.white.withOpacity(0.4),
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.pixelHeadline.copyWith(
              color: valueColor,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionVisual() {
    return Stack(
      children: [
        // Background Glow
        Center(
          child: Container(
            width: 320, height: 320,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [stealthPrimary.withOpacity(0.1), Colors.transparent],
                radius: 0.7,
              )
            ),
          ),
        ),
        
        // Frame
        Center(
          child: Container(
            width: 300, height: 300,
            decoration: BoxDecoration(
              color: stealthBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: stealthPrimary.withOpacity(0.2)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image
                Image.network(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuD4mITgDrd0Nwh_8bGnh__hGvm5SUbZCMtrNkQr5kT1hq1sZbRdB5alghi-4keT4fY00RTM18bHPW5HUsxgtR-Htd3pWPSKFa8mCHQ3Zu-4VLx7WA4Yg49ULgzyMu0jCeQ02-_KZpZ-yih5uNuC4tqxiS5_i0cocaymAHHw3RGod-wugZTiINXlbGHjVymfQfTx63fnMLPcn-qbgfA0g_ovpJ3vpngxCHon0efvUuQM9aYxG7xVJMQdN3n2Jsk88KYGA-xA4nPzsIQ",
                  fit: BoxFit.cover,
                  color: Colors.white.withOpacity(0.8),
                  colorBlendMode: BlendMode.modulate,
                  errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image, color: stealthPrimary, size: 48)),
                ),
                
                // REC Timer
                Positioned(
                  bottom: 16, left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      border: Border.all(color: stealthPrimary.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "REC 00:42:01",
                      style: AppTypography.monoDecorative.copyWith(color: Colors.grey.shade300, fontSize: 12),
                    ),
                  ),
                ),

                // Corner Brackets
                _buildCornerBracket(top: 0, left: 0),
                _buildCornerBracket(top: 0, right: 0),
                _buildCornerBracket(bottom: 0, left: 0),
                _buildCornerBracket(bottom: 0, right: 0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCornerBracket({double? top, double? bottom, double? left, double? right}) {
    return Positioned(
      top: top, bottom: bottom, left: left, right: right,
      child: Container(
        width: 16, height: 16,
        decoration: BoxDecoration(
          border: Border(
            top: top != null ? BorderSide(color: stealthPrimary.withOpacity(0.6), width: 2) : BorderSide.none,
            bottom: bottom != null ? BorderSide(color: stealthPrimary.withOpacity(0.6), width: 2) : BorderSide.none,
            left: left != null ? BorderSide(color: stealthPrimary.withOpacity(0.6), width: 2) : BorderSide.none,
            right: right != null ? BorderSide(color: stealthPrimary.withOpacity(0.6), width: 2) : BorderSide.none,
          )
        ),
      ),
    );
  }

  Widget _buildPhaseInfo() {
    return Column(
      children: [
        Text(
          "动作：桌下踝泵",
          style: AppTypography.pixelHeadline.copyWith(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "PHASE 01: LOW PROFILE MOBILITY",
          style: AppTypography.monoDecorative.copyWith(
            color: stealthPrimary,
            fontSize: 10,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.transparent, // Gradient handled by parent or body background mostly
      ),
      child: Column(
        children: [
          // Quote Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: stealthBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: stealthPrimary.withOpacity(0.2)),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned(
                  top: -24, left: -12,
                  child: Icon(Icons.format_quote, color: stealthPrimary, size: 24),
                ),
                Text(
                  "“偷偷动一动，别让你的血液像你的晋升机会一样淤积。”",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Nav Bar (Mockup)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: (){}, 
                icon: const Icon(Icons.grid_view, color: stealthPrimary)
              ),
              const SizedBox(width: 24),
              Container(width: 48, height: 4, decoration: BoxDecoration(color: stealthPrimary.withOpacity(0.2), borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 24),
              IconButton(
                onPressed: (){}, 
                icon: const Icon(Icons.settings_input_component, color: stealthPrimary)
              ),
            ],
          )
        ],
      ),
    );
  }
}
