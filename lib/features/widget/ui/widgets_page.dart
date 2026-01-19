import 'package:flutter/material.dart';
import 'package:xuming/core/theme/app_colors.dart';
import 'package:xuming/features/widget/ui/hp_widget_large.dart';
import 'package:xuming/features/widget/ui/hp_widget_medium.dart';
import 'package:xuming/features/widget/ui/hp_widget_small.dart';
import 'package:xuming/shared/widgets/grid_background.dart';

class WidgetsPage extends StatelessWidget {
  const WidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(child: GridBackground()),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  
                  _buildSectionTitle('WIDGET_SMALL (2x2)'),
                  const SizedBox(height: 16),
                  const Center(child: HpWidgetSmall()),
                  
                  const SizedBox(height: 32),
                  _buildSectionTitle('WIDGET_MEDIUM (4x2)'),
                  const SizedBox(height: 16),
                  const Center(child: HpWidgetMedium()),
                  
                  const SizedBox(height: 32),
                  _buildSectionTitle('WIDGET_LARGE (4x4)'),
                  const SizedBox(height: 16),
                  const Center(child: HpWidgetLarge()),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              color: AppColors.lifeSignal,
            ),
            const SizedBox(width: 12),
            const Text(
              'DESKTOP WIDGETS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Space Grotesk',
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'PREVIEW ONLY - SYSTEM EXTENSIONS REQUIRED FOR INSTALLATION',
          style: TextStyle(
            color: AppColors.lifeSignal.withOpacity(0.7),
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: AppColors.lifeSignal.withOpacity(0.5), width: 2),
          bottom: BorderSide(color: AppColors.lifeSignal.withOpacity(0.1)),
        ),
        color: AppColors.lifeSignal.withOpacity(0.05),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.lifeSignal.withOpacity(0.8),
          fontSize: 12,
          fontFamily: 'monospace',
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
