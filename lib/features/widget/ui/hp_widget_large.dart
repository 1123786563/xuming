import 'package:flutter/material.dart';
import 'package:xuming/core/theme/app_colors.dart';
import 'package:xuming/shared/widgets/cyber_button.dart';
import 'package:xuming/shared/widgets/scanline_overlay.dart';

class HpWidgetLarge extends StatelessWidget {
  const HpWidgetLarge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 340,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF121212), // surface
        borderRadius: BorderRadius.circular(16), // rounded-xl
        border: Border.all(
          color: AppColors.lifeSignal.withOpacity(0.3),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: ScanlineOverlay()),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MONITORING_UNIT_01',
                          style: TextStyle(
                            color: AppColors.lifeSignal,
                            fontSize: 10,
                            fontFamily: 'monospace',
                          ),
                        ),
                        Text(
                          'CORE VITALITY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            height: 1.0,
                            shadows: [
                              BoxShadow(
                                color: AppColors.lifeSignal.withOpacity(0.5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.lifeSignal,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Text(
                        'ACTIVE',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Graph
                Container(
                  height: 96,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    border: Border.all(color: AppColors.lifeSignal.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Stack(
                    children: [
                      // Pixel Grid
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.1,
                          child: CustomPaint(painter: _PixelGridPainter()),
                        ),
                      ),
                      // Graph
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _HpGraphPainter(),
                        ),
                      ),
                      // Labels
                      Positioned(
                        top: 4,
                        left: 4,
                        child: Text(
                          'HP_TREND_24H',
                          style: TextStyle(
                            color: AppColors.lifeSignal.withOpacity(0.5),
                            fontSize: 8,
                            fontFamily: 'monospace',
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Text(
                          'AVG: 62%',
                          style: TextStyle(
                            color: AppColors.lifeSignal,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Metrics Grid
                Row(
                  children: [
                    Expanded(
                      child: _MetricCard(
                        title: 'SITTING TIME',
                        value: '9.5',
                        unit: 'HRS',
                        progress: 0.85,
                        progressColor: AppColors.nuclearWarning,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _MetricCard(
                        title: 'RECOVERY RATE',
                        value: '0.4',
                        unit: 'x/MIN',
                        progress: 0.25,
                        progressColor: AppColors.lifeSignal,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Quote
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Space Grotesk',
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        height: 1.0,
                        letterSpacing: -0.5,
                      ),
                      children: [
                        const TextSpan(text: 'YOUR CHAIR IS '),
                        TextSpan(
                          text: 'WINNING.\n',
                          style: TextStyle(color: AppColors.nuclearWarning),
                        ),
                        const TextSpan(text: 'YOUR SPINE IS '),
                        TextSpan(
                          text: 'LOSING.',
                          style: TextStyle(color: AppColors.nuclearWarning),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                // Action Button
                CyberButton(
                  text: 'Initialize Recover',
                  onPressed: () {},
                  icon: Icons.bolt,
                  height: 48,
                  width: double.infinity,
                ),
              ],
            ),
          ),
          // HUD Details
          Positioned(
            bottom: 2,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _HudLine(),
                const SizedBox(width: 16),
                _HudLine(),
                const SizedBox(width: 16),
                _HudLine(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final double progress;
  final Color progressColor;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.progress,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        border: Border.all(color: AppColors.lifeSignal.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.lifeSignal.withOpacity(0.6),
              fontSize: 9,
              fontFamily: 'monospace',
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            height: 4,
            width: double.infinity,
            color: progressColor.withOpacity(0.2),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(color: progressColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _HudLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 4,
      color: AppColors.lifeSignal.withOpacity(0.1),
    );
  }
}

class _PixelGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.lifeSignal
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 10) {
      for (double y = 0; y < size.height; y += 10) {
        canvas.drawCircle(Offset(x, y), 0.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HpGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    // Simplified path based on SVG d="M0,35 L10,30 L20,38 L30,25 L40,28 L50,15 L60,18 L70,35 L80,32 L90,38 L100,40"
    // Scale points to size
    final points = [
      const Offset(0, 0.875),
      const Offset(0.1, 0.75),
      const Offset(0.2, 0.95),
      const Offset(0.3, 0.625),
      const Offset(0.4, 0.7),
      const Offset(0.5, 0.375),
      const Offset(0.6, 0.45),
      const Offset(0.7, 0.875),
      const Offset(0.8, 0.8),
      const Offset(0.9, 0.95),
      const Offset(1.0, 1.0),
    ];

    if (points.isEmpty) return;

    path.moveTo(points[0].dx * size.width, points[0].dy * size.height);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx * size.width, points[i].dy * size.height);
    }

    // Stroke
    final paintStroke = Paint()
      ..color = AppColors.lifeSignal.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, paintStroke);

    // Fill
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final paintFill = Paint()
      ..color = AppColors.lifeSignal.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
