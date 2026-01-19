import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../report/widgets/report_header.dart';
import '../../report/widgets/comparison_card.dart';
import '../../report/widgets/report_stat_card.dart';
import '../../report/widgets/report_timeline.dart';

/// 压力释放对比报告页
/// 
/// 设计参考：UI 设计图 - 任务完成：结构修复报告
class PressureReportPage extends StatelessWidget {
  const PressureReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: Stack(
        children: [
          // 背景扫描线效果
          const Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: ScanlineOverlay(),
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
                const ReportHeader(),
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
              child: const Opacity(
                opacity: 0.2,
                child: Text(
                  'PROJECT_REANIMATION_v4.2',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 8,
                    letterSpacing: 4,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          // PRE-FIX 卡片 (红色/危险)
          Expanded(
            child: ComparisonCard(
              phase: 'PRE-FIX',
              status: 'CRITICAL',
              statusColor: AppColors.nuclearWarning,
              borderColor: AppColors.nuclearWarning.withOpacity(0.4),
              bgColor: AppColors.nuclearWarning.withOpacity(0.05),
              gradientColor: AppColors.nuclearWarning.withOpacity(0.4),
              subText1: 'STRESS: MAX_CAPACITY',
              subText2: 'SCAN_ID: #B_442',
              isLeft: true,
              imageDescription: '脊柱热力图显示危险压力',
            ),
          ),
          const SizedBox(width: 4),
          // POST-FIX 卡片 (绿色/稳定)
          Expanded(
            child: ComparisonCard(
              phase: 'POST-FIX',
              status: 'STABLE',
              statusColor: AppColors.primary,
              borderColor: AppColors.primary.withOpacity(0.4),
              bgColor: AppColors.primary.withOpacity(0.05),
              gradientColor: AppColors.primary.withOpacity(0.3),
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

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          // 上排两个统计卡片
          const Row(
            children: [
              Expanded(
                child: ReportStatCard(
                  label: 'Pressure Relieved',
                  value: '-42%',
                  valueColor: AppColors.nuclearWarning,
                  icon: Icons.trending_down,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ReportStatCard(
                  label: 'HP Recovered',
                  value: '+12%',
                  valueColor: AppColors.primary,
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

  Widget _buildIntegrityStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF4D6B2E).withOpacity(0.5)),
        color: AppColors.primary.withOpacity(0.1),
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
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.primary),
                  right: BorderSide(color: AppColors.primary),
                ),
              ),
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CERVICAL INTEGRITY STATUS',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
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
                      color: AppColors.primary,
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

  Widget _buildActionQuotePanel() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          color: const Color(0xFF121212),
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
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.primary, width: 2),
                    left: BorderSide(color: AppColors.primary, width: 2),
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
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.primary, width: 2),
                    right: BorderSide(color: AppColors.primary, width: 2),
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
                    color: AppColors.primary.withOpacity(0.8),
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
                        AppColors.primary.withOpacity(0.5),
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
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
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

  Widget _buildTimelineSection() {
    final events = [
      TimelineEvent(
        icon: Icons.terminal,
        title: 'BIO_METRIC_SCAN_INITIATED',
        time: '09:41:01 // SUCCESS',
        isHighlighted: false,
        hasLine: true,
      ),
      TimelineEvent(
        icon: Icons.accessibility_new,
        title: 'TENSION_REDUCTION_SEQUENCING',
        time: '09:41:45 // OPTIMIZING',
        isHighlighted: false,
        hasLine: true,
      ),
      TimelineEvent(
        icon: Icons.shield_outlined,
        title: 'STRUCTURAL_INTEGRITY_SYNC',
        time: '09:42:10 // DATA_SYNC_COMPLETE',
        isHighlighted: true,
        hasLine: false,
      ),
    ];

    return ReportTimeline(events: events);
  }

  Widget _buildFooterActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF080808).withOpacity(0.95),
        border: Border(
          top: BorderSide(color: AppColors.primary.withOpacity(0.2)),
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
                  backgroundColor: AppColors.primary,
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
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary.withOpacity(0.4)),
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
