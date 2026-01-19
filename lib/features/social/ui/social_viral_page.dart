import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../../shared/widgets/cyber_button.dart';
import '../../../shared/providers/user_state_provider.dart';

class SocialViralPage extends ConsumerStatefulWidget {
  const SocialViralPage({super.key});

  @override
  ConsumerState<SocialViralPage> createState() => _SocialViralPageState();
}

class _SocialViralPageState extends ConsumerState<SocialViralPage> with TickerProviderStateMixin {
  int _selectedTargetIndex = 1; // Sarah Chen by default
  int _selectedWarheadIndex = 2; // Level 3: Reality Check by default
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // Main Content
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Custom AppBar
              SliverToBoxAdapter(
                child: _buildHeader(context),
              ),
              
              // Status Card
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                sliver: SliverToBoxAdapter(
                  child: _buildHeadlineStatus(),
                ),
              ),

              // Colleague HP Status Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 24, bottom: 8),
                  child: Text(
                    'Colleague_HP_Status',
                    style: AppTypography.monoLabel.copyWith(
                      color: AppColors.lifeSignal.withOpacity(0.7),
                      letterSpacing: 4,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ZpixFont',
                    ),
                  ),
                ),
              ),

              // Colleague List
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildColleagueItem(
                      index: 0,
                      name: '李伟 (Front-end)',
                      avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC3Dljm1KaW1WLbcPITlfBTV4EKdyJXx8VgRSDjuujIMbXzUew3zs51Ej4tz5Z_Q10aSrL9phd6-mqM5daAEJ9-bXTqPVKSC3NxCsj1AVHuSNLidGwLG4IgrKXjkSlGF4CwahkcFhHK9Bc49GOKUfDowsD78-39E_KMjpO83ieUJsH43CADZ7f5aR8dNq6ITK45Ry1Aomjboig3KcoCYOWaJI2piy-1e2Kwsq9Aj0ByNmtvcmtpehQSW8bZte5pgnxjzrKBCUC_RvM',
                      hp: 25,
                      status: 'CRITICAL',
                      statusDesc: 'SPINE_DEVIATION_DETECTED',
                      dist: '12m',
                      statusColor: AppColors.nuclearWarning,
                    ),
                    const SizedBox(height: 4),
                    _buildColleagueItem(
                      index: 1,
                      name: 'Sarah Chen (Product)',
                      avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCmXkvkI_CnHci18PFHy3k-fNDKlQTpkYyEI5Pzg-JEDgNXGJd5L2rE-sXj7qBB2MLv5_YkBf0XH-LNAzIwKcJyE-KCH993-w_crWVhCdOAIGg7cng2764GqoJc0EHQ88VpGOtQOcYbA54XCtHoEzlTWRAzHoGjAGJs5JU0V1r4lNyK5yHxq_S-5nSjc6tHyrCZUuMJru0RVkOy5RSfoFNbIfn9NVjrctAGCK6lRWQifj4GYjtEJeYAWHHVli_Wpt-jVMnFohwhEAQ',
                      hp: 51,
                      status: 'WARNING',
                      statusDesc: 'LOW_OXYGEN_LEVELS',
                      dist: 'TARGET_LOCKED',
                      statusColor: AppColors.cautionYellow,
                    ),
                    const SizedBox(height: 4),
                    _buildColleagueItem(
                      index: 2,
                      name: '张强 (Backend)',
                      avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD05A2PjED01xvv-ywpjpnt-rWMHG5uDYdG3S7wtun_XS3n6N6X-CUKWsn1UkO9Y6VgK65q6c9oX7Xl4ANn5n31SibecGjXVjnXPNEYufvcVFp6wQoi7sufJeekM_enRw2vRB0pRS0JMlIb82Av5mdltBRRuWIIkrNPCe5W0uIOtq0FFlN1wFmBNxKNk-Z7s3sX1Qyt3wHEHn2ZZivG9CRnwCjstyS9rgljib7G8Je0HeDlUA7TzVMtMI7SYYLpH6qN9Mwir-p4NBs',
                      hp: 88,
                      status: 'NORMAL',
                      statusDesc: 'OPTIMAL_STAND_TIME',
                      dist: '24m',
                      statusColor: AppColors.lifeSignal,
                      opacity: 0.6,
                    ),
                  ]),
                ),
              ),

              // Warhead Selection Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 32, bottom: 8),
                  child: Text(
                    'Select_Warhead_Type',
                    style: AppTypography.monoLabel.copyWith(
                      color: AppColors.lifeSignal.withOpacity(0.7),
                      letterSpacing: 4,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ZpixFont',
                    ),
                  ),
                ),
              ),

              // Warhead Selection List
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildWarheadItem(
                      index: 0,
                      title: 'Level 1: Gentle Poke',
                      subtitle: 'Standard notification vibration.',
                      icon: Icons.notifications_active,
                      color: AppColors.lifeSignal,
                    ),
                    const SizedBox(height: 8),
                    _buildWarheadItem(
                      index: 1,
                      title: 'Level 2: Sarcastic Jab',
                      subtitle: '"The coffee machine is lonely. Go visit it."',
                      icon: Icons.warning_amber_rounded,
                      color: AppColors.cautionYellow,
                    ),
                    const SizedBox(height: 8),
                    _buildWarheadItem(
                      index: 2,
                      title: 'Level 3: Reality Check',
                      subtitle: '"Your spine is a question mark, and so is your future. MOVE!"',
                      icon: Icons.dangerous,
                      color: AppColors.lifeSignal,
                      isFatal: true,
                    ),
                    const SizedBox(height: 160), // Bottom padding for sticky footer
                  ]),
                ),
              ),
            ],
          ),

          // CRT Overlay
          const ScanlineOverlay(opacity: 0.15),

          // Bottom Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomAction(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.void_.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(color: AppColors.lifeSignal.withOpacity(0.2)),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.lifeSignal),
              onPressed: () => context.pop(),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.lifeSignal.withOpacity(0.1),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '投放生物能量弹',
                style: AppTypography.pixelHeadline.copyWith(
                  fontSize: 18,
                  color: AppColors.lifeSignal,
                  shadows: [
                    const Shadow(
                      blurRadius: 10,
                      color: AppColors.lifeSignalGlow,
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppColors.lifeSignal.withOpacity(_pulseController.value * 0.7 + 0.3),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lifeSignal.withOpacity(_pulseController.value * 0.5),
                              blurRadius: 4,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'SYSTEM_READY // ENERGIZE_COWORKER',
                    style: AppTypography.monoDecorative.copyWith(
                      color: AppColors.lifeSignal.withOpacity(0.7),
                      fontSize: 8,
                      fontFamily: 'ZpixFont',
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.settings_accessibility, color: AppColors.lifeSignal, size: 20),
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: AppColors.lifeSignal.withOpacity(0.1),
                side: BorderSide(color: AppColors.lifeSignal.withOpacity(0.2)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadlineStatus() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lifeSignal.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lifeSignal.withOpacity(0.3)),
      ),
      child: Stack(
        children: [
          const Positioned(
            right: 0,
            top: 0,
            child: Opacity(
              opacity: 0.2,
              child: Icon(Icons.radar, color: AppColors.lifeSignal, size: 36),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'TARGET_LOCKED: SCANNING_OFFICE_NETWORK',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lifeSignal,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'ENCRYPTED_SIGNAL_STRENGTH: 98% [STABLE]',
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.lifeSignal.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColleagueItem({
    required int index,
    required String name,
    required String avatarUrl,
    required int hp,
    required String status,
    required String statusDesc,
    required String dist,
    required Color statusColor,
    double opacity = 1.0,
  }) {
    final isSelected = _selectedTargetIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedTargetIndex = index),
      child: Opacity(
        opacity: opacity,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.lifeSignal.withOpacity(0.15) : AppColors.lifeSignal.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.lifeSignal : AppColors.lifeSignal.withOpacity(0.1),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected ? [
              BoxShadow(
                color: AppColors.lifeSignal.withOpacity(0.2),
                blurRadius: 15,
              )
            ] : null,
          ),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: statusColor.withOpacity(0.5), width: 2),
                      image: DecorationImage(
                        image: NetworkImage(avatarUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (status != 'NORMAL')
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        status,
                        style: AppTypography.monoLabel.copyWith(
                          fontSize: 8,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ZpixFont',
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'HP: $statusDesc',
                      style: GoogleFonts.jetBrainsMono(
                        color: statusColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: hp / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: [
                                BoxShadow(
                                  color: statusColor.withOpacity(0.8),
                                  blurRadius: 4,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$hp',
                        style: GoogleFonts.jetBrainsMono(
                          color: statusColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dist,
                    style: AppTypography.monoDecorative.copyWith(
                      color: isSelected ? AppColors.lifeSignal : AppColors.lifeSignal.withOpacity(0.4),
                      fontSize: 9,
                      fontFamily: 'ZpixFont',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarheadItem({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    bool isFatal = false,
  }) {
    final isSelected = _selectedWarheadIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedWarheadIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(isSelected ? 16 : 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lifeSignal.withOpacity(0.15) : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.lifeSignal : Colors.white.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: AppColors.lifeSignal.withOpacity(0.1),
              blurRadius: 20,
            )
          ] : null,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? color : color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                boxShadow: isSelected ? [
                  BoxShadow(color: color.withOpacity(0.6), blurRadius: 15)
                ] : null,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.black : color,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isFatal) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: AppColors.lifeSignal,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: const Text(
                            'FATAL',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ZpixFont',
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: isSelected ? AppColors.lifeSignal.withOpacity(0.7) : Colors.white54,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            AppColors.void_.withOpacity(0.95),
            AppColors.void_,
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              // 触发投放逻辑
              ref.read(userStateProvider.notifier).addCoins(50);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.lifeSignal,
                  content: Text(
                    'BIOMASS_BOMB_DEPLOYED: +50 CREDITS',
                    style: AppTypography.monoLabel.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lifeSignal,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 64),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              elevation: 20,
              shadowColor: AppColors.lifeSignal.withOpacity(0.5),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.rocket_launch, weight: 900),
                SizedBox(width: 8),
                Text(
                  'DEPLOY_BOMB',
                  style: TextStyle(
                    fontFamily: 'ZpixFont',
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 16,
            child: _MarqueeText(),
          ),
        ],
      ),
    );
  }
}

class _MarqueeText extends StatefulWidget {
  @override
  State<_MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<_MarqueeText> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startAnimation());
  }

  void _startAnimation() async {
    while (mounted) {
      if (!_scrollController.hasClients) {
        await Future.delayed(const Duration(milliseconds: 100));
        continue;
      }
      
      final maxExtent = _scrollController.position.maxScrollExtent;
      if (maxExtent > 0) {
        await _scrollController.animateTo(
          maxExtent,
          duration: const Duration(seconds: 15),
          curve: Curves.linear,
        );
        if (!mounted) return;
        _scrollController.jumpTo(0);
      } else {
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTypography.monoDecorative.copyWith(
      color: AppColors.lifeSignal.withOpacity(0.5),
      fontSize: 10,
      fontFamily: 'ZpixFont',
    );

    return ListView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildMarqueeItem('CALCULATING_POSTURE_DEVIATION...', textStyle),
        _buildMarqueeItem('BYPASSING_OFFICE_FIREWALL...', textStyle),
        _buildMarqueeItem('TARGETing_HUMAN_RESOURCES_WIFI...', textStyle),
        _buildMarqueeItem('SENDING_OXYGEN_REMINDER...', textStyle),
        _buildMarqueeItem('CALCULATING_POSTURE_DEVIATION...', textStyle),
        _buildMarqueeItem('SCANNING_BIOMETRIC_DATA...', textStyle),
        _buildMarqueeItem('OPTIMIZING_NEURAL_INTERFACE...', textStyle),
      ],
    );
  }

  Widget _buildMarqueeItem(String text, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Text(text, style: style),
    );
  }
}
