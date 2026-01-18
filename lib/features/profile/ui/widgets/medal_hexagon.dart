
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

enum MedalState {
  locked,
  unlocked,
  hidden, // For potential future use
}

class MedalHexagon extends StatelessWidget {
  final MedalState state;
  final String title;
  final String subtitle;
  final String? imageUrl;
  final String? iconName; // For locked state icon
  final double size;
  final VoidCallback? onTap;

  const MedalHexagon({
    super.key,
    required this.state,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.iconName,
    this.size = 120,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: state == MedalState.locked ? null : onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHexagonGraphic(context),
          const SizedBox(height: 12),
          _buildTextContent(),
        ],
      ),
    );
  }

  Widget _buildHexagonGraphic(BuildContext context) {
    final isLocked = state == MedalState.locked;
    
    return MouseRegion(
      cursor: isLocked ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      child: Container(
        width: size,
        height: size * 1.15, // Hexagon aspect ratio adjustment
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Border Gradient
            ClipPath(
              clipper: HexagonClipper(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isLocked
                        ? [const Color(0xFF333333), const Color(0xFF222222)]
                        : [
                            AppColors.nuclearWarning, // Secondary/Gold color approximation
                            const Color(0xFF5E4B14),
                          ],
                  ),
                ),
                padding: const EdgeInsets.all(2), // Border width
                child: ClipPath(
                  clipper: HexagonClipper(),
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            
            // Inner Content
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipPath(
                  clipper: HexagonClipper(),
                  child: Container(
                    color: const Color(0xFF1A1A1A),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (isLocked) _buildLockedContent() else _buildUnlockedContent(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // Locked Overlay Text (LOCKED Tag)
            if (isLocked)
              Positioned(
                child: Transform.rotate(
                  angle: -15 * math.pi / 180,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      border: Border.all(color: const Color(0xFF333333)),
                    ),
                    child: const Text(
                      'LOCKED',
                      style: TextStyle(
                        fontFamily: 'ZpixFont', // Assuming ZpixFont as per other files
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Color(0xFF555555),
                      ),
                    ),
                  ),
                ),
              ),
              
            // Unlocked Level Badge (Example fixed level)
            if (!isLocked)
              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.nuclearWarning,
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  transform: Matrix4.skewX(-0.2),
                  child: const Text(
                    'LV.5',
                    style: TextStyle(
                      fontFamily: 'ZpixFont',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLockedContent() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Icon
        const Icon(
          Icons.lock,
          size: 40,
          color: Color(0xFF333333),
        ),
        // Overlay Pattern (Simulated)
        Container(
          color: Colors.black.withOpacity(0.1),
        ),
      ],
    );
  }

  Widget _buildUnlockedContent() {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (imageUrl != null)
          Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[900],
              child: const Icon(Icons.broken_image, color: Colors.white24),
            ),
          )
        else
          Container(
            color: Colors.grey[850],
            child: const Icon(Icons.star, color: AppColors.nuclearWarning, size: 40),
          ),
          
        // Gradient Overlay
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromRGBO(184, 134, 11, 0.4), // Gold tint
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextContent() {
    final isLocked = state == MedalState.locked;
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'ZpixFont', // Space Grotesk in HTML, probably Zpix in app based on profile_page.dart
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isLocked ? const Color(0xFF666666) : AppColors.nuclearWarning,
            shadows: isLocked ? null : [
              const Shadow(
                blurRadius: 5,
                color: Color.fromRGBO(184, 134, 11, 0.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'ZpixFont',
            fontSize: 10,
            color: isLocked ? const Color(0xFF444444) : Colors.white.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isLocked ? 'REQ: ???' : '[ UNLOCKED ]',
          style: TextStyle(
            fontFamily: 'ZpixFont',
            fontSize: 8,
            letterSpacing: 1.2,
            color: isLocked ? const Color(0xFF444444) : AppColors.lifeSignal,
          ),
        ),
      ],
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width, size.height * 0.25);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(0, size.height * 0.75);
    path.lineTo(0, size.height * 0.25);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
