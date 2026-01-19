import 'dart:async';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// 健康评估指标数据模型
class HealthMetric {
  final IconData icon;
  final String title;
  final String subtitle;
  final String value;
  final Color valueColor;

  const HealthMetric({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    this.valueColor = AppColors.nuclearWarning,
  });
}

/// 生存现状评估报告弹窗
/// 
/// 赛博朋克风格的全屏弹窗，显示用户的健康评估数据
/// 包含脊柱健康分数、各项指标和"立即续命"按钮
class SurvivalAssessmentDialog extends StatefulWidget {
  const SurvivalAssessmentDialog({
    super.key,
    required this.healthScore,
    this.maxScore = 100,
    this.metrics = const [],
    this.warningMessage,
    this.onActionPressed,
    this.actionButtonText = '立即续命',
    this.seqId,
  });

  /// 健康分数
  final int healthScore;
  
  /// 满分
  final int maxScore;
  
  /// 指标列表
  final List<HealthMetric> metrics;
  
  /// 警告信息
  final String? warningMessage;
  
  /// 行动按钮点击回调
  final VoidCallback? onActionPressed;
  
  /// 行动按钮文字
  final String actionButtonText;
  
  /// 序列ID（装饰用）
  final String? seqId;

  /// 显示弹窗的便捷方法
  static Future<void> show(
    BuildContext context, {
    required int healthScore,
    int maxScore = 100,
    List<HealthMetric> metrics = const [],
    String? warningMessage,
    VoidCallback? onActionPressed,
    String actionButtonText = '立即续命',
    String? seqId,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (context) => SurvivalAssessmentDialog(
        healthScore: healthScore,
        maxScore: maxScore,
        metrics: metrics,
        warningMessage: warningMessage,
        onActionPressed: onActionPressed ?? () => Navigator.of(context).pop(),
        actionButtonText: actionButtonText,
        seqId: seqId,
      ),
    );
  }

  @override
  State<SurvivalAssessmentDialog> createState() => _SurvivalAssessmentDialogState();
}

class _SurvivalAssessmentDialogState extends State<SurvivalAssessmentDialog> 
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    // 脉冲动画
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final timestamp = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} '
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 主体容器
          Container(
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: AppColors.void_,
              border: Border.all(color: AppColors.cautionYellow, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cautionYellow.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 顶部把手
                _buildHandle(),
                
                // 标题区域
                _buildHeader(),
                
                // 分数区域
                _buildScoreSection(),
                
                // 指标列表
                _buildMetricsList(),
                
                // 警告区域
                if (widget.warningMessage != null) _buildWarningSection(),
                
                // 按钮区域
                _buildActionSection(timestamp),
              ],
            ),
          ),
          
          // 左上角标签
          Positioned(
            top: -10,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: AppColors.cautionYellow,
              child: Text(
                'BIO_DATA_FLAGGED',
                style: AppTypography.monoDecorative.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          
          // 右下角标签
          Positioned(
            bottom: -10,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: AppColors.nuclearWarning,
              child: Text(
                'ERROR_POSTURE_DETECTED',
                style: AppTypography.monoDecorative.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 顶部把手
  Widget _buildHandle() {
    return Container(
      height: 24,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.cautionYellow.withOpacity(0.3)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 4,
            color: AppColors.cautionYellow.withOpacity(0.4),
          ),
          const SizedBox(width: 4),
          Container(
            width: 8,
            height: 4,
            color: AppColors.cautionYellow,
          ),
          const SizedBox(width: 4),
          Container(
            width: 32,
            height: 4,
            color: AppColors.cautionYellow.withOpacity(0.4),
          ),
        ],
      ),
    );
  }

  /// 标题区域
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.cautionYellow.withOpacity(0.2),
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.transparent,
            AppColors.cautionYellow.withOpacity(0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            '生存现状评估报告',
            style: AppTypography.monoButton.copyWith(
              color: AppColors.cautionYellow,
              fontSize: 14,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '(CRITICAL)',
            style: AppTypography.monoLabel.copyWith(
              color: Colors.white,
              fontSize: 12,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  /// 分数区域
  Widget _buildScoreSection() {
    final bool isCritical = widget.healthScore < 30;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.cautionYellow.withOpacity(0.2)),
        ),
      ),
      child: Column(
        children: [
          // 副标题
          Text(
            'SPINE HEALTH INTEGRITY',
            style: AppTypography.monoDecorative.copyWith(
              color: AppColors.cautionYellow.withOpacity(0.6),
              fontSize: 10,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 12),
          
          // 分数
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.nuclearWarning.withOpacity(0.5 * _pulseAnimation.value),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      widget.healthScore.toString(),
                      style: const TextStyle(
                        fontFamily: 'ZpixFont',
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: AppColors.nuclearWarning,
                        height: 1,
                      ),
                    ),
                  );
                },
              ),
              Text(
                '/${widget.maxScore}',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 20,
                  color: AppColors.nuclearWarning.withOpacity(0.6),
                  height: 1,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // 错误状态
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.nuclearWarning,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'SYSTEM_FAILURE_DETECTED',
                style: AppTypography.monoLabel.copyWith(
                  color: AppColors.nuclearWarning,
                  fontSize: 11,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 指标列表
  Widget _buildMetricsList() {
    if (widget.metrics.isEmpty) return const SizedBox.shrink();
    
    return Container(
      color: AppColors.cautionYellow.withOpacity(0.05),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: widget.metrics.asMap().entries.map((entry) {
          final index = entry.key;
          final metric = entry.value;
          final isLast = index == widget.metrics.length - 1;
          
          return _buildMetricItem(metric, showBorder: !isLast);
        }).toList(),
      ),
    );
  }

  /// 单个指标项
  Widget _buildMetricItem(HealthMetric metric, {bool showBorder = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: showBorder 
            ? Border(bottom: BorderSide(color: AppColors.cautionYellow.withOpacity(0.1)))
            : null,
      ),
      child: Row(
        children: [
          // 图标
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.cautionYellow.withOpacity(0.1),
              border: Border.all(color: AppColors.cautionYellow.withOpacity(0.3)),
            ),
            child: Icon(
              metric.icon,
              color: AppColors.cautionYellow,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          
          // 标题和副标题
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metric.title,
                  style: AppTypography.monoButton.copyWith(
                    color: Colors.white,
                    fontSize: 13,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  metric.subtitle,
                  style: AppTypography.monoDecorative.copyWith(
                    color: AppColors.cautionYellow.withOpacity(0.5),
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          
          // 值
          Text(
            metric.value,
            style: AppTypography.monoButton.copyWith(
              color: metric.valueColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /// 警告区域
  Widget _buildWarningSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.nuclearWarning.withOpacity(0.1),
        border: Border(
          top: BorderSide(color: AppColors.nuclearWarning.withOpacity(0.3)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.report_problem_rounded,
            color: AppColors.nuclearWarning,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.warningMessage!,
              style: AppTypography.monoLabel.copyWith(
                color: AppColors.nuclearWarning,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 行动按钮区域
  Widget _buildActionSection(String timestamp) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // 主按钮
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return GestureDetector(
                onTap: () {
                  if (widget.onActionPressed != null) {
                    widget.onActionPressed!();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColors.lifeSignal,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lifeSignal.withOpacity(0.3 + 0.3 * _pulseAnimation.value),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: AppColors.lifeSignal.withOpacity(0.2 * _pulseAnimation.value),
                        blurRadius: 30,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.bolt,
                        color: Colors.black,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.actionButtonText,
                        style: AppTypography.monoButton.copyWith(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.bolt,
                        color: Colors.black,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 16),
          
          // 底部元数据
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SEQ_ID: ${widget.seqId ?? '99283-A'}',
                style: AppTypography.monoDecorative.copyWith(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 8,
                  letterSpacing: 1,
                ),
              ),
              Text(
                'TIMESTAMP: $timestamp',
                style: AppTypography.monoDecorative.copyWith(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 8,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
