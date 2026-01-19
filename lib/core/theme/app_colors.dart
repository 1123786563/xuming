import 'package:flutter/material.dart';

/// 续命 App 赛博色彩系统
/// 
/// 基于视觉还原手册定义的原子色彩体系
class AppColors {
  AppColors._();

  // ============================================
  // 基础色彩 (Atomic Colors)
  // ============================================
  
  /// The Void - 极致黑/OLED Black
  /// 用于：背景色
  /// 注意：禁止使用灰色渐变，保持纯黑以突出荧光效果
  static const Color void_ = Color(0xFF000000);
  
  /// Life Signal - Matrix Green / 核心绿
  /// 用于：HP血条、成功反馈、主要按钮
  static const Color lifeSignal = Color(0xFF00FF41);
  
  /// Nuclear Warning - Glitch Red / 危机红
  /// 用于：低血量警报、核打击提醒、紧急抢修按钮
  static const Color nuclearWarning = Color(0xFFFF003C);
  
  /// Bio-Upgrade - Cyber Purple / 赛博紫
  /// 用于：商店解锁、高级插件、成就勋章
  static const Color bioUpgrade = Color(0xFFBC13FE);
  
  /// Caution Yellow - Warning Yellow / 工业黄
  /// 用于：生存评估弹窗、中度压力提醒
  static const Color cautionYellow = Color(0xFFF2FF00);
  
  /// Warning Orange - Amber / 警告橙
  /// 用于：索赔失败页面的警告图标、统计卡片
  static const Color warningOrange = Color(0xFFFF8C00);

  /// Industrial Yellow - 工业黄
  /// 用于：脊柱螺旋对齐指引页面 (variant_3)
  static const Color industrialYellow = Color(0xFFFFBF00);

  /// Visual Reset Green - 视觉神经重置绿
  /// 用于：视觉神经重置指引页面 (variant_1)
  static const Color visualResetGreen = Color(0xFF38FF14);

  /// Glute Orange - 臀部机能唤醒橙
  /// 用于：臀部机能唤醒页面 (variant_3)
  static const Color gluteOrange = Color(0xFFFF4400);

  /// Primary - Neon Green / 主色
  /// Matches design 'primary': #38ff14
  static const Color primary = visualResetGreen;
  
  /// Alert - Cyberpunk Red / 警报红
  /// Matches design 'alert': #FF004E
  static const Color alert = Color(0xFFFF004E);

  /// Secondary - Cyber Blue / 辅助色
  /// Matches design 'secondary': #00E5FF
  static const Color secondary = Color(0xFF00E5FF);

  /// Surface Dark - 深色表面
  static const Color surface_dark = Color(0xFF121212);
  
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF000000);

  // ============================================
  // 辅助色彩
  // ============================================
  
  /// 文字主色 - 亮白
  static const Color textPrimary = Color(0xFFFFFFFF);
  
  /// 文字次色 - 灰白
  static const Color textSecondary = Color(0xFFAAAAAA);
  
  /// 装饰文字 - 深灰
  static const Color textDecorative = Color(0xFF444444);
  
  /// 卡片背景 - 深灰透明
  static const Color cardBackground = Color(0xFF1C1C1E);
  
  /// 分割线 - 暗灰
  static const Color divider = Color(0xFF2A2A2A);

  // ============================================
  // 透明度变体
  // ============================================
  
  /// 发光效果用的半透明绿
  static const Color lifeSignalGlow = Color(0x6600FF41);
  
  /// 玻璃态背景 (70% 透明度)
  static const Color glassBackground = Color(0xB31C1C1E);

  // ============================================
  // 语义化颜色别名 (用于主题切换)
  // ============================================
  
  /// 主发光效果 - 成功/生命信号
  static const Color primaryGlow = lifeSignal;
  
  /// 危险脉冲 - 紧急警报/低血量
  static const Color dangerPulse = nuclearWarning;
  
  /// 成功反馈 - 完成动作/奖励
  static const Color successFeedback = lifeSignal;
  
  /// 警告反馈 - 中度提示
  static const Color warningFeedback = cautionYellow;
  
  /// 升级/解锁 - 高级功能
  static const Color upgradeGlow = bioUpgrade;
  
  /// 信息提示 - 辅助信息
  static const Color infoGlow = secondary;
}
