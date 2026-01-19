import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class DashboardBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const DashboardBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return  ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9),
            border: const Border(
              top: BorderSide(color: Color(0xFF1C3617)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildNavItem(0, Icons.monitor_heart, 'Monitor', isActive: currentIndex == 0),
              _buildNavItem(1, Icons.library_books, 'Library', isActive: currentIndex == 1),
              _buildNavItem(2, Icons.bar_chart, 'Stats', isActive: currentIndex == 2),
              _buildNavItem(3, Icons.person_outline, 'Profile', isActive: currentIndex == 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, {required bool isActive}) {
    final color = isActive ? AppColors.primary : Colors.white.withOpacity(0.4);
    
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Icon with Glow for active
          Stack(
            alignment: Alignment.center,
            children: [
              if (isActive)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withOpacity(0.2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ]
                    ),
                  ),
                ),
              Icon(
                icon,
                color: color,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label.toUpperCase(),
            style: AppTypography.monoDecorative.copyWith(
              color: color,
              fontSize: 10,
              letterSpacing: 1.5,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          // Active Indicator Dot
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : Colors.transparent,
              shape: BoxShape.circle,
              boxShadow: isActive ? [
                const BoxShadow(
                  color: AppColors.primary,
                  blurRadius: 4,
                  spreadRadius: 1,
                )
              ] : null,
            ),
          ),
        ],
      ),
    );
  }
}
