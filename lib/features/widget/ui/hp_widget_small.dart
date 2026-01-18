import 'package:flutter/material.dart';
import 'package:yundong/core/theme/app_colors.dart';
import 'package:yundong/shared/widgets/scanline_overlay.dart';

class HpWidgetSmall extends StatelessWidget {
  const HpWidgetSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF121212), // surface
        borderRadius: BorderRadius.circular(12), // rounded-lg approx
        border: Border.all(
          color: AppColors.lifeSignal.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          const Positioned.fill(child: ScanlineOverlay()),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Vertical Energy Bar
                Container(
                  width: 48, // w-1/3 approx 160/3 = 53
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: AppColors.lifeSignal.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Pixel Grid BG
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.1,
                          child: CustomPaint(
                            painter: _PixelGridPainter(),
                          ),
                        ),
                      ),
                      // Fill
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            width: double.infinity,
                            height: constraints.maxHeight * 0.45, // 45%
                            decoration: BoxDecoration(
                              color: AppColors.lifeSignal,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.lifeSignal.withOpacity(0.5),
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // Vertical Text
                      const Positioned(
                        top: 24,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Text(
                            'EXTRACTING_LIFE',
                            style: TextStyle(
                              color: AppColors.lifeSignal,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Stats
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'STATUS:CRIT',
                            style: TextStyle(
                              color: AppColors.lifeSignal.withOpacity(0.6),
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '45%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              height: 1.0,
                              shadows: [
                                BoxShadow(
                                  color: AppColors.lifeSignal.withOpacity(0.5),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'HP_VALUE',
                            style: TextStyle(
                              color: AppColors.lifeSignal,
                              fontSize: 10,
                              fontFamily: 'monospace',
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                      // Warning
                      Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: AppColors.nuclearWarning,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'LOW\nVITAL',
                            style: TextStyle(
                              color: AppColors.nuclearWarning,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              height: 1.0,
                              shadows: [
                                BoxShadow(
                                  color: AppColors.nuclearWarning.withOpacity(0.6),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
}

class _PixelGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.lifeSignal
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 4) {
      for (double y = 0; y < size.height; y += 4) {
        canvas.drawCircle(Offset(x, y), 0.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
