import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// 设置项类型
enum ProfileMenuItemType {
  navigate,  // 导航到下一页
  toggle,    // 开关控制
  custom,    // 自定义右侧组件
}

/// 个人设置菜单项组件
/// 
/// 通用设置项，支持多种右侧控件类型
class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.description,
    this.statusTag,
    this.statusTagColor,
    this.iconColor,
    this.type = ProfileMenuItemType.navigate,
    this.trailing,
    this.onTap,
    this.isEnabled = true,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? description;
  final String? statusTag;
  final Color? statusTagColor;
  final Color? iconColor;
  final ProfileMenuItemType type;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? AppColors.lifeSignal;
    final opacity = isEnabled ? 1.0 : 0.5;
    
    return Opacity(
      opacity: opacity,
      child: GestureDetector(
        onTap: isEnabled ? onTap : null,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            border: Border.all(
              color: AppColors.textDecorative.withOpacity(0.3),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // 右下角切角装饰
              Positioned(
                right: 0,
                bottom: 0,
                child: CustomPaint(
                  size: const Size(10, 10),
                  painter: _CornerCutPainter(),
                ),
              ),
              
              // 主内容
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // 左侧图标
                    _buildIcon(effectiveIconColor),
                    
                    const SizedBox(width: 16),
                    
                    // 中间内容
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 标题行
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      title,
                                      style: const TextStyle(
                                        fontFamily: 'ZpixFont',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    if (subtitle != null) ...[
                                      const SizedBox(width: 6),
                                      Text(
                                        '// $subtitle',
                                        style: TextStyle(
                                          fontFamily: 'ZpixFont',
                                          fontSize: 11,
                                          color: AppColors.textSecondary.withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              if (statusTag != null)
                                _buildStatusTag(),
                            ],
                          ),
                          
                          // 描述行
                          if (description != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              description!,
                              style: TextStyle(
                                fontFamily: 'ZpixFont',
                                fontSize: 11,
                                color: AppColors.textSecondary.withOpacity(0.7),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    
                    const SizedBox(width: 12),
                    
                    // 右侧组件
                    _buildTrailing(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(Color color) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Icon(
        icon,
        color: color,
        size: 24,
      ),
    );
  }

  Widget _buildStatusTag() {
    final tagColor = statusTagColor ?? AppColors.lifeSignal.withOpacity(0.6);
    
    return Text(
      '[$statusTag]',
      style: TextStyle(
        fontFamily: 'ZpixFont',
        fontSize: 10,
        color: tagColor,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildTrailing() {
    if (trailing != null) {
      return trailing!;
    }
    
    switch (type) {
      case ProfileMenuItemType.navigate:
        return Icon(
          Icons.chevron_right,
          color: AppColors.textSecondary.withOpacity(0.5),
          size: 24,
        );
      case ProfileMenuItemType.toggle:
      case ProfileMenuItemType.custom:
        return const SizedBox.shrink();
    }
  }
}

/// 右下角切角画笔
class _CornerCutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.void_
      ..style = PaintingStyle.fill;
    
    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
