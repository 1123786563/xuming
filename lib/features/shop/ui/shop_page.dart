import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/user_state_provider.dart';
import '../../../shared/widgets/glitch_text.dart';
import '../../../shared/widgets/scanline_overlay.dart';

/// 续命商店 - 资源解锁页
/// 
/// 赛博朋克风格的商店界面，展示可解锁的资源和任务
class ShopPage extends ConsumerWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStateAsync = ref.watch(userStateNotifierProvider);
    final userState = userStateAsync.valueOrNull ?? const UserState();
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // 网格背景
          _buildCyberGridBackground(),
          
          // 主内容
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBalanceCard(userState.coins),
                        const SizedBox(height: 24),
                        _buildResourceMarketSection(ref, userState),
                        const SizedBox(height: 24),
                        _buildMissionTerminalSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // 底部导航
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNav(context),
          ),
          
          // 装饰元素
          _buildDecorativeElements(),
          
          // 扫描线效果
          const ScanlineOverlay(),
        ],
      ),
    );
  }

  /// 赛博网格背景
  Widget _buildCyberGridBackground() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _CyberGridPainter(),
      ),
    );
  }

  /// 顶部导航栏
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      decoration: BoxDecoration(
        color: AppColors.void_.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(color: AppColors.lifeSignal.withOpacity(0.2)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context.go(AppRoutes.dashboard),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.lifeSignal,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlitchText(
                    text: '续命商店',
                    style: AppTypography.pixelData.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    glitchIntensity: 0.8,
                  ),
                  Text(
                    'LIFE_SUPPORT_v4.02',
                    style: AppTypography.monoDecorative.copyWith(
                      fontSize: 10,
                      color: AppColors.lifeSignal.withOpacity(0.6),
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Transaction: SECURE',
                    style: AppTypography.monoDecorative.copyWith(
                      fontSize: 10,
                      color: AppColors.lifeSignal.withOpacity(0.4),
                    ),
                  ),
                  Text(
                    'Sync: ACTIVE',
                    style: AppTypography.monoDecorative.copyWith(
                      fontSize: 10,
                      color: AppColors.lifeSignal.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.lifeSignal.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.qr_code_scanner,
                  color: AppColors.lifeSignal,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 余额卡片
  Widget _buildBalanceCard(int balance) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // 发光效果
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lifeSignal.withOpacity(0.15),
                    blurRadius: 20,
                    spreadRadius: -5,
                  ),
                ],
              ),
            ),
          ),
          // 卡片内容
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              border: Border.all(color: AppColors.lifeSignal.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lifeSignal.withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current Balance',
                      style: AppTypography.monoDecorative.copyWith(
                        fontSize: 10,
                        color: AppColors.lifeSignal.withOpacity(0.7),
                        letterSpacing: 2.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.lifeSignal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'BIOS_UPGRADE_READY',
                        style: AppTypography.monoDecorative.copyWith(
                          fontSize: 10,
                          color: AppColors.lifeSignal,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      balance.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                      style: AppTypography.pixelHP.copyWith(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '续命币',
                      style: AppTypography.pixelData.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lifeSignal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // 进度条
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.lifeSignal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: constraints.maxWidth * 0.67,
                          decoration: BoxDecoration(
                            color: AppColors.lifeSignal,
                            borderRadius: BorderRadius.circular(2),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.lifeSignal,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 资源市场区块头
  Widget _buildResourceMarketSection(WidgetRef ref, UserState userState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.lifeSignal,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lifeSignal.withOpacity(0.5),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'RESOURCE_MARKET',
                    style: AppTypography.monoBody.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Text(
                'Filtering: ALL_DEPT',
                style: AppTypography.monoDecorative.copyWith(
                  fontSize: 10,
                  color: AppColors.lifeSignal.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildResourceGrid(ref, userState),
      ],
    );
  }

  /// 资源网格
  Widget _buildResourceGrid(WidgetRef ref, UserState userState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
        children: [
          _buildResourceCard(
            ref: ref,
            owned: userState.ownedIds.contains('SPINE_ALIGN'),
            scenarioId: 'SPINE_ALIGN',
            title: '脊椎螺旋对齐',
            imageColor: AppColors.lifeSignal,
          ),
          _buildResourceCard(
            ref: ref,
            owned: userState.ownedIds.contains('NECK_STRETCH'),
            scenarioId: 'NECK_STRETCH',
            title: '颈椎深度拉伸',
            price: 1200,
            imageColor: AppColors.bioUpgrade,
          ),
          _buildResourceCard(
            ref: ref,
            owned: userState.ownedIds.contains('WRIST_FLUSH'),
            scenarioId: 'WRIST_FLUSH',
            title: '掌骨压力排空',
            price: 500,
            imageColor: AppColors.lifeSignal,
          ),
        ],
      ),
    );
  }

  /// 资源卡片 (Variant)
  Widget _buildResourceCard({
    required WidgetRef ref,
    required bool owned,
    required String scenarioId,
    required String title,
    int? price,
    required Color imageColor,
  }) {
    final isPremium = price != null && price > 1000;
    final isOwned = owned;
    final borderColor = isPremium 
        ? AppColors.bioUpgrade.withOpacity(0.5) 
        : AppColors.lifeSignal.withOpacity(isOwned ? 0.5 : 0.3);
    
    return Container(
      child: InkWell(
        onTap: isOwned ? null : () {
          if (price != null) {
            final success = ref.read(userStateNotifierProvider.notifier).spendCoins(price, unlockId: scenarioId);
            if (!success) {
              // TODO: 显示额度不足提示
            }
          }
        },
        child: Stack(
        children: [
          // 背景图片占位（使用渐变模拟）
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    imageColor.withOpacity(isPremium ? 0.1 : 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          // 灰度滤镜（锁定状态）
          if (isPremium)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          
          // 渐变遮罩
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.4, 1.0],
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),
          
          // 已拥有标签
          if (isOwned)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.lifeSignal,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  'OWNED',
                  style: AppTypography.monoDecorative.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          
          // 锁定图标
          if (isPremium)
            Center(
              child: Icon(
                Icons.lock_outline,
                color: AppColors.bioUpgrade.withOpacity(0.5),
                size: 40,
              ),
            ),
          
          // 底部信息
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scenarioId,
                  style: AppTypography.monoDecorative.copyWith(
                    fontSize: 10,
                    color: isPremium 
                        ? AppColors.bioUpgrade 
                        : (isOwned ? Colors.white.withOpacity(0.6) : AppColors.lifeSignal),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: AppTypography.monoBody.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (price != null) ...[
                  const SizedBox(height: 8),
                  _buildPriceButton(price, isPremium),
                ],
              ],
            ),
          ),
        ],
      ),
     ),
    );
  }

  /// 价格按钮
  Widget _buildPriceButton(int price, bool isPremium) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isPremium ? AppColors.bioUpgrade : Colors.transparent,
        border: isPremium 
            ? null 
            : Border.all(color: AppColors.lifeSignal.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.storage,
            color: isPremium ? Colors.white : AppColors.lifeSignal,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            '$price COINS',
            style: AppTypography.monoDecorative.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isPremium ? Colors.white : AppColors.lifeSignal,
            ),
          ),
        ],
      ),
    );
  }

  /// 任务终端区块
  Widget _buildMissionTerminalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.lifeSignal),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'MISSION_TERMINAL',
                style: AppTypography.monoBody.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildMissionList(),
      ],
    );
  }

  /// 任务列表
  Widget _buildMissionList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildMissionItem(
            type: 'DAILY',
            title: '60min Sitting Sync',
            progress: 0.75,
            progressLabel: '45/60m',
            reward: 50,
            isActive: true,
          ),
          const SizedBox(height: 12),
          _buildMissionItem(
            type: 'ONCE',
            title: 'Deep Breath Routine',
            subtitle: 'Complete 3 sets of box breathing',
            reward: 30,
            isActive: false,
          ),
        ],
      ),
    );
  }

  /// 任务项
  Widget _buildMissionItem({
    required String type,
    required String title,
    String? subtitle,
    double? progress,
    String? progressLabel,
    required int reward,
    required bool isActive,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          left: BorderSide(
            color: isActive 
                ? AppColors.lifeSignal 
                : AppColors.lifeSignal.withOpacity(0.3),
            width: 2,
          ),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
      ),
      child: Opacity(
        opacity: isActive ? 1.0 : 0.6,
        child: Row(
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
                          color: isActive 
                              ? AppColors.lifeSignal.withOpacity(0.1) 
                              : Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          type,
                          style: AppTypography.monoDecorative.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isActive 
                                ? AppColors.lifeSignal 
                                : Colors.white.withOpacity(0.4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: AppTypography.monoBody.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: AppTypography.monoLabel.copyWith(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                  ],
                  if (progress != null) ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: constraints.maxWidth * progress,
                                    decoration: BoxDecoration(
                                      color: AppColors.lifeSignal,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          progressLabel ?? '',
                          style: AppTypography.monoDecorative.copyWith(
                            fontSize: 10,
                            color: AppColors.lifeSignal.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '+$reward',
                  style: AppTypography.monoBody.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lifeSignal,
                  ),
                ),
                Text(
                  'Credits',
                  style: AppTypography.monoDecorative.copyWith(
                    fontSize: 8,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 底部导航栏
  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.void_.withOpacity(0.95),
        border: Border(
          top: BorderSide(color: AppColors.lifeSignal.withOpacity(0.3)),
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(
                    icon: Icons.storefront,
                    label: 'Shop',
                    isActive: true,
                    onTap: () {},
                  ),
                  _buildNavItem(
                    icon: Icons.fitness_center,
                    label: 'Sync',
                    isActive: false,
                    onTap: () => context.go(AppRoutes.exercise),
                  ),
                  _buildCenterButton(context),
                  _buildNavItem(
                    icon: Icons.monitor_heart,
                    label: 'Stats',
                    isActive: false,
                    onTap: () => context.go(AppRoutes.statistics),
                  ),
                  _buildNavItem(
                    icon: Icons.blur_on,
                    label: 'System',
                    isActive: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 导航项
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
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
            label.toUpperCase(),
            style: AppTypography.monoDecorative.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: isActive ? AppColors.lifeSignal : Colors.white.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  /// 中心按钮
  Widget _buildCenterButton(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 发光效果
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.lifeSignal.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          // 按钮
          GestureDetector(
            onTap: () => context.go(AppRoutes.dashboard),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.lifeSignal,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lifeSignal.withOpacity(0.4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                Icons.bolt,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 装饰元素
  Widget _buildDecorativeElements() {
    return Stack(
      children: [
        // 右侧垂直装饰文字
        Positioned(
          top: 100,
          right: 8,
          child: RotatedBox(
            quarterTurns: 1,
            child: Text(
              'SYSTEM_STABLE_LOAD_88%',
              style: AppTypography.monoDecorative.copyWith(
                fontSize: 8,
                color: AppColors.lifeSignal.withOpacity(0.2),
                letterSpacing: 8.0,
              ),
            ),
          ),
        ),
        // 左下角装饰点
        Positioned(
          bottom: 120,
          left: 8,
          child: Column(
            children: [
              Container(
                width: 4,
                height: 4,
                color: AppColors.lifeSignal.withOpacity(0.4),
              ),
              const SizedBox(height: 4),
              Container(
                width: 4,
                height: 4,
                color: AppColors.lifeSignal.withOpacity(0.4),
              ),
              const SizedBox(height: 4),
              Container(
                width: 4,
                height: 16,
                color: AppColors.lifeSignal.withOpacity(0.2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 资源卡片类型
enum ResourceCardType {
  owned,    // 已拥有
  premium,  // 高级/锁定
  normal,   // 普通可购买
}

/// 赛博网格背景绘制器
class _CyberGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.lifeSignal.withOpacity(0.03)
      ..strokeWidth = 1;

    const spacing = 20.0;

    // 绘制垂直线
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // 绘制水平线
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
