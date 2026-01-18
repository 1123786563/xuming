import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// 续命 App 字体规范
/// 
/// 基于视觉还原手册定义的排版系统
class AppTypography {
  AppTypography._();

  // ============================================
  // 像素字体 (Pixel Font) - 用于标题和数据
  // ============================================
  
  /// 大标题 - 32pt Bold
  static TextStyle get pixelHeadline => const TextStyle(
    fontFamily: 'ZpixFont',
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    color: AppColors.textPrimary,
  );
  
  /// 数据动态 - 24pt Monospace
  /// 确保数字跳动时不发生位移
  static TextStyle get pixelData => const TextStyle(
    fontFamily: 'ZpixFont',
    fontSize: 24,
    fontWeight: FontWeight.normal,
    color: AppColors.lifeSignal,
  );
  
  /// HP 数值 - 40pt Bold
  static TextStyle get pixelHP => const TextStyle(
    fontFamily: 'ZpixFont',
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.lifeSignal,
  );

  // ============================================
  // 等宽字体 (Monospace) - 用于正文和毒舌文案
  // ============================================
  
  /// 正文 - 14pt Medium, 行高 1.5
  static TextStyle get monoBody => GoogleFonts.jetBrainsMono(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.textPrimary,
  );
  
  /// 毒舌文案 - 16pt Medium
  static TextStyle get monoToxic => GoogleFonts.jetBrainsMono(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.nuclearWarning,
  );
  
  /// 装饰文字 - 10pt, 用于角落的 SYS_LOG 等
  static TextStyle get monoDecorative => GoogleFonts.jetBrainsMono(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: AppColors.textDecorative,
  );
  
  /// 按钮文字 - 14pt Bold
  static TextStyle get monoButton => GoogleFonts.jetBrainsMono(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
    color: AppColors.textPrimary,
  );
  
  /// 标签文字 - 12pt
  static TextStyle get monoLabel => GoogleFonts.jetBrainsMono(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
}
