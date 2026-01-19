import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/grid_background.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import 'widgets/avatar_ring.dart';
import 'widgets/cyber_toggle.dart';
import 'widgets/logout_button.dart';
import 'widgets/profile_menu_item.dart';
import 'widgets/toxic_level_slider.dart';

/// 系统档案 - 个人设置页
/// 
/// 赛博朋克风格的个人档案和设置页面
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // 设置状态
  int _toxicLevel = 3;
  bool _bossMode = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 赛博风格背景 (网格 + 渐变)
          const Positioned.fill(
            child: GridBackground(
              gridSize: 40,
              lineOpacity: 0.1,
            ),
          ),
          
          // 扫描线效果背景
          const ScanlineOverlay(opacity: 0.15),
          
          // 主内容
          SafeArea(
            child: Column(
              children: [
                // 顶部导航栏
                _buildAppBar(context),
                
                // 可滚动内容
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 身份模块
                        _buildIdentitySection(),
                        
                        // 分割线
                        _buildDivider(),
                        
                        // 配置模块标题
                        _buildSectionTitle('CONFIGURATION_MODULES'),
                        
                        const SizedBox(height: 16),
                        
                        // 配置项列表
                        _buildMenuItems(),
                        
                        const SizedBox(height: 24),
                        
                        // 退出按钮
                        LogoutButton(
                          onPressed: _handleLogout,
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // 底部版权信息
                        _buildFooter(),
                        
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // 四角装饰
          ..._buildCornerDecorations(),
        ],
      ),
    );
  }


  /// 顶部导航栏
  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.void_.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(
            color: AppColors.textDecorative.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 返回按钮
          GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.lifeSignal,
              size: 24,
            ),
          ),
          
          // 标题
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'SYSTEM_PROFILE ',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: AppColors.textPrimary.withOpacity(0.8),
                ),
              ),
              const Text(
                '//',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lifeSignal,
                ),
              ),
              Text(
                ' V.2.0.77',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: AppColors.textPrimary.withOpacity(0.8),
                ),
              ),
            ],
          ),
          
          // 设置按钮
          GestureDetector(
            onTap: () {
              // TODO: 打开设置
            },
            child: const Icon(
              Icons.settings_suggest,
              color: AppColors.lifeSignal,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  /// 身份模块
  Widget _buildIdentitySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          // 头像光环
          const AvatarRing(
            size: 160,
            isOnline: true,
            // imageUrl 可以设置用户头像
          ),
          
          const SizedBox(height: 24),
          
          // 用户名
          const Text(
            'OPERATIVE_01',
            style: TextStyle(
              fontFamily: 'ZpixFont',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // UID 和同步状态
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'UID: 0x82BF',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 12,
                  letterSpacing: 2,
                  color: AppColors.lifeSignal.withOpacity(0.8),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.lifeSignal,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lifeSignal.withOpacity(0.5),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'SYNCED',
                style: TextStyle(
                  fontFamily: 'ZpixFont',
                  fontSize: 12,
                  letterSpacing: 2,
                  color: AppColors.lifeSignal.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 分割线
  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.transparent,
            AppColors.lifeSignal.withOpacity(0.5),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  /// 模块标题
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'ZpixFont',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
          color: AppColors.lifeSignal.withOpacity(0.7),
        ),
      ),
    );
  }

  /// 配置项列表
  Widget _buildMenuItems() {
    return Column(
      children: [
        // 生物识别
        ProfileMenuItem(
          icon: Icons.fingerprint,
          title: '生物识别',
          subtitle: 'BIO_METRICS',
          description: 'DATA: 175CM / 70KG / MALE',
          statusTag: 'SECURED',
          statusTagColor: AppColors.lifeSignal.withOpacity(0.6),
          onTap: () {
            // TODO: 跳转生物识别设置
          },
        ),
        
        const SizedBox(height: 8),
        
        // 毒舌强度
        ProfileMenuItem(
          icon: Icons.psychology_alt,
          title: '毒舌强度',
          subtitle: 'TOXIC_LVL',
          statusTag: 'EDITABLE',
          statusTagColor: AppColors.cautionYellow,
          iconColor: AppColors.cautionYellow,
          type: ProfileMenuItemType.custom,
          trailing: ToxicLevelSlider(
            level: _toxicLevel,
            onChanged: (level) {
              setState(() {
                _toxicLevel = level;
              });
            },
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Boss Mode
        ProfileMenuItem(
          icon: Icons.visibility_off,
          title: 'Boss Mode',
          subtitle: 'STEALTH',
          description: 'AUTO_MINIMIZE: ${_bossMode ? "ACTIVE" : "INACTIVE"}',
          type: ProfileMenuItemType.toggle,
          trailing: CyberToggle(
            value: _bossMode,
            onChanged: (value) {
              setState(() {
                _bossMode = value;
              });
            },
          ),
        ),
        
        const SizedBox(height: 8),
        
        // 通知终端
        ProfileMenuItem(
          icon: Icons.campaign,
          title: '通知终端',
          subtitle: 'UPLINK',
          description: 'PUSH_PROTOCOL: ENABLED',
          statusTag: 'ON',
          statusTagColor: AppColors.lifeSignal.withOpacity(0.6),
          onTap: () {
            // TODO: 跳转通知设置
          },
        ),
        
        const SizedBox(height: 8),

        // 勋章墙
        ProfileMenuItem(
          icon: Icons.military_tech,
          title: '生存成就',
          subtitle: 'MEDALS',
          description: 'LEVEL: SENIOR TECH',
          statusTag: 'NEW',
          statusTagColor: AppColors.nuclearWarning,
          onTap: () {
            context.push('/medal-wall');
          },
        ),
        
        const SizedBox(height: 8),
        
        // 数据导出
        ProfileMenuItem(
          icon: Icons.storage,
          title: '数据导出',
          subtitle: 'DUMP_LOGS',
          description: 'LAST_BACKUP: 4HR AGO',
          iconColor: AppColors.textSecondary.withOpacity(0.5),
          isEnabled: true,
          trailing: Icon(
            Icons.download,
            color: AppColors.textSecondary.withOpacity(0.5),
            size: 24,
          ),
          onTap: () {
            // TODO: 导出数据
          },
        ),
      ],
    );
  }

  /// 退出登录
  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: AppColors.nuclearWarning),
        ),
        title: const Text(
          'SYSTEM SHUTDOWN',
          style: TextStyle(
            fontFamily: 'ZpixFont',
            fontSize: 18,
            color: AppColors.nuclearWarning,
          ),
        ),
        content: const Text(
          '确定要断开生命信号连接吗？',
          style: TextStyle(
            fontFamily: 'ZpixFont',
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'CANCEL',
              style: TextStyle(
                fontFamily: 'ZpixFont',
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/login');
            },
            child: const Text(
              'CONFIRM',
              style: TextStyle(
                fontFamily: 'ZpixFont',
                color: AppColors.nuclearWarning,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 底部版权信息
  Widget _buildFooter() {
    return Center(
      child: Column(
        children: [
          Text(
            'LIFE_EXTENSION_PROTOCOL // BUILD 8921.A',
            style: TextStyle(
              fontFamily: 'ZpixFont',
              fontSize: 10,
              letterSpacing: 2,
              color: AppColors.textDecorative,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'COPYRIGHT © 2024 CYBER_HEALTH_CORP',
            style: TextStyle(
              fontFamily: 'ZpixFont',
              fontSize: 10,
              letterSpacing: 2,
              color: AppColors.textDecorative,
            ),
          ),
        ],
      ),
    );
  }

  /// 四角装饰
  List<Widget> _buildCornerDecorations() {
    return [
      // 左上角
      Positioned(
        top: 16,
        left: 16,
        child: _buildCornerDecor(topLeft: true),
      ),
      // 右上角
      Positioned(
        top: 16,
        right: 16,
        child: _buildCornerDecor(topRight: true),
      ),
      // 左下角
      Positioned(
        bottom: 16,
        left: 16,
        child: _buildCornerDecorWithLabel(),
      ),
    ];
  }

  Widget _buildCornerDecor({
    bool topLeft = false,
    bool topRight = false,
  }) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        children: [
          if (topLeft) ...[
            Positioned(
              top: 0,
              left: 0,
              child: Container(width: 16, height: 2, color: AppColors.lifeSignal.withOpacity(0.5)),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(width: 2, height: 16, color: AppColors.lifeSignal.withOpacity(0.5)),
            ),
          ],
          if (topRight) ...[
            Positioned(
              top: 0,
              right: 0,
              child: Container(width: 16, height: 2, color: AppColors.lifeSignal.withOpacity(0.5)),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(width: 2, height: 16, color: AppColors.lifeSignal.withOpacity(0.5)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCornerDecorWithLabel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 48,
          height: 48,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(width: 16, height: 2, color: AppColors.lifeSignal.withOpacity(0.5)),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(width: 2, height: 16, color: AppColors.lifeSignal.withOpacity(0.5)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'SYS_READY',
          style: TextStyle(
            fontFamily: 'ZpixFont',
            fontSize: 10,
            letterSpacing: 2,
            color: AppColors.lifeSignal.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}
