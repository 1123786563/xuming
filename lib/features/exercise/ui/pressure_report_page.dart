import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/scanline_overlay.dart';

/// 压力释放对比报告页
/// 
/// 设计参考：UI 设计图 - 任务完成：结构修复报告
/// 包含：前后对比视觉、统计数据、时间线日志、操作按钮
class PressureReportPage extends StatelessWidget {
  const PressureReportPage({super.key});

  // 设计系统颜色
  static const Color _primaryGreen = Color(0xFF80FF00);
  static const Color _glitchRed = Color(0xFFFF0033);
  static const Color _surfaceDark = Color(0xFF121212);
  static const Color _backgroundDark = Color(0xFF080808);
  static const Color _borderGreen = Color(0xFF4D6B2E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundDark,
      body: Stack(
        children: [
          // 背景扫描线效果
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: const ScanlineOverlay(),
            ),
          ),
          // CRT 覆盖效果
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.0,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.2),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // HUD 边框装饰
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.05),
                    width: 10,
                  ),
                ),
              ),
            ),
          ),
          // 主内容
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildComparisonSection(),
                        _buildStatsSection(),
                        _buildActionQuotePanel(),
                        _buildTimelineSection(),
                        const SizedBox(height: 120), // 底部按钮空间
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 固定底部操作区
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildFooterActions(context),
          ),
          // 装饰性角落标签 (仅大屏显示)
          Positioned(
            top: 80,
            right: 0,
            child: Transform.rotate(
              angle: -1.5708, // -90 degrees
              alignment: Alignment.centerRight,
              child: Opacity(
                opacity: 0.2,
                child: Text(
                  'PROJECT_REANIMATION_v4.2',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 8,
                    letterSpacing: 4,
                    color: _primaryGreen,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 顶部 Header
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _backgroundDark.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(color: _primaryGreen.withOpacity(0.2)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左侧图标
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: _primaryGreen.withOpacity(0.3)),
            ),
            child: const Icon(
              Icons.grid_view,
              color: _primaryGreen,
              size: 24,
            ),
          ),
          // 中间标题
          Column(
            children: [
              Text(
                '任务完成：结构修复报告',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'VER: 0.9.42_STABLE',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: _primaryGreen.withOpacity(0.6),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          // 右侧监控按钮
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: _primaryGreen.withOpacity(0.3)),
            ),
            child: const Icon(
              Icons.show_chart,
              color: _primaryGreen,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  /// 对比区域 - PRE-FIX vs POST-FIX
  Widget _buildComparisonSection() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          // PRE-FIX 卡片 (红色/危险)
          Expanded(
            child: _buildComparisonCard(
              phase: 'PRE-FIX',
              status: 'CRITICAL',
              statusColor: _glitchRed,
              borderColor: _glitchRed.withOpacity(0.4),
              bgColor: _glitchRed.withOpacity(0.05),
              gradientColor: _glitchRed.withOpacity(0.4),
              subText1: 'STRESS: MAX_CAPACITY',
              subText2: 'SCAN_ID: #B_442',
              isLeft: true,
              imageDescription: '脊柱热力图显示危险压力',
            ),
          ),
          const SizedBox(width: 4),
          // POST-FIX 卡片 (绿色/稳定)
          Expanded(
            child: _buildComparisonCard(
              phase: 'POST-FIX',
              status: 'STABLE',
              statusColor: _primaryGreen,
              borderColor: _primaryGreen.withOpacity(0.4),
              bgColor: _primaryGreen.withOpacity(0.05),
              gradientColor: _primaryGreen.withOpacity(0.3),
              subText1: 'INTEGRITY: OPTIMIZED',
              subText2: 'SCAN_ID: #A_442',
              isLeft: false,
              imageDescription: '脊柱对齐优化完成',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard({
    required String phase,
    required String status,
    required Color statusColor,
    required Color borderColor,
    required Color bgColor,
    required Color gradientColor,
    required String subText1,
    required String subText2,
    required bool isLeft,
    required String imageDescription,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        color: bgColor,
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          // 图片区域
          AspectRatio(
            aspectRatio: 4 / 5,
            child: Stack(
              children: [
                // 背景
                Container(
                  color: _surfaceDark,
                  child: Center(
                    child: Icon(
                      isLeft ? Icons.warning_amber : Icons.check_circle_outline,
                      size: 80,
                      color: statusColor.withOpacity(0.3),
                    ),
                  ),
                ),
                // 渐变覆盖
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          gradientColor,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                // 状态标签
                Positioned(
                  top: 8,
                  left: isLeft ? 8 : null,
                  right: isLeft ? null : 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    color: statusColor,
                    child: Text(
                      status,
                      style: TextStyle(
                        color: isLeft ? Colors.white : Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // 信息文字
          Text(
            'Phase: $phase',
            style: TextStyle(
              color: statusColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subText1,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          Text(
            subText2,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Colors.white.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  /// 统计数据区域
  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          // 上排两个统计卡片
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  label: 'Pressure Relieved',
                  value: '-42%',
                  valueColor: _glitchRed,
                  icon: Icons.trending_down,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  label: 'HP Recovered',
                  value: '+12%',
                  valueColor: _primaryGreen,
                  icon: Icons.add_circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 全宽状态卡片
          _buildIntegrityStatusCard(),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required Color valueColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: _borderGreen.withOpacity(0.5)),
        color: _surfaceDark,
      ),
      child: Stack(
        children: [
          // 右上角装饰
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: _primaryGreen.withOpacity(0.4)),
                  right: BorderSide(color: _primaryGreen.withOpacity(0.4)),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      color: valueColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(icon, color: valueColor, size: 14),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrityStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: _borderGreen.withOpacity(0.5)),
        color: _primaryGreen.withOpacity(0.1),
      ),
      child: Stack(
        children: [
          // 右上角装饰
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: _primaryGreen),
                  right: BorderSide(color: _primaryGreen),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CERVICAL INTEGRITY STATUS',
                style: TextStyle(
                  color: _primaryGreen,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'IMPROVED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    '+100.00%',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: _primaryGreen,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 引用/动作面板
  Widget _buildActionQuotePanel() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: _primaryGreen.withOpacity(0.2)),
          color: _surfaceDark,
        ),
        child: Stack(
          children: [
            // 左上角装饰
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: _primaryGreen, width: 2),
                    left: BorderSide(color: _primaryGreen, width: 2),
                  ),
                ),
              ),
            ),
            // 右下角装饰
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: _primaryGreen, width: 2),
                    right: BorderSide(color: _primaryGreen, width: 2),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "YOU'VE DELAYED YOUR DECOMPOSITION BY ANOTHER DAY.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Don't let it go to your head.",
                  style: TextStyle(
                    color: _primaryGreen.withOpacity(0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 12),
                // 分割线
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _primaryGreen.withOpacity(0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // 系统日志行
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // 脉冲点
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _primaryGreen,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'SYS_LOG: DATA_ANALYSIS_COMPLETE',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10,
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 14,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 时间线/过程日志
  Widget _buildTimelineSection() {
    final events = [
      _TimelineEvent(
        icon: Icons.terminal,
        title: 'BIO_METRIC_SCAN_INITIATED',
        time: '09:41:01 // SUCCESS',
        isHighlighted: false,
        hasLine: true,
      ),
      _TimelineEvent(
        icon: Icons.accessibility_new,
        title: 'TENSION_REDUCTION_SEQUENCING',
        time: '09:41:45 // OPTIMIZING',
        isHighlighted: false,
        hasLine: true,
      ),
      _TimelineEvent(
        icon: Icons.shield_outlined,
        title: 'STRUCTURAL_INTEGRITY_SYNC',
        time: '09:42:10 // DATA_SYNC_COMPLETE',
        isHighlighted: true,
        hasLine: false,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: events.map((e) => _buildTimelineItem(e)).toList(),
      ),
    );
  }

  Widget _buildTimelineItem(_TimelineEvent event) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 左侧图标和连接线
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(
                  color: event.isHighlighted 
                      ? _primaryGreen 
                      : _primaryGreen.withOpacity(0.3),
                ),
                color: _primaryGreen.withOpacity(0.1),
                boxShadow: event.isHighlighted ? [
                  BoxShadow(
                    color: _primaryGreen.withOpacity(0.4),
                    blurRadius: 10,
                  ),
                ] : null,
              ),
              child: Icon(
                event.icon,
                size: 12,
                color: _primaryGreen,
              ),
            ),
            if (event.hasLine)
              Container(
                width: 1,
                height: 32,
                color: _primaryGreen.withOpacity(0.2),
              ),
          ],
        ),
        const SizedBox(width: 16),
        // 右侧文字
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: event.hasLine ? 16 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: event.isHighlighted 
                        ? _primaryGreen 
                        : Colors.white.withOpacity(0.8),
                    fontStyle: event.isHighlighted ? FontStyle.italic : FontStyle.normal,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  event.time,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: event.isHighlighted 
                        ? Colors.white.withOpacity(0.4) 
                        : _primaryGreen.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 底部固定操作按钮
  Widget _buildFooterActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _backgroundDark.withOpacity(0.95),
        border: Border(
          top: BorderSide(color: _primaryGreen.withOpacity(0.2)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 主按钮 - Return to Survival Dashboard
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => context.go(AppRoutes.dashboard),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryGreen,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.dashboard, size: 20),
                label: const Text(
                  'RETURN TO SURVIVAL DASHBOARD',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // 次按钮 - Share Success
            SizedBox(
              width: double.infinity,
              height: 40,
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: 实现分享功能
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: _primaryGreen,
                  side: BorderSide(color: _primaryGreen.withOpacity(0.4)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                icon: const Icon(Icons.share, size: 18),
                label: const Text(
                  'SHARE SUCCESS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 时间线事件数据模型
class _TimelineEvent {
  final IconData icon;
  final String title;
  final String time;
  final bool isHighlighted;
  final bool hasLine;

  const _TimelineEvent({
    required this.icon,
    required this.title,
    required this.time,
    required this.isHighlighted,
    required this.hasLine,
  });
}
