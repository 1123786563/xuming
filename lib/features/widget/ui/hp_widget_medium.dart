import 'package:flutter/material.dart';
import 'package:xuming/core/theme/app_colors.dart';
import 'package:xuming/shared/widgets/energy_bar.dart';
import 'package:xuming/shared/widgets/scanline_overlay.dart';

class HpWidgetMedium extends StatelessWidget {
  const HpWidgetMedium({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 160,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF121212), // surface
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.lifeSignal.withOpacity(0.3),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: ScanlineOverlay()),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SEGMENTED_CORE_HP',
                          style: TextStyle(
                            color: AppColors.lifeSignal.withOpacity(0.6),
                            fontSize: 10,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 4),
                        EnergyBar(
                          value: 30, // 3/8 filled approx
                          maxValue: 80,
                          segments: 8,
                          width: 120, // Adjust as needed
                          height: 16,
                          showLabel: false,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'VITALITY_LVL',
                          style: TextStyle(
                            color: AppColors.lifeSignal,
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const Text(
                          'MK.III',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Body Quote
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Space Grotesk', // or default
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                      color: Colors.white,
                    ),
                    children: [
                      const TextSpan(text: '"Don\'t just sit there like a '),
                      TextSpan(
                        text: 'digital fossil.',
                        style: TextStyle(
                          color: AppColors.lifeSignal,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const TextSpan(text: '"'),
                    ],
                  ),
                ),
                // Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: Row(
                        children: [
                          const Text(
                            'SYS_SYNC: OK',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: AppColors.lifeSignal,
                              shape: BoxShape.circle,
                            ),
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
    );
  }
}
