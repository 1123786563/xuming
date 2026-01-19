import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/scanline_overlay.dart';

/// 续命保单分享海报页面
/// 
/// 赛博朋克风格的分享海报，展示用户健康数据和成就
class SharePosterPage extends StatelessWidget {
  const SharePosterPage({
    super.key,
    this.repairLevel = 85,
    this.sittingTime = '12h',
    this.lifeExtended = '+15m',
    this.expiryDate = '2024.12.31',
  });

  /// 修复等级百分比
  final int repairLevel;
  
  /// 久坐时间
  final String sittingTime;
  
  /// 续命时长
  final String lifeExtended;
  
  /// 过期日期
  final String expiryDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // 扫描线覆盖层
          const ScanlineOverlay(),
          
          // 主内容
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 430),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 头部区域
                    _buildHeader(),
                    
                    // 生物扫描可视化区域
                    _buildBiometricVisualization(),
                    
                    // 统计数据网格
                    _buildStatsGrid(),
                    
                    // 毒鸡汤卡片
                    _buildQuoteCard(),
                    
                    // 底部终端区域
                    _buildTerminalFooter(),
                    
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建头部区域
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 协议版本号
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SYS_PROTOCOL_XUMING_V1.0',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 10,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lifeSignal,
                ),
              ),
              Icon(
                Icons.terminal,
                color: AppColors.lifeSignal,
                size: 20,
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 标题和保密印章
          Stack(
            clipBehavior: Clip.none,
            children: [
              // 主标题
              const Text(
                '续命\n保单',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 64, // Matches 64px in design
                  fontWeight: FontWeight.bold,
                  height: 0.9,
                  letterSpacing: -2,
                  color: AppColors.textPrimary,
                ),
              ),
              
              // CONFIDENTIAL 印章
              Positioned(
                top: 0,
                right: -10,
                child: Transform.rotate(
                  angle: -0.26, // 约-15度
                  child: Opacity(
                    opacity: 0.8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.nuclearWarning,
                          width: 4,
                        ),
                      ),
                      child: const Text(
                        'CONFIDENTIAL',
                        style: TextStyle(
                          fontFamily: 'ZpixFont',
                          fontSize: 24, // Matches text-2xl
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                          color: AppColors.nuclearWarning,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          
          const SizedBox(height: 16),
          
          // 分割线与副标题
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: AppColors.lifeSignal.withOpacity(0.3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'SURVIVAL INSURANCE POLICY',
                  style: TextStyle(
                    fontFamily: 'ZpixFont',
                    fontSize: 8,
                    letterSpacing: 1,
                    color: AppColors.lifeSignal.withOpacity(0.6),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: AppColors.lifeSignal.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建生物扫描可视化区域
  Widget _buildBiometricVisualization() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        border: Border.all(
          color: AppColors.lifeSignal.withOpacity(0.1),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: Stack(
          children: [
            // 占位骨骼扫描图像（使用渐变模拟）
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0, -0.3),
                    radius: 0.8,
                    colors: [
                      AppColors.lifeSignal.withOpacity(0.15),
                      AppColors.lifeSignal.withOpacity(0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: const Center(
                  child: Opacity(
                    opacity: 0.4,
                    child: Icon(
                      Icons.accessibility_new,
                      size: 240,
                      color: AppColors.lifeSignal,
                    ),
                  ),
                ),
              ),
            ),
            
            // 背景装饰线条 (模拟数据波动)
            ...List.generate(5, (index) => Positioned(
              left: 0,
              right: 0,
              top: 40.0 + index * 80,
              child: Container(
                height: 1,
                color: AppColors.lifeSignal.withOpacity(0.05),
              ),
            )),
            ...List.generate(5, (index) => Positioned(
              top: 0,
              bottom: 0,
              left: 40.0 + index * 80,
              child: Container(
                width: 1,
                color: AppColors.lifeSignal.withOpacity(0.05),
              ),
            )),

            
            // 诊断信息覆盖层
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 顶部诊断信息
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 左侧状态
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDiagnosticLine('SPINE_ALIGNMENT:', 'CRITICAL', AppColors.lifeSignal),
                            _buildDiagnosticLine('LUMBAR_STRESS:', '88%', AppColors.lifeSignal),
                            _buildDiagnosticLine('CERVICAL_STATUS:', 'DEGRADED', AppColors.lifeSignal),
                          ],
                        ),
                        // 右侧ID信息
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildDiagnosticLine('WAR_ID:', '99283-X', AppColors.nuclearWarning),
                            _buildDiagnosticLine('LOC:', 'GRID_SECTOR_7', AppColors.nuclearWarning),
                          ],
                        ),
                      ],
                    ),
                    
                    // 底部修复进度条
                    _buildRepairProgressBar(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建诊断信息行
  Widget _buildDiagnosticLine(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        '$label $value',
        style: TextStyle(
          fontFamily: 'ZpixFont',
          fontSize: 8,
          color: color,
          height: 1.4,
        ),
      ),
    );
  }

  /// 构建修复进度条
  Widget _buildRepairProgressBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        border: Border(
          top: BorderSide(
            color: AppColors.lifeSignal.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 标题行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'REPAIR LEVEL',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: AppColors.lifeSignal,
                ),
              ),
              Text(
                '$repairLevel%',
                style: const TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lifeSignal,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // 进度条
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.lifeSignal.withOpacity(0.2),
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              widthFactor: repairLevel / 100,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.lifeSignal,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lifeSignal.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // 底部状态信息
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SYS_DIAGNOSTIC_COMPLETE',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 8,
                  fontStyle: FontStyle.italic,
                  color: AppColors.lifeSignal.withOpacity(0.5),
                ),
              ),
              Text(
                'EST_TIME: 00:04:12',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 8,
                  color: AppColors.lifeSignal.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建统计数据网格
  Widget _buildStatsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          // 久坐时间
          Expanded(
            child: _buildStatCard(
              label: 'Sitting Time',
              value: sittingTime,
              subLabel: '+12% RISK',
              isHighlighted: false,
              subLabelColor: AppColors.nuclearWarning,
            ),
          ),
          const SizedBox(width: 12),
          // 续命时长 - 高亮
          Expanded(
            child: _buildStatCard(
              label: 'Life Extended',
              value: lifeExtended,
              subLabel: 'RECOVERED',
              isHighlighted: true,
              subLabelColor: AppColors.lifeSignal,
            ),
          ),
          const SizedBox(width: 12),
          // 状态
          Expanded(
            child: _buildStatCard(
              label: 'Status',
              value: 'TEMP_FUNC',
              subLabel: 'STABLE_V3',
              isHighlighted: false,
              subLabelColor: AppColors.lifeSignal.withOpacity(0.4),
              isSmallValue: true,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建统计卡片
  Widget _buildStatCard({
    required String label,
    required String value,
    required String subLabel,
    required bool isHighlighted,
    required Color subLabelColor,
    bool isSmallValue = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isHighlighted 
            ? AppColors.lifeSignal.withOpacity(0.1)
            : AppColors.lifeSignal.withOpacity(0.05),
        border: Border.all(
          color: isHighlighted 
              ? AppColors.lifeSignal
              : AppColors.lifeSignal.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: isHighlighted ? [
          BoxShadow(
            color: AppColors.nuclearWarning.withOpacity(0.5),
            offset: const Offset(1, 1),
          ),
          BoxShadow(
            color: AppColors.lifeSignal.withOpacity(0.5),
            offset: const Offset(-1, -1),
          ),
        ] : null,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontFamily: 'ZpixFont',
              fontSize: 8,
              color: AppColors.lifeSignal.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'ZpixFont',
              fontSize: isSmallValue ? 10 : 18,
              fontWeight: FontWeight.bold,
              color: isHighlighted ? AppColors.lifeSignal : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subLabel,
            style: TextStyle(
              fontFamily: 'ZpixFont',
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: subLabelColor,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建毒鸡汤卡片
  Widget _buildQuoteCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 主卡片
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.lifeSignal,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '"恭喜，你又成功躲过了一次脊椎结构的崩塌。现在，回去当你的数字工蜂吧。"',
                  style: TextStyle(
                    fontFamily: 'ZpixFont',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    height: 1.6,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ID: X-9012_SYSTEM_MESSAGE',
                      style: TextStyle(
                        fontFamily: 'ZpixFont',
                        fontSize: 8,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(const ClipboardData(
                          text: '恭喜，你又成功躲过了一次脊椎结构的崩塌。现在，回去当你的数字工蜂吧。',
                        ));
                      },
                      child: Icon(
                        Icons.content_copy,
                        size: 14,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Warning: Truth 标签
          Positioned(
            top: -8,
            right: -8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              color: AppColors.nuclearWarning,
              child: const Text(
                'WARNING: TRUTH',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建底部终端区域
  Widget _buildTerminalFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lifeSignal.withOpacity(0.05),
        border: Border(
          top: BorderSide(
            color: AppColors.lifeSignal.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 左侧信息
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 过期日期
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    color: AppColors.lifeSignal,
                    child: const Text(
                      'EXP_DATE',
                      style: TextStyle(
                        fontFamily: 'ZpixFont',
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    expiryDate,
                    style: const TextStyle(
                      fontFamily: 'ZpixFont',
                      fontSize: 10,
                      color: AppColors.lifeSignal,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // 系统安全
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    color: AppColors.lifeSignal.withOpacity(0.2),
                    child: const Text(
                      'SYS_SEC',
                      style: TextStyle(
                        fontFamily: 'ZpixFont',
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lifeSignal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'ENCRYPTED_AUTH',
                    style: TextStyle(
                      fontFamily: 'ZpixFont',
                      fontSize: 10,
                      color: AppColors.lifeSignal.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // 哈希和节点信息
              Text(
                'HASH: 0x8823FB...991A',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 8,
                  color: AppColors.lifeSignal.withOpacity(0.3),
                ),
              ),
              Text(
                'NODE: TOKYO_SERVER_04',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 8,
                  color: AppColors.lifeSignal.withOpacity(0.3),
                ),
              ),
            ],
          ),
          
          // 右侧二维码占位
          _buildQRCodePlaceholder(),
        ],
      ),
    );
  }

  /// 构建二维码占位
  Widget _buildQRCodePlaceholder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Stack(
          children: [
            // 外层脉冲边框
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.lifeSignal.withOpacity(0.4),
                  width: 1,
                ),
              ),
            ),
            // 内层二维码区域
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lifeSignal.withOpacity(0.1),
                    border: Border.all(
                      color: AppColors.lifeSignal,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: _buildQRPattern(),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'SCAN_TO_REPAIR',
          style: TextStyle(
            fontFamily: 'ZpixFont',
            fontSize: 8,
            letterSpacing: 2,
            color: AppColors.lifeSignal,
          ),
        ),
      ],
    );
  }

  /// 构建二维码图案
  Widget _buildQRPattern() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lifeSignal.withOpacity(0.2),
      ),
      child: CustomPaint(
        painter: _QRPatternPainter(color: AppColors.lifeSignal),
        size: const Size.square(60),
      ),
    );
  }
}

/// 二维码图案绘制器
class _QRPatternPainter extends CustomPainter {
  _QRPatternPainter({required this.color});
  
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    const dotSize = 4.0;
    const gap = 4.0;
    
    for (double x = 0; x < size.width; x += dotSize + gap) {
      for (double y = 0; y < size.height; y += dotSize + gap) {
        // 创建随机化的点阵效果
        if ((x.toInt() + y.toInt()) % 3 != 0) {
          canvas.drawRect(
            Rect.fromLTWH(x, y, dotSize, dotSize),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
