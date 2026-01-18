import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// 警告面板组件
class WarningPanel extends StatefulWidget {
  final String title;
  final String description;
  final String analysisId;

  const WarningPanel({
    super.key,
    required this.title,
    required this.description,
    required this.analysisId,
  });

  @override
  State<WarningPanel> createState() => _WarningPanelState();
}

class _WarningPanelState extends State<WarningPanel> {
  bool _isAcknowledged = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.nuclearWarning.withOpacity(0.05),
        border: Border.all(color: AppColors.nuclearWarning.withOpacity(0.5), width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 悬浮标签
          Positioned(
            top: -32,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.void_,
                border: Border.all(color: AppColors.nuclearWarning.withOpacity(0.5), width: 1),
              ),
              child: Text(
                'SYSTEM WARNING // 警告',
                style: AppTypography.monoLabel.copyWith(
                  color: AppColors.nuclearWarning,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: AppColors.nuclearWarning,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: AppTypography.monoBody.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.description,
                          style: AppTypography.monoBody.copyWith(
                            color: const Color(0xFFA0BC9A),
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.only(top: 12),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0x33FF003C), width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ANALYSIS_ID: ${widget.analysisId}',
                      style: AppTypography.monoDecorative.copyWith(
                        color: const Color(0xFFA0BC9A),
                      ),
                    ),
                    Switch(
                      value: _isAcknowledged,
                      onChanged: (v) => setState(() => _isAcknowledged = v),
                      activeTrackColor: AppColors.nuclearWarning.withOpacity(0.2),
                      activeColor: AppColors.nuclearWarning,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey[800],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
