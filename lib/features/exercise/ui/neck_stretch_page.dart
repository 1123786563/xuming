import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/cyber_decorations.dart';
import 'base_exercise_page.dart';

/// 侧向颈部拉伸页面 - 使用基类重构
class NeckStretchPage extends StatelessWidget {
  const NeckStretchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseExercisePage(
      title: "侧向颈部拉伸",
      taskName: "CERVICAL_REPAIR_V2",
      procedureId: "PROJECT: ACTIVE_RECOVERY",
      themeColor: AppColors.primary,
      quote: "Stop pretending to work; your neck is screaming louder than your boss.",
      visualFeedback: _StretchVisuals(),
    );
  }
}

class _StretchVisuals extends StatelessWidget {
  const _StretchVisuals();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 背景图片
        Positioned.fill(
          child: Opacity(
            opacity: 0.6,
            child: Image.network(
              "https://lh3.googleusercontent.com/aida-public/AB6AXuArroUHE3eR7BYbzSXK7GeuOzVuc59ajrYN9FAeUlTWgEUFPVQzinn8Xau4HGIfYJy-GU69vQZUeXGz-ab7kJ1btpVV5q2aV_DMMzQp32tklUNHHBz346aBQybhJgss8yCoN6WRUNLwbWWNH9bT69UnrteuAW5ub-hmZEsU0yMF9DzUkxaDANlKbOyUGAPjROrO9RTx-DnVmYzfOAzJcugrzBxStk_WAY1nOLxPXIsTdJm72sTEMV-_bPNp0LkCjRQgG_BOZ1txbnk",
              fit: BoxFit.cover,
            ),
          ),
        ),

        // 覆盖指引 HUD
        SizedBox(
          width: 200,
          height: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: AppColors.primary.withOpacity(0.2)),
                    right: BorderSide(color: AppColors.primary.withOpacity(0.2)),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                child: Container(
                  width: 100,
                  height: 2,
                  color: AppColors.nuclearWarning.withOpacity(0.8),
                ),
              ),
              const Positioned(
                right: 40,
                top: 40,
                child: Icon(Icons.keyboard_double_arrow_right, color: AppColors.nuclearWarning, size: 40),
              ),
              Positioned(
                top: 70,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary.withOpacity(0.4), width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),

        // 装饰角落
        const Positioned(top: 0, left: 0, child: CyberCorner(isTop: true, isLeft: true, size: 64)),
        const Positioned(bottom: 0, right: 0, child: CyberCorner(isTop: false, isLeft: false, size: 64)),

        // HUD 标签
        const Positioned(
          top: 20,
          left: 16,
          child: CyberHudLabel(label: "SYS_CALIBRATING", value: "LATENCY: 12ms"),
        ),
        const Positioned(
          top: 20,
          right: 16,
          child: CyberHudLabel(label: "STRETCH_ANGLE", value: "45°"),
        ),
      ],
    );
  }
}
