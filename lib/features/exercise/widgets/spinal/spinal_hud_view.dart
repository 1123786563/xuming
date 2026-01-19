import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/constants/app_strings.dart';

class SpinalHudView extends StatelessWidget {
  final Animation<double> pulseAnimation;

  const SpinalHudView({super.key, required this.pulseAnimation});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        border: Border.all(color: AppColors.industrialYellow, width: 2),
      ),
      child: Stack(
        children: [
          // 3D 角色图片
          Positioned.fill(
            child: Image.network(
              "https://lh3.googleusercontent.com/aida-public/AB6AXuByxAGLm9N4wQ2IJ5fg91hJchi-5bipwPHinFkIhF1MYgJfNhhCCHLtX0fMq1bH5w-CnAp7mlbA0OXj5iJt5E6erH4RxozHInvQbzy4FAqvm1_nWOSruarVhkxRHYZs8oZJI_I-hmkBmb0y8coCMXCTQQwaRxp_oLFxmOldNfdPmJC75pqNe5JrZAVNxn7yW2f42QtwJ4ilzShTjB9ZUvbg9yxJoRf9PG_1pJOEVVdJCKXXI93gvDERGDy6FZhzqxUIu4_HVj4bOGs",
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
              errorBuilder: (context, error, stackTrace) => Center(
                child: Icon(Icons.accessibility_new, size: 100, color: AppColors.industrialYellow.withOpacity(0.2)),
              ),
            ),
          ),
          
          // HUD 左上角信息
          Positioned(
            top: 8,
            left: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 8, height: 8, color: AppColors.industrialYellow),
                    const SizedBox(width: 4),
                    Text(
                      "REC_MODE: DIAGNOSTIC",
                      style: AppTypography.monoDecorative.copyWith(
                        color: AppColors.industrialYellow,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Text(
                  "X: 124.52 Y: 88.01 Z: -4.10",
                  style: AppTypography.monoDecorative.copyWith(
                    color: AppColors.industrialYellow.withOpacity(0.6),
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          
          // HUD 右上角警告
          Positioned(
            top: 8,
            right: 8,
            child: AnimatedBuilder(
              animation: pulseAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: pulseAnimation.value,
                  child: Text(
                    AppStrings.sysCalibrating, // Check if this fits "CALIBRATING SPINE..." logic, or use hardcoded string if specific
                    style: AppTypography.monoDecorative.copyWith(
                      color: AppColors.nuclearWarning,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          
          // 旋转图标叠加
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.industrialYellow.withOpacity(0.2), width: 4),
              ),
              child: const Icon(
                Icons.sync,
                color: AppColors.industrialYellow,
                size: 80,
              ),
            ),
          ),
          
          // 角落装饰
          Positioned(bottom: 8, right: 8, child: _buildCornerBracket(false)),
          Positioned(bottom: 8, left: 8, child: _buildCornerBracket(true)),
        ],
      ),
    );
  }

  Widget _buildCornerBracket(bool isLeft) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border(
           bottom: const BorderSide(color: AppColors.industrialYellow, width: 2),
           left: isLeft ? const BorderSide(color: AppColors.industrialYellow, width: 2) : BorderSide.none,
           right: isLeft ? BorderSide.none : const BorderSide(color: AppColors.industrialYellow, width: 2),
        ),
      ),
    );
  }
}
