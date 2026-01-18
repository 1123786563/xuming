import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/glitch_text.dart';
import '../../../shared/widgets/grid_background.dart';
import '../../../shared/widgets/block_progress_bar.dart';
import '../../../shared/widgets/scanline_overlay.dart';

/// 系统启动页
/// 
/// BIOS 风格的开屏动画，模拟系统启动
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  final List<_BootLogItem> _bootLogs = [];
  int _currentLogIndex = 0;
  bool _showLogo = false;
  bool _isComplete = false;
  double _progress = 0;

  // 启动日志序列
  static const List<_BootLogItem> _bootSequence = [
    _BootLogItem(text: 'KERNEL_INITIALIZING...', opacity: 0.6),
    _BootLogItem(text: 'BIO_SCANNER_ONLINE [OK]', opacity: 0.8),
    _BootLogItem(text: 'SPINE_INTEGRITY_CHECK...', opacity: 0.9),
    _BootLogItem(text: 'POSTURE_MONITOR_CONNECTED', opacity: 1.0, showNeon: true),
    _BootLogItem(text: 'SEDENTARY_OFFSET_PROTOCOL_LOADED_', opacity: 1.0, isHighlight: true),
  ];

  @override
  void initState() {
    super.initState();
    _startBootSequence();
  }

  void _startBootSequence() async {
    // 逐行显示启动日志
    for (var i = 0; i < _bootSequence.length; i++) {
      await Future.delayed(Duration(milliseconds: 200 + Random().nextInt(300)));
      if (mounted) {
        setState(() {
          _bootLogs.add(_bootSequence[i]);
          _currentLogIndex = i;
          _progress = (i + 1) / _bootSequence.length * 0.8;
        });
      }
    }

    // 显示 Logo
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() => _showLogo = true);
    }

    // 完成进度
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() => _progress = 0.98);
    }

    // 标记完成并跳转
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isComplete = true);
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // 背景网格
          const GridBackground(
            gridSize: 32,
            lineOpacity: 0.07,
            showVignette: true,
          ),
          
          // 扫描线效果
          const ScanlineOverlay(),
          
          // 扫描光条
          if (_showLogo) const ScanBeam(position: 0.35),
          
          // 主内容
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // 顶部状态栏
                  _buildStatusBar(),
                  
                  const Spacer(),
                  
                  // 中央 Logo 区域
                  if (_showLogo) _buildLogoSection(),
                  
                  const SizedBox(height: 48),
                  
                  // 终端日志区域
                  _buildTerminalLogs(),
                  
                  const Spacer(),
                  
                  // 底部进度和元数据
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建顶部状态栏
  Widget _buildStatusBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.lifeSignal.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 左侧网络状态
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.wifi_tethering,
                    size: 16,
                    color: AppColors.lifeSignal,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'NET_SECURE',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: AppColors.lifeSignal.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'IP: 192.168.X.X',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: AppColors.lifeSignal.withOpacity(0.5),
                ),
              ),
            ],
          ),
          
          // 右侧电池状态
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    'BATTERY_OPT',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: AppColors.lifeSignal.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.bolt,
                    size: 16,
                    color: AppColors.lifeSignal,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'VOL: 14.4kV',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: AppColors.lifeSignal.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建中央 Logo 区域
  Widget _buildLogoSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 故障效果层 - 品红色切片
        Positioned(
          left: -3,
          child: Text(
            '续命',
            style: AppTypography.pixelHeadline.copyWith(
              fontSize: 72,
              color: const Color(0xFFFF00FF).withOpacity(0.8),
            ),
          ),
        ),
        
        // 故障效果层 - 青色切片
        Positioned(
          left: 3,
          child: Text(
            '续命',
            style: AppTypography.pixelHeadline.copyWith(
              fontSize: 72,
              color: const Color(0xFF00BFFF).withOpacity(0.8),
            ),
          ),
        ),
        
        // 主文字
        Text(
          '续命',
          style: AppTypography.pixelHeadline.copyWith(
            fontSize: 72,
            color: AppColors.lifeSignal,
            shadows: [
              Shadow(
                color: AppColors.lifeSignal.withOpacity(0.8),
                blurRadius: 5,
              ),
            ],
          ),
        ),
        
        // 版本标签
        Positioned(
          right: -16,
          bottom: -8,
          child: Transform.rotate(
            angle: -0.035, // -2 度
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              color: AppColors.lifeSignal,
              child: Text(
                'v.1.0.4_RC',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.void_,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 构建终端日志区域
  Widget _buildTerminalLogs() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.void_.withOpacity(0.4),
        border: Border(
          left: BorderSide(
            color: AppColors.lifeSignal.withOpacity(0.4),
            width: 2,
          ),
        ),
      ),
      child: Stack(
        children: [
          // 右侧渐变遮罩
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            width: 32,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    AppColors.void_,
                  ],
                ),
              ),
            ),
          ),
          
          // 日志内容
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._bootLogs.map((log) => _buildLogLine(log)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建单行日志
  Widget _buildLogLine(_BootLogItem log) {
    if (log.isHighlight) {
      return Container(
        margin: const EdgeInsets.only(left: -16, top: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.lifeSignal.withOpacity(0.1),
          border: Border(
            right: BorderSide(
              color: AppColors.lifeSignal,
              width: 4,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.terminal,
              size: 14,
              color: AppColors.textPrimary,
            ),
            const SizedBox(width: 12),
            Text(
              log.text,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 12,
                letterSpacing: 1,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      );
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '>',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.lifeSignal,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            log.text,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12,
              color: AppColors.lifeSignal.withOpacity(log.opacity),
              shadows: log.showNeon
                  ? [
                      Shadow(
                        color: AppColors.lifeSignal.withOpacity(0.8),
                        blurRadius: 5,
                      ),
                    ]
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建底部区域
  Widget _buildFooter() {
    return Column(
      children: [
        // 进度条
        BlockProgressBar(
          value: _progress * 100,
          maxValue: 100,
          totalBlocks: 12,
          label: 'SYSTEM_INTEGRITY',
          showPercentage: true,
          subtitle: '100% LIFE SUPPORT ESTABLISHED SOON...',
        ),
        
        const SizedBox(height: 24),
        
        // 系统元数据
        Container(
          padding: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColors.lifeSignal.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 内存
              Row(
                children: [
                  Icon(
                    Icons.memory,
                    size: 12,
                    color: AppColors.lifeSignal.withOpacity(0.4),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'MEM: 4096TB',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      letterSpacing: 1,
                      color: AppColors.lifeSignal.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
              
              // ID
              Text(
                'ID: 884-XU-PRO',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  letterSpacing: 1,
                  color: AppColors.lifeSignal.withOpacity(0.4),
                ),
              ),
              
              // CPU
              Row(
                children: [
                  Icon(
                    Icons.speed,
                    size: 12,
                    color: AppColors.lifeSignal.withOpacity(0.4),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'CPU: OVR_CLK',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      letterSpacing: 1,
                      color: AppColors.lifeSignal.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 启动日志项
class _BootLogItem {
  const _BootLogItem({
    required this.text,
    this.opacity = 1.0,
    this.showNeon = false,
    this.isHighlight = false,
  });

  final String text;
  final double opacity;
  final bool showNeon;
  final bool isHighlight;
}
