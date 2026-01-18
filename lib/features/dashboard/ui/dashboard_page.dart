import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/energy_bar.dart';
import '../../../shared/widgets/cyber_button.dart';
import '../../../shared/widgets/glitch_text.dart';

/// 生存仪表盘主页
/// 
/// 核心监控界面，展示 HP、人体模型热力图
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // 模拟数据
  double _currentHP = 68;
  final int _sittingMinutes = 127;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: SafeArea(
        child: Column(
          children: [
            // 顶部状态栏
            _buildHeader(),
            
            // 中央内容区
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // HP 能量槽
                    _buildHPSection(),
                    
                    const SizedBox(height: 32),
                    
                    // 3D 人体模型占位区
                    _buildBodyModelSection(),
                    
                    const SizedBox(height: 32),
                    
                    // 快速操作按钮
                    _buildActionButtons(),
                    
                    const SizedBox(height: 24),
                    
                    // 毒舌提醒
                    _buildToxicMessage(),
                  ],
                ),
              ),
            ),
            
            // 底部导航
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SYS_STATUS: ACTIVE',
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.lifeSignal,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '久坐时长: ${_sittingMinutes ~/ 60}h ${_sittingMinutes % 60}m',
                style: AppTypography.monoLabel.copyWith(
                  color: _sittingMinutes > 60 
                      ? AppColors.cautionYellow 
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              // TODO: 打开设置页
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lifeSignal.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.settings_outlined,
                color: AppColors.lifeSignal,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHPSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _currentHP < 30 
              ? AppColors.nuclearWarning.withOpacity(0.5)
              : AppColors.lifeSignal.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '生命值监控',
                style: AppTypography.monoLabel,
              ),
              GlitchText(
                text: '${_currentHP.toInt()}%',
                style: AppTypography.pixelHP.copyWith(
                  color: _currentHP < 30 
                      ? AppColors.nuclearWarning
                      : AppColors.lifeSignal,
                ),
                isActive: _currentHP < 30,
                glitchIntensity: 2.0,
              ),
            ],
          ),
          const SizedBox(height: 16),
          EnergyBar(
            value: _currentHP,
            maxValue: 100,
            segments: 20,
            showLabel: false,
          ),
        ],
      ),
    );
  }

  Widget _buildBodyModelSection() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.divider),
      ),
      child: Stack(
        children: [
          // 背景网格
          CustomPaint(
            size: const Size(double.infinity, 300),
            painter: _GridPainter(),
          ),
          
          // 占位文字
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.accessibility_new,
                  size: 120,
                  color: AppColors.lifeSignal.withOpacity(0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  '[ 3D 人体热力图 ]',
                  style: AppTypography.monoLabel.copyWith(
                    color: AppColors.textDecorative,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '正在初始化生物扫描模块...',
                  style: AppTypography.monoDecorative,
                ),
              ],
            ),
          ),
          
          // 受损区域标记 (模拟)
          Positioned(
            top: 60,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: _buildDamageIndicator('颈椎', 85),
          ),
          Positioned(
            top: 140,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: _buildDamageIndicator('腰椎', 62),
          ),
        ],
      ),
    );
  }

  Widget _buildDamageIndicator(String label, int pressure) {
    final color = pressure > 70 ? AppColors.nuclearWarning : AppColors.cautionYellow;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color,
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$label: $pressure%',
            style: AppTypography.monoDecorative.copyWith(
              color: color,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: CyberButton(
            text: '紧急抢修',
            onPressed: () {
              // TODO: 跳转到动作选择页
            },
            color: AppColors.nuclearWarning,
            height: 48,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CyberButton(
            text: '潜行模式',
            onPressed: () {
              // TODO: 开启潜行协议
            },
            isOutlined: true,
            height: 48,
          ),
        ),
      ],
    );
  }

  Widget _buildToxicMessage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.nuclearWarning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.nuclearWarning.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: AppColors.nuclearWarning,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '你的脊椎正在以每小时 0.3mm 的速度向轮椅靠拢。',
              style: AppTypography.monoToxic.copyWith(
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          top: BorderSide(color: AppColors.divider),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.dashboard, '仪表盘', true),
          _buildNavItem(Icons.fitness_center, '修复', false),
          _buildNavItem(Icons.store, '商店', false),
          _buildNavItem(Icons.emoji_events, '成就', false),
          _buildNavItem(Icons.person, '档案', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        // TODO: 导航
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.lifeSignal : AppColors.textDecorative,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.monoDecorative.copyWith(
              fontSize: 10,
              color: isActive ? AppColors.lifeSignal : AppColors.textDecorative,
            ),
          ),
        ],
      ),
    );
  }
}

/// 背景网格绘制器
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.lifeSignal.withOpacity(0.05)
      ..strokeWidth = 1;

    const gridSize = 20.0;
    
    // 垂直线
    for (var x = 0.0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    
    // 水平线
    for (var y = 0.0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
