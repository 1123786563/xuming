import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// 续命 App 主题配置
/// 
/// 整合色彩与字体的 Material 主题
class AppTheme {
  AppTheme._();

  /// 暗黑主题 (唯一主题)
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    
    // 色彩方案
    colorScheme: const ColorScheme.dark(
      primary: AppColors.lifeSignal,
      secondary: AppColors.bioUpgrade,
      error: AppColors.nuclearWarning,
      surface: AppColors.void_,
      onPrimary: AppColors.void_,
      onSecondary: AppColors.textPrimary,
      onError: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
    ),
    
    // 脚手架背景
    scaffoldBackgroundColor: AppColors.void_,
    
    // App Bar 样式
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.void_,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTypography.pixelHeadline.copyWith(fontSize: 20),
      iconTheme: const IconThemeData(color: AppColors.lifeSignal),
    ),
    
    // 卡片样式
    cardTheme: CardThemeData(
      color: AppColors.cardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.lifeSignal, width: 1),
      ),
    ),
    
    // 按钮样式
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lifeSignal,
        foregroundColor: AppColors.void_,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: AppTypography.monoButton,
      ),
    ),
    
    // 输入框样式
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.lifeSignal),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.textDecorative),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.lifeSignal, width: 2),
      ),
      labelStyle: AppTypography.monoLabel,
      hintStyle: AppTypography.monoLabel,
    ),
    
    // 分割线
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
    ),
    
    // 进度条
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.lifeSignal,
      linearTrackColor: AppColors.cardBackground,
    ),
    
    // 文字主题
    textTheme: TextTheme(
      displayLarge: AppTypography.pixelHeadline,
      displayMedium: AppTypography.pixelData,
      bodyLarge: AppTypography.monoBody,
      bodyMedium: AppTypography.monoBody,
      labelLarge: AppTypography.monoButton,
      labelMedium: AppTypography.monoLabel,
    ),
  );
}
