import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// 毒舌强度滑块组件
/// 
/// 显示 4 级滑块控制，每一级用不同颜色表示
class ToxicLevelSlider extends StatefulWidget {
  const ToxicLevelSlider({
    super.key,
    required this.level,
    required this.onChanged,
    this.maxLevel = 4,
  });

  final int level;
  final ValueChanged<int> onChanged;
  final int maxLevel;

  @override
  State<ToxicLevelSlider> createState() => _ToxicLevelSliderState();
}

class _ToxicLevelSliderState extends State<ToxicLevelSlider> {
  Color _getColorForLevel(int index, int currentLevel) {
    if (index >= currentLevel) {
      return AppColors.textDecorative.withOpacity(0.3);
    }
    
    // 前两级绿色，第三级黄色，第四级（保留）红色
    if (index < 2) {
      return AppColors.lifeSignal;
    } else if (index == 2) {
      return AppColors.cautionYellow;
    } else {
      return AppColors.nuclearWarning;
    }
  }

  BoxShadow? _getShadowForLevel(int index, int currentLevel) {
    if (index >= currentLevel) return null;
    
    final color = _getColorForLevel(index, currentLevel);
    return BoxShadow(
      color: color.withOpacity(0.5),
      blurRadius: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 滑块段
        ...List.generate(widget.maxLevel, (index) {
          return GestureDetector(
            onTap: () => widget.onChanged(index + 1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 32,
              height: 6,
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: _getColorForLevel(index, widget.level),
                borderRadius: BorderRadius.circular(2),
                boxShadow: _getShadowForLevel(index, widget.level) != null
                    ? [_getShadowForLevel(index, widget.level)!]
                    : null,
              ),
            ),
          );
        }),
        
        // 等级标签
        const SizedBox(width: 8),
        Text(
          'LVL_${widget.level}',
          style: TextStyle(
            fontFamily: 'ZpixFont',
            fontSize: 10,
            color: _getColorForLevel(widget.level - 1, widget.level),
          ),
        ),
      ],
    );
  }
}
