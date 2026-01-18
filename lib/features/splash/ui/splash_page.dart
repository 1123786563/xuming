import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/glitch_text.dart';

/// 系统启动页
/// 
/// BIOS 风格的开屏动画，模拟系统启动
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final List<String> _bootLogs = [];
  int _currentLogIndex = 0;
  bool _showLogo = false;
  bool _isComplete = false;

  // 启动日志序列
  static const List<String> _bootSequence = [
    '[BIOS] 初始化生物监控系统...',
    '[BIOS] 检测到生命信号...',
    '[SYS ] 加载续命协议 v2.0.1...',
    '[SYS ] 校验脊椎状态模块...',
    '[SYS ] 初始化久坐检测单元...',
    '[SYS ] 连接神经网络...',
    '[WARN] 检测到高危职场环境!',
    '[SYS ] 启动生存模式...',
    '[OK  ] 系统就绪',
  ];

  @override
  void initState() {
    super.initState();
    _startBootSequence();
  }

  void _startBootSequence() async {
    // 逐行显示启动日志
    for (var i = 0; i < _bootSequence.length; i++) {
      await Future.delayed(Duration(milliseconds: 150 + Random().nextInt(200)));
      if (mounted) {
        setState(() {
          _bootLogs.add(_bootSequence[i]);
          _currentLogIndex = i;
        });
      }
    }

    // 显示 Logo
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() => _showLogo = true);
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
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: SafeArea(
        child: Stack(
          children: [
            // 装饰性扫描线
            Positioned.fill(
              child: CustomPaint(
                painter: _ScanLinePainter(),
              ),
            ),
            
            // 启动日志
            Positioned(
              left: 24,
              top: 48,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'XUMING SURVIVAL SYSTEM',
                    style: AppTypography.pixelHeadline.copyWith(
                      fontSize: 14,
                      color: AppColors.lifeSignal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 1,
                    color: AppColors.lifeSignal.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  ..._bootLogs.map((log) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      log,
                      style: AppTypography.monoDecorative.copyWith(
                        fontSize: 12,
                        color: log.contains('[WARN]')
                            ? AppColors.cautionYellow
                            : log.contains('[OK')
                                ? AppColors.lifeSignal
                                : AppColors.textSecondary,
                      ),
                    ),
                  )),
                ],
              ),
            ),
            
            // Logo
            if (_showLogo)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GlitchText(
                      text: '续命',
                      style: AppTypography.pixelHeadline.copyWith(
                        fontSize: 64,
                        color: AppColors.lifeSignal,
                      ),
                      glitchIntensity: 1.5,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'XUMING SURVIVAL SYSTEM',
                      style: AppTypography.monoLabel.copyWith(
                        color: AppColors.bioUpgrade,
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (!_isComplete)
                      SizedBox(
                        width: 120,
                        child: LinearProgressIndicator(
                          backgroundColor: AppColors.cardBackground,
                          valueColor: AlwaysStoppedAnimation(
                            AppColors.lifeSignal,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            
            // 版本信息
            Positioned(
              left: 24,
              bottom: 48,
              child: Text(
                'v2.0.1 | BUILD 20260118',
                style: AppTypography.monoDecorative,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 扫描线绘制器
class _ScanLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.lifeSignal.withOpacity(0.03)
      ..strokeWidth = 1;

    // 绘制水平扫描线
    for (var y = 0.0; y < size.height; y += 3) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
