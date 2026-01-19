import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cyber_button.dart';
import '../../../shared/widgets/radar_chart.dart';
import '../../../shared/widgets/stat_card.dart';
import '../../../shared/widgets/warning_panel.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../../shared/widgets/grid_background.dart';
import '../models/weekly_report_data.dart';

/// 上周生存周报弹窗
class WeeklyReportDialog extends StatelessWidget {
  final WeeklyReportData data;

  const WeeklyReportDialog({
    super.key,
    required this.data,
  });

  /// 静态方法用于弹出对话框
  static Future<void> show(BuildContext context, {WeeklyReportData? data}) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'WeeklyReport',
      barrierColor: Colors.black.withOpacity(0.9),
      pageBuilder: (context, animation, secondaryAnimation) {
        return WeeklyReportDialog(data: data ?? WeeklyReportData.mock());
      },
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, a1, a2, child) {
        return FadeTransition(
          opacity: a1,
          child: ScaleTransition(
            scale: CurvedAnimation(parent: a1, curve: Curves.easeOutBack),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          constraints: const BoxConstraints(maxWidth: 430),
          decoration: BoxDecoration(
            color: AppColors.void_,
            border: Border.all(color: const Color(0xFF3E5639), width: 1),
          ),
          child: Stack(
            children: [
              // 背景网格
              const GridBackground(),
              
              // 扫描线
              const ScanlineOverlay(opacity: 0.05),

              Column(
                children: [
                  // 1. 顶部标题栏
                  _buildHeader(context),
                  
                  // 2. 可滚动内容
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Column(
                        children: [
                          _buildHeadline(),
                          _buildRadarSection(),
                          _buildGradeSection(),
                          _buildStatsGrid(),
                          _buildWarningSection(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // 3. 底部固定按钮
              _buildBottomActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF3E5639), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.terminal, color: AppColors.lifeSignal, size: 28),
          Text(
            '上周生存记录：系统存续状态',
            style: AppTypography.monoLabel.copyWith(
              color: AppColors.lifeSignal,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              shadows: [
                const Shadow(color: AppColors.lifeSignal, blurRadius: 10),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.lifeSignal),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline() {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 24),
      child: Column(
        children: [
          Text(
            '[ONLINE]',
            style: AppTypography.pixelHeadline.copyWith(
              color: AppColors.lifeSignal,
              shadows: [const Shadow(color: AppColors.lifeSignal, blurRadius: 10)],
            ),
          ),
          Text(
            'SYSTEM PERSISTENCE',
            style: AppTypography.pixelHeadline.copyWith(
              color: AppColors.lifeSignal,
              shadows: [const Shadow(color: AppColors.lifeSignal, blurRadius: 10)],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'WEEK ${data.weekNumber} // DEPLOYMENT SUCCESS',
            style: AppTypography.monoLabel.copyWith(
              color: const Color(0xFFA0BC9A),
              letterSpacing: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadarSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.void_,
          border: Border.all(color: const Color(0xFF3E5639), width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'RADAR_INIT_VER.8.1',
                style: AppTypography.monoDecorative.copyWith(fontSize: 8),
              ),
            ),
            const SizedBox(height: 16),
            RadarChart(
              values: data.radarData.toList(),
              labels: const ['颈椎完整度', '腰椎压力值', '活动频率', '摸鱼技巧', '生命体征'],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(color: Color(0xFF3E5639)),
            right: BorderSide(color: Color(0xFF3E5639)),
            bottom: BorderSide(color: Color(0xFF3E5639)),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '存续评估等级',
                  style: AppTypography.monoLabel.copyWith(fontSize: 10),
                ),
                const SizedBox(height: 4),
                Text(
                  data.grade,
                  style: AppTypography.pixelHP.copyWith(
                    shadows: [const Shadow(color: AppColors.lifeSignal, blurRadius: 15)],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '+${data.efficiencyChange}% EFFICIENCY',
                  style: AppTypography.monoLabel.copyWith(
                    color: AppColors.lifeSignal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'COMPARED TO PREV_WEEK',
                  style: AppTypography.monoLabel.copyWith(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: StatCard(
                  label: '续命时长',
                  value: '+${data.survivalMinutes}min',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: StatCard(
                  label: '规避核击',
                  value: '${data.evadedAttacks} 次',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          StatCard(
            label: '同类存续排名',
            value: 'TOP ${data.rankPercentile}%',
            subValue: 'CYBER-WORKER',
          ),
        ],
      ),
    );
  }

  Widget _buildWarningSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: WarningPanel(
        title: data.warningTitle,
        description: data.warningDescription,
        analysisId: data.analysisId,
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.void_,
          border: Border(top: BorderSide(color: Color(0xFF3E5639))),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: CyberButton(
                text: '分享日志',
                isOutlined: true,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('分享功能开发中... SYSTEM_LOG_EXPORT_PENDING'),
                      backgroundColor: AppColors.void_,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: CyberButton(
                text: '开启新周维护',
                onPressed: () {
                   Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
