
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../profile/ui/widgets/medal_hexagon.dart';
import '../../../shared/widgets/scanline_overlay.dart';

/// 生存成就 - 勋章墙界面
class MedalWallPage extends StatefulWidget {
  const MedalWallPage({super.key});

  @override
  State<MedalWallPage> createState() => _MedalWallPageState();
}

class _MedalWallPageState extends State<MedalWallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_, // Deep OLED Black
      body: Stack(
        children: [
          // Background Ambience
          _buildBackgroundAmbience(),
          
          // Scanlines
          const ScanlineOverlay(),
          
          // Main Content
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                _buildStatsSection(),
                _buildDivider(),
                Expanded(
                  child: _buildMedalGrid(),
                ),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundAmbience() {
    return Stack(
      children: [
        // Grid Pattern (Simulated with CustomPaint or Image, simplified here with color/container)
        Positioned.fill(
          child: Opacity(
            opacity: 0.2,
            child: CustomPaint(
              painter: GridPainter(),
            ),
          ),
        ),
        // System Logs
        Positioned(
          top: 100,
          right: -20,
          child: Transform.rotate(
            angle: 90 * 3.14159 / 180,
            child: Text(
              '> SYSTEM_LOG: SYNCING_BIOMETRICS... OK\n> NETWORK: SECURE_CHANNEL_ESTABLISHED\n> USER_ID: 8849-XC-99',
              style: TextStyle(
                fontFamily: 'ZpixFont',
                fontSize: 10,
                color: AppColors.lifeSignal.withOpacity(0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.void_.withOpacity(0.9),
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFF333333),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                // hover effect normally handled by inkwell
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.lifeSignal,
                size: 20,
              ),
            ),
          ),
          const Text(
            '生存成就',
            style: TextStyle(
              fontFamily: 'ZpixFont',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Color.fromRGBO(63, 255, 20, 0.5),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: const Icon(
              Icons.share,
              color: AppColors.lifeSignal,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'SURVIVAL LEVEL',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: AppColors.nuclearWarning, // Using gold-ish color from theme if available, otherwise fallback
                ),
              ),
              Text(
                '850/1000 XP',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'SENIOR TECH',
                  style: TextStyle(
                    fontFamily: 'ZpixFont',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: ' 资深技术员',
                  style: TextStyle(
                    fontFamily: 'ZpixFont',
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Progress Bar
          Transform(
            transform: Matrix4.skewX(-0.17), // -10 degrees
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                border: Border.all(color: const Color(0xFF333333)),
              ),
              padding: const EdgeInsets.all(2),
              child: Row(
                children: [
                  Expanded(
                    flex: 85,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.lifeSignal,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lifeSignal,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Container(
                         decoration: BoxDecoration(
                           gradient: LinearGradient(
                             colors: [Colors.transparent, Colors.black.withOpacity(0.5), Colors.transparent],
                             stops: const [0, 0.5, 1],
                           )
                         ),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 15,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '> NEXT_LEVEL: CYBER_ATHLETE',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 10,
                  color: AppColors.lifeSignal,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.lifeSignal.withOpacity(0.2),
                  border: Border.all(color: AppColors.lifeSignal.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Text(
                  '+15% BOOST ACTIVE',
                  style: TextStyle(
                    fontFamily: 'ZpixFont',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lifeSignal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Color(0xFF333333),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildMedalGrid() {
    // Mock Data
    final medals = [
      {
        'state': MedalState.unlocked,
        'title': 'Spine Guard',
        'subtitle': '护脊卫士',
        'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBca13A3C88zxGMktsZPIxvhDy_gGi36-yo5AL0EYYsBZjpXxzTMPXdVcYh2ldYgthJH1FthjkUAshAxwR2NAvDlLEyhUhmKkHZMVhU6Wr1ocqAF4AEWjOiLf27km1fsXi62cjee9nnVRr7FbJWZd7GoFiizBQu0-Dox6nDfDgbcIuCFEihMvJvqm5VfmJlS1Dz9g7FWbA2KWMvb5Xh30H5X0uhGCcWr7oSibWiayj7wv73_likSqNMmtDuXkvaY0jJkGaAaqhQHPw',
      },
      {
        'state': MedalState.unlocked,
        'title': 'Nuclear Survivor',
        'subtitle': '辐射幸存者',
        'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuA0FBetB0qdQNtPNZ-6nMq3V5LhR-Cc_7kIWb0wzpkRuYEgay3ynqj8Xc0cJN8hNGtM9Sk0bkgTSVno84RPhA2IWiMqS7fEHYyOe74h4bs2Zlcdw2ggG39LfDor6mEAk53-V3WkQs-2P0NkQLuOYZr34V69pGBdbJuRZGn6_2oTwc_gdHUvqOTt-1NjBpKVIQOgQpiMZO_4yfKYkzBCoaM2XE9vHPotMGGMbjOKouwU3AFhuNRNWQOspoSmk5lzT_P_sgr9lcozTaU',
      },
      {
        'state': MedalState.unlocked,
        'title': 'Hydration Hero',
        'subtitle': '水润英雄',
        'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuA5QLvMFJE4FYsv2CU6FEYn6OGucEbrS1zgrzl8S8rGRyQcQpgYb6WcmPVjjA-atu_lbDhyK91PkUUN5Kh1bNrH5JmyAdRoK7Fmb5GpZTVUkimfrQ1Lt7pCdmjtowXLN5Ra8qEgG3Bh0B7hUsRrjXsu1gpiGsR7uELEJVwum_X4s_i60nNYdi5ERBUhF0LUJT_32CZw06GZpUELPAxb35UXMPoa6swicr_3S130_z2Su3o17b7YPR2rp-wMCieGbMT2fAQ6JwvqhnA',
      },
      {
        'state': MedalState.locked,
        'title': 'Stealth Master',
        'subtitle': '隐形大师',
      },
      {
        'state': MedalState.locked,
        'title': 'Eye Saver',
        'subtitle': '护眼专家',
      },
      {
        'state': MedalState.locked,
        'title': 'Desk Warrior',
        'subtitle': '桌面战士',
      },
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75, // Adjust based on item height/width
        crossAxisSpacing: 16,
        mainAxisSpacing: 24,
      ),
      itemCount: medals.length,
      itemBuilder: (context, index) {
        final data = medals[index];
        return MedalHexagon(
          state: data['state'] as MedalState,
          title: data['title'] as String,
          subtitle: data['subtitle'] as String,
          imageUrl: data['image'] as String?,
          onTap: () {
            // Check details
          },
        );
      },
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF080808),
        border: Border(top: BorderSide(color: Color(0xFF333333))),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.lifeSignal,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: AppColors.lifeSignal, blurRadius: 8),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              '[SYS] UPLINK_STABLE // DATA_PACKET_RECEIVED // KEEP_MOVING',
              style: TextStyle(
                fontFamily: 'ZpixFont',
                fontSize: 10,
                color: Color(0xFF888888),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..strokeWidth = 1;

    // Draw vertical lines
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
