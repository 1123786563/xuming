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
          // 扫描线背景
          const ScanlineOverlay(opacity: 0.05),
          
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
                        
                        const SizedBox(height: 120), // Extra space for bottom nav
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // 底部导航栏
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNavBar(),
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
      height: 320, // Increased height to match design
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 核心背景光晕
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              color: AppColors.nuclearWarning.withOpacity(0.05),
              shape: BoxShape.circle,
              boxShadow: [
                 BoxShadow(
                  color: AppColors.nuclearWarning.withOpacity(0.1),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),
          
          // 模拟脊柱视觉 (使用 CustomPaint 或更复杂的组合)
          // 这里使用多个 Container 和 Transform 模拟破碎的脊柱段
          ...List.generate(6, (index) {
             final isGlitch = index == 2 || index == 4;
             final offset = isGlitch ? const Offset(5, 0) : Offset.zero;
             final color = isGlitch ? AppColors.nuclearWarning : AppColors.nuclearWarning.withOpacity(0.5);
             
             return Positioned(
               top: 60.0 + (index * 35),
               child: Transform.translate(
                 offset: offset,
                 child: Container(
                   width: 60 - (index * 5.0),
                   height: 20,
                   decoration: BoxDecoration(
                     color: Colors.transparent,
                     border: Border.all(
                       color: color,
                       width: 2,
                     ),
                     borderRadius: BorderRadius.circular(4),
                     boxShadow: isGlitch ? [
                       BoxShadow(color: AppColors.nuclearWarning.withOpacity(0.5), blurRadius: 8)
                     ] : [],
                   ),
                   child: Center(
                     child: Container(
                       width: 4, 
                       height: 12, 
                       color: color.withOpacity(0.8)
                     ),
                   ),
                 ),
               ),
             );
          }),

          // Glitch accents (横向扫描线)
          Positioned(
             top: 100,
             left: 80,
             child: Container(
               width: 50,
               height: 2,
               decoration: BoxDecoration(
                 color: AppColors.warningOrange,
                 boxShadow: [BoxShadow(color: AppColors.warningOrange, blurRadius: 5)],
               ),
             ),
          ),
          Positioned(
             bottom: 120,
             right: 90,
             child: Container(
               width: 80,
               height: 1,
               decoration: BoxDecoration(
                 color: AppColors.nuclearWarning,
                 boxShadow: [BoxShadow(color: AppColors.nuclearWarning, blurRadius: 5)],
               ),
             ),
          ),
          
          // 漂浮标签
          Positioned(
            top: 20,
            right: 40,
            child: Transform.rotate(
              angle: 0.05,
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
              angle: -0.03,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.warningOrange),
                ),
                child: Text(
                  'STRUCTURAL_INTEGRITY_0%',
                  style: AppTypography.monoDecorative.copyWith(
                    color: AppColors.warningOrange,
                    fontSize: 10, // Slightly larger
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
            glitchEffect: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _PunishmentStatCard(
            label: 'VITAL_SIGNS',
            value: 'FAILING',
            subLabel: 'CRITICAL',
            icon: Icons.emergency_share, // emergency icon
            color: AppColors.warningOrange,
            glitchEffect: true,
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
                height: 1.2,
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
                  onTap: () {
                    // 惩罚重置逻辑：恢复至 20 HP，扣除所有金币作为罚金
                    final notifier = ref.read(userStateProvider.notifier);
                    notifier.setInitialHp(hp: 20, sittingHours: 0, painLevel: 0, selectedPosture: 0);
                    // notifier.spendCoins(userState.coins); // Optional: clear coins
                    context.go(AppRoutes.dashboard);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.power_settings_new, color: Colors.white),
                      const SizedBox(width: 12),
                      Text(
                        'Re-activate Survival Gear', // Mixed Case as in design
                        style: AppTypography.monoButton.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                          color: Colors.white,
                        ),
                        ),

                      // Force Upper if needed
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

  Widget _buildBottomNavBar() {
    return Container(
      height: 80, // slightly taller to accommodate floating action button illusion
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.void_.withOpacity(0.9),
        border: Border(
          top: BorderSide(color: AppColors.nuclearWarning.withOpacity(0.2)),
        ),
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
           // Icons are purely visual as per design
           _buildNavIcon(Icons.grid_view, false),
           _buildNavIcon(Icons.analytics_outlined, true), // Active-ish
           
           // Central FAB illusion
           Container(
             width: 48,
             height: 48,
             decoration: BoxDecoration(
               color: AppColors.nuclearWarning,
               shape: BoxShape.circle,
               border: Border.all(color: AppColors.void_, width: 4),
               boxShadow: [
                 BoxShadow(color: AppColors.nuclearWarning.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))
               ],
             ),
             child: const Icon(Icons.bolt, color: Colors.white),
           ),

           _buildNavIcon(Icons.notifications_none, false),
           _buildNavIcon(Icons.person_outline, false),
        ],
      ),
    );
  }
  
  Widget _buildNavIcon(IconData icon, bool isActive) {
     return Icon(
       icon,
       color: isActive ? AppColors.nuclearWarning : AppColors.nuclearWarning.withOpacity(0.4),
       size: 28,
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
    this.glitchEffect = false,
  });

  final String label;
  final String value;
  final String subLabel;
  final IconData icon;
  final Color color;
  final bool glitchEffect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Stack(
         children: [
           if (glitchEffect)
             Positioned(
               top: 0, left: 0, right: 0, height: 2,
               child: Container(color: color.withOpacity(0.3)),
             ),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
         ],
      ),
    );
  }
}

