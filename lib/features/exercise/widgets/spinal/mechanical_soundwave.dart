import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'dart:math' as math;

class MechanicalSoundwave extends StatelessWidget {
  final Animation<double> animation;

  const MechanicalSoundwave({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Container(height: 1, color: const Color(0xFF26333b))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "MECHANICAL SOUNDWAVE STATUS",
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.industrialYellow,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            Expanded(child: Container(height: 1, color: const Color(0xFF26333b))),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 48,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(20, (index) {
                   final randomHeight = math.Random(index).nextDouble();
                   final animatedHeight = (randomHeight + animation.value) % 1.0;
                   return Container(
                     width: 3,
                     height: 48 * (0.3 + 0.7 * animatedHeight),
                     margin: const EdgeInsets.symmetric(horizontal: 1),
                     color: AppColors.industrialYellow,
                   );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
