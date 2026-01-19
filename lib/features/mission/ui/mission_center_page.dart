import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../../core/router/app_router.dart';

class MissionCenterPage extends StatelessWidget {
  const MissionCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // Background content
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                _buildTechnicalStats(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(),
                        const SizedBox(height: 16),
                        _buildMissionList(context),
                        const SizedBox(height: 32),
                        _buildToxicFooter(),
                        const SizedBox(height: 80), // Bottom padding for nav bar
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Fixed Bottom Navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNav(context),
          ),

          // Scanline Overlay
          const ScanlineOverlay(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: AppColors.void_.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(color: AppColors.lifeSignal.withOpacity(0.2)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MISSION CONTROL',
                style: AppTypography.monoDecorative.copyWith(
                  fontSize: 10,
                  color: AppColors.lifeSignal,
                  letterSpacing: 2.0,
                ),
              ),
              Row(
                children: [
                   Text(
                    '任务指令集',
                    style: AppTypography.pixelData.copyWith(
                      fontSize: 20,
                      height: 1.2,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.lifeSignal,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'AUTH: SECTOR_7',
                style: AppTypography.monoDecorative.copyWith(
                  fontSize: 10,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              Text(
                'LVL 14',
                style: AppTypography.pixelData.copyWith(
                  fontSize: 16,
                  color: AppColors.lifeSignal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalStats() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cardBackground.withOpacity(0.5),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.sensors,
                      size: 14,
                      color: AppColors.lifeSignal,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SURVIVAL COINS',
                        style: AppTypography.monoDecorative.copyWith(
                          fontSize: 10,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '12,450',
                            style: AppTypography.pixelData.copyWith(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '+250% SYNC',
                            style: AppTypography.monoDecorative.copyWith(
                              fontSize: 10,
                              color: AppColors.lifeSignal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 96,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardBackground.withOpacity(0.5),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'UPTIME',
                  style: AppTypography.monoDecorative.copyWith(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                Text(
                  '08:42:12',
                  style: AppTypography.monoLabel.copyWith(
                    fontSize: 14,
                    color: AppColors.cautionYellow,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ACTIVE_OBJECTIVES',
            style: AppTypography.monoDecorative.copyWith(
              fontSize: 10,
              color: Colors.white.withOpacity(0.4),
              letterSpacing: 2.0,
            ),
          ),
          Text(
            'MISSION_SYNC_ACTIVE',
            style: AppTypography.monoDecorative.copyWith(
              fontSize: 10,
              color: AppColors.lifeSignal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionList(BuildContext context) {
    return Column(
      children: [
        // Repair Mission
        _buildMissionCard(
          type: 'REPAIR',
          id: '0x442A',
          title: '完成 2 次颈椎急救',
          progress: 0.5,
          progressLabel: '1/2',
          reward: '+100 COINS',
          color: AppColors.lifeSignal,
          buttonText: 'CLAIM',
          isButtonDisabled: true,
          glowColor: AppColors.lifeSignal.withOpacity(0.5),
        ),
        const SizedBox(height: 16),

        // Social Mission
        _buildMissionCard(
          type: 'SOCIAL',
          id: '0x918C',
          title: '给 1 位同事投放续命弹',
          progress: 0.0,
          progressLabel: '0/1',
          reward: '+50 COINS',
          color: AppColors.bioUpgrade,
          buttonText: 'CLAIM',
          isButtonDisabled: true,
          glowColor: AppColors.bioUpgrade.withOpacity(0.5),
        ),
        const SizedBox(height: 16),

        // Challenge Mission
        _buildMissionCard(
          type: 'CHALLENGE',
          id: 'CRITICAL',
          title: '连续生存 3 小时无核打击',
          progress: 0.65,
          progressLabel: '65%',
          reward: '+200 COINS',
          color: AppColors.cautionYellow,
          buttonText: 'CLAIM',
          isButtonDisabled: true,
          glowColor: AppColors.cautionYellow.withOpacity(0.5),
          isChallenge: true,
        ),
        const SizedBox(height: 16),

        // Data Mission
        _buildMissionCard(
          type: 'DATA',
          id: 'EXT_SIGNAL',
          title: '查看最新身体补丁',
          progress: -1, // Special case
          progressLabel: '',
          reward: 'REWARD_???',
          color: Colors.white,
          buttonText: 'VIEW',
          isButtonDisabled: false,
          glowColor: Colors.white.withOpacity(0.2),
          customActionWidget: Row(
            children: [
              Icon(Icons.play_circle_outline, size: 16, color: Colors.white.withOpacity(0.4)),
              const SizedBox(width: 4),
              Text(
                'External patch required...',
                style: AppTypography.monoLabel.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ],
          ),
          onPressed: () {
            // TODO: Navigate to patch details
          }
        ),
      ],
    );
  }

  Widget _buildMissionCard({
    required String type,
    required String id,
    required String title,
    required double progress,
    required String progressLabel,
    required String reward,
    required Color color,
    required String buttonText,
    required bool isButtonDisabled,
    required Color glowColor,
    bool isChallenge = false,
    Widget? customActionWidget,
    VoidCallback? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
      ),
      child: Stack(
        children: [
           if (isChallenge)
            Positioned(
              top: 0,
              right: 0,
              child: Transform.translate(
                offset: const Offset(24, -24),
                child: Transform.rotate(
                  angle: 0.785, // 45 degrees
                  child: Container(
                    width: 48,
                    height: 48,
                    color: color.withOpacity(0.05),
                  ),
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              type,
                              style: AppTypography.monoDecorative.copyWith(
                                fontSize: 10,
                                color: color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'ID: $id',
                            style: AppTypography.monoDecorative.copyWith(
                              fontSize: 10,
                              color: isChallenge ? color.withOpacity(0.6) : Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        style: AppTypography.monoBody.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (customActionWidget != null)
                        customActionWidget
                      else
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: constraints.maxWidth * progress,
                                        decoration: BoxDecoration(
                                          color: color,
                                          borderRadius: BorderRadius.circular(3),
                                          boxShadow: [
                                            BoxShadow(
                                              color: glowColor,
                                              blurRadius: 8,
                                              spreadRadius: 0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              progressLabel,
                              style: AppTypography.monoDecorative.copyWith(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      reward,
                      style: AppTypography.monoDecorative.copyWith(
                        fontSize: 10,
                        color: isChallenge || type == 'SOCIAL' ? color : (type == 'DATA' ? Colors.white.withOpacity(0.6) : AppColors.lifeSignal),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildMechanicalButton(
                      text: buttonText,
                      onPressed: onPressed,
                      isDisabled: isButtonDisabled,
                      color: color,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMechanicalButton({
    required String text,
    VoidCallback? onPressed,
    required bool isDisabled,
    required Color color,
  }) {
    // Mechanical button style
    final baseColor = isDisabled 
      ? color.withOpacity(0.2) 
      : (text == 'VIEW' ? AppColors.lifeSignal : color.withOpacity(0.2));
    
    final textColor = isDisabled 
      ? color.withOpacity(0.4) 
      : (text == 'VIEW' ? AppColors.void_ : color.withOpacity(0.4));
      
    final borderColor = isDisabled
      ? color.withOpacity(0.3)
      : (text == 'VIEW' ? Colors.transparent : color.withOpacity(0.3));

    return Container(
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
        boxShadow: text == 'VIEW' 
          ? [BoxShadow(color: AppColors.lifeSignal.withOpacity(0.2), blurRadius: 10, spreadRadius: 0)]
          : const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.4),
                offset: Offset(-2, -2),
              ),
               BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.2),
                offset: Offset(2, 2),
              ),
          ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
             child: Text(
               text,
               style: AppTypography.monoDecorative.copyWith(
                 fontSize: 12,
                 color: textColor,
                 fontWeight: FontWeight.bold,
               ),
             ),
          ),
        ),
      ),
    );
  }

  Widget _buildToxicFooter() {
    return Column(
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cautionYellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.cautionYellow,
                  borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, size: 32, color: Colors.black),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      '"Do your tasks or let your spine become a fossil. Your choice."',
                      style: AppTypography.monoLabel.copyWith(
                         color: Colors.black,
                         fontStyle: FontStyle.italic,
                         fontWeight: FontWeight.bold,
                         fontSize: 12,
                         letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(
               'OS_VER_4.02.1',
               style: AppTypography.monoDecorative.copyWith(
                 fontSize: 8,
                 color: Colors.white.withOpacity(0.3),
               ),
             ),
             Text(
               'FOSSIL_PREVENTION_MOD',
               style: AppTypography.monoDecorative.copyWith(
                 fontSize: 8,
                 color: Colors.white.withOpacity(0.3),
               ),
             ),
           ],
        ),
      ],
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.void_,
        border: Border(
           top: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           _buildNavItem(Icons.grid_view, 'MISSIONS', true, () {}),
           _buildNavItem(Icons.monitor_heart, 'VITALITY', false, () {
               context.go(AppRoutes.dashboard);
           }),
           _buildAddButton(),
           _buildNavItem(Icons.group, 'SQUAD', false, () {}),
           _buildNavItem(Icons.settings_suggest, 'AUGMENT', false, () {}),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon, 
            color: isActive ? AppColors.lifeSignal : Colors.white.withOpacity(0.4),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.monoDecorative.copyWith(
              fontSize: 10,
              color: isActive ? AppColors.lifeSignal : Colors.white.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
     return Transform.translate(
       offset: const Offset(0, -24),
       child: Stack(
         alignment: Alignment.center,
         children: [
           Container(
             width: 48,
             height: 48,
             decoration: BoxDecoration(
               color: AppColors.lifeSignal,
               shape: BoxShape.circle,
               boxShadow: [
                 BoxShadow(
                   color: AppColors.lifeSignal.withOpacity(0.4),
                   blurRadius: 10,
                   spreadRadius: 2,
                 ),
               ],
             ),
             child: const Icon(Icons.add, color: AppColors.void_, size: 30),
           ),
         ],
       ),
     );
  }
}
