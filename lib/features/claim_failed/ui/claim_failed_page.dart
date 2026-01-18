import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glitch_text.dart';
import '../../../shared/widgets/scanline_overlay.dart';

/// 索赔失败-惩罚页
/// 
/// 当生存任务失败或索赔被拒绝时显示的视觉页面
class ClaimFailedPage extends ConsumerWidget {
  const ClaimFailedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // 扫描线背景
          const ScanlineOverlay(lineOpacity: 0.05, lineSpacing: 4),
          
          // 背景装饰文字
          Positioned(
            top: 40,
            left: 20,
            child: Opacity(
              opacity: 0.3,
              child: Text(
                'ERR_HEART_RATE_NOT_FOUND\nKERNEL_PANIC_0x000F2\nLOG_TRACE: ABORTED',
                style: AppTypography.monoDecorative.copyWith(color: AppColors.nuclearWarning),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: Opacity(
              opacity: 0.3,
              child: Text(
                'SYS_SHUTDOWN_SEQUENCE_START\nUID: 8829-QX-09\nLOC: SECTOR_7G',
                textAlign: TextAlign.right,
                style: AppTypography.monoDecorative.copyWith(color: AppColors.warningOrange),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // 顶部状态栏
                _buildAppBar(context),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        
                        // 故障标题
                        GlitchText(
                          text: '索赔失败',
                          style: AppTypography.pixelHeadline.copyWith(
                            fontSize: 48,
                            color: AppColors.textPrimary,
                          ),
                          glitchIntensity: 1.5,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'CLAIM DENIED // INSURANCE VOIDED',
                          style: AppTypography.monoDecorative.copyWith(
                            color: AppColors.nuclearWarning,
                            letterSpacing: 2,
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // 中央视觉区域 (脊椎视觉)
                        _buildVisualZone(),
                        
                        const SizedBox(height: 40),
                        
                        // 叙述文案
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: AppTypography.monoBody.copyWith(fontSize: 16),
                              children: [
                                const TextSpan(text: 'Due to your biological laziness, your '),
                                TextSpan(
                                  text: 'survival insurance',
                                  style: AppTypography.monoBody.copyWith(
                                    color: AppColors.nuclearWarning,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(text: ' is now void.'),
                              ],
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // 统计卡片网格
                        _buildStatsGrid(),
                        
                        const SizedBox(height: 32),
                        
                        // 毒舌语录
                        _buildToxicQuote(),
                        
                        const SizedBox(height: 48),
                        
                        // CTA 按钮
                        _buildCTAButton(),
                        
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.close, color: AppColors.nuclearWarning, size: 28),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.nuclearWarning.withOpacity(0.3))),
            ),
            child: Text(
              'CRITICAL_ERROR',
              style: AppTypography.monoLabel.copyWith(
                color: AppColors.nuclearWarning,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          const Icon(Icons.warning_amber_rounded, color: AppColors.warningOrange, size: 24),
        ],
      ),
    );
  }

  Widget _buildVisualZone() {
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 核心骨骼/视觉背景
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.nuclearWarning.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
          ),
          
          // 这里可以使用图片或者 CustomPaint 画一些抽象线条
          // 暂时用占位符文字和装饰线模拟
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'fractured_biometric_spine_3d',
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.nuclearWarning.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 100,
                height: 2,
                decoration: const BoxDecoration(
                  color: AppColors.warningOrange,
                  boxShadow: [BoxShadow(color: AppColors.warningOrange, blurRadius: 10)],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: 150,
                height: 1,
                color: AppColors.nuclearWarning.withOpacity(0.5),
              ),
            ],
          ),
          
          // 漂浮标签
          Positioned(
            top: 20,
            right: 40,
            child: Transform.rotate(
              angle: 0.1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                color: AppColors.nuclearWarning,
                child: Text(
                  'BIOLOGICAL_FAILURE',
                  style: AppTypography.monoDecorative.copyWith(
                    color: AppColors.void_,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
          
          Positioned(
            bottom: 40,
            left: 20,
            child: Transform.rotate(
              angle: -0.05,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.warningOrange),
                ),
                child: Text(
                  'STRUCTURAL_INTEGRITY_0%',
                  style: AppTypography.monoDecorative.copyWith(
                    color: AppColors.warningOrange,
                    fontSize: 8,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        Expanded(
          child: _PunishmentStatCard(
            label: 'STREAK_VAL',
            value: '0 DAYS',
            subLabel: '-100% LOSS',
            icon: Icons.trending_down,
            color: AppColors.nuclearWarning,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _PunishmentStatCard(
            label: 'VITAL_SIGNS',
            value: 'FAILING',
            subLabel: 'CRITICAL',
            icon: Icons.emergency_share,
            color: AppColors.warningOrange,
          ),
        ),
      ],
    );
  }

  Widget _buildToxicQuote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A).withOpacity(0.5),
        border: const Border(
          left: BorderSide(color: AppColors.nuclearWarning, width: 4),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            top: -34,
            left: -34,
            child: Icon(Icons.format_quote, color: AppColors.nuclearWarning, size: 32),
          ),
          RichText(
            text: TextSpan(
              style: AppTypography.monoBody.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
              children: [
                const TextSpan(text: '"Your spine has surrendered before your career did. '),
                TextSpan(
                  text: 'Pathetic.',
                  style: AppTypography.monoBody.copyWith(
                    color: AppColors.nuclearWarning,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                const TextSpan(text: '"'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButton() {
    return Column(
      children: [
        Stack(
          children: [
            // 阴影装饰
            Transform.translate(
              offset: const Offset(4, 4),
              child: Container(
                height: 64,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.warningOrange,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // 主按钮层
            Container(
              height: 64,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.nuclearWarning,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: Colors.white.withOpacity(0.2), width: 2),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.power_settings_new, color: Colors.white),
                      const SizedBox(width: 12),
                      Text(
                        'RE-ACTIVATE SURVIVAL GEAR',
                        style: AppTypography.monoButton.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'PENALTY_CODE: XU_MING_V1.1 // HARD_RESET_REQUIRED',
          style: AppTypography.monoDecorative.copyWith(
            color: AppColors.nuclearWarning.withOpacity(0.5),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

/// 页面专用的惩罚统计卡片
class _PunishmentStatCard extends StatelessWidget {
  const _PunishmentStatCard({
    required this.label,
    required this.value,
    required this.subLabel,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final String subLabel;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 1, width: double.infinity, color: color.withOpacity(0.2)),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTypography.monoDecorative.copyWith(
              color: color.withOpacity(0.7),
              fontWeight: FontWeight.bold,
              fontSize: 10,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.pixelData.copyWith(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 4),
              Text(
                subLabel,
                style: AppTypography.monoLabel.copyWith(color: color, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
