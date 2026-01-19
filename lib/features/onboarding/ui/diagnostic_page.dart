import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/user_state_provider.dart';
import '../../../shared/widgets/cyber_button.dart';
import '../../../shared/widgets/survival_assessment_dialog.dart';

/// 身体系统初始化诊断页
/// 
/// 收集用户久坐时长和身体状态数据
class DiagnosticPage extends ConsumerStatefulWidget {
  const DiagnosticPage({super.key});

  @override
  ConsumerState<DiagnosticPage> createState() => _DiagnosticPageState();
}

class _DiagnosticPageState extends ConsumerState<DiagnosticPage> {
  double _sittingHours = 8;
  double _painLevel = 3;
  int _selectedPosture = 0;

  final List<Map<String, dynamic>> _postureOptions = [
    {'icon': Icons.chair, 'label': '久坐办公'},
    {'icon': Icons.laptop_mac, 'label': '低头码字'},
    {'icon': Icons.phone_android, 'label': '葛优躺刷机'},
  ];

  void _startDiagnosis() {
    // 1. 计算初始 HP (公式: 100 - 久坐*3 - 疼痛*10)
    final calculatedHp = (100 - (_sittingHours * 3) - (_painLevel * 10)).clamp(5.0, 100.0);
    
    // 2. 更新全局状态
    ref.read(userStateProvider.notifier).setInitialHp(
      hp: calculatedHp,
      sittingHours: _sittingHours,
      painLevel: _painLevel,
      selectedPosture: _selectedPosture,
    );

    // 显示评估报告弹窗
    SurvivalAssessmentDialog.show(
      context,
      healthScore: calculatedHp.toInt(),
      metrics: [
        HealthMetric(
          icon: Icons.timer,
          title: '累计久坐时长',
          subtitle: 'SEDENTARY_LIMIT_EXCEEDED',
          value: '${_sittingHours.toInt()}h',
        ),
        HealthMetric(
          icon: Icons.warning,
          title: '脊椎由于高压形变',
          subtitle: 'STRUCTURAL_DISTORTION',
          value: _painLevel > 3 ? 'CRITICAL' : 'WARNING',
        ),
      ],
      warningMessage: _painLevel > 3 
          ? '警告：目标生物体征极其微弱，系统即将进入强制报废流程。'
          : '警告：已检测到多处结构损伤，建议立即执行续命协议。',
      actionButtonText: '立即续命',
      onActionPressed: () {
        Navigator.of(context).pop();
        context.push(AppRoutes.pressureReport);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      appBar: AppBar(
        backgroundColor: AppColors.void_,
        title: Text(
          '[ 生物扫描 ]',
          style: AppTypography.monoLabel.copyWith(
            color: AppColors.lifeSignal,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 标题
              Text(
                '初始化诊断协议',
                style: AppTypography.pixelHeadline.copyWith(
                  fontSize: 24,
                  color: AppColors.lifeSignal,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '正在扫描目标生物体征...',
                style: AppTypography.monoDecorative,
              ),
              
              const SizedBox(height: 40),
              
              // 久坐时长滑块
              _buildSection(
                title: '每日久坐时长',
                value: '${_sittingHours.toInt()} 小时',
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.lifeSignal,
                    inactiveTrackColor: AppColors.cardBackground,
                    thumbColor: AppColors.lifeSignal,
                    overlayColor: AppColors.lifeSignalGlow,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                  ),
                  child: Slider(
                    value: _sittingHours,
                    min: 1,
                    max: 16,
                    divisions: 15,
                    onChanged: (value) => setState(() => _sittingHours = value),
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // 疼痛等级
              _buildSection(
                title: '当前疼痛等级',
                value: _getPainLevelText(),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: _getPainColor(),
                    inactiveTrackColor: AppColors.cardBackground,
                    thumbColor: _getPainColor(),
                    overlayColor: _getPainColor().withOpacity(0.2),
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                  ),
                  child: Slider(
                    value: _painLevel,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    onChanged: (value) => setState(() => _painLevel = value),
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // 姿势预设
              _buildSection(
                title: '主要受损姿势',
                value: _postureOptions[_selectedPosture]['label'],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(_postureOptions.length, (index) {
                    final option = _postureOptions[index];
                    final isSelected = index == _selectedPosture;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedPosture = index),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? AppColors.lifeSignal.withOpacity(0.1)
                              : Colors.transparent,
                          border: Border.all(
                            color: isSelected 
                                ? AppColors.lifeSignal
                                : AppColors.textDecorative,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              option['icon'],
                              color: isSelected 
                                  ? AppColors.lifeSignal
                                  : AppColors.textSecondary,
                              size: 32,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              option['label'].toString().split(' ').first,
                              style: AppTypography.monoDecorative.copyWith(
                                fontSize: 10,
                                color: isSelected 
                                    ? AppColors.lifeSignal
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              
              const SizedBox(height: 48),
              
              // 开始诊断按钮
              CyberButton(
                text: '开始生存诊断',
                onPressed: _startDiagnosis,
                color: _getPainColor(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String value,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.monoLabel.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              value,
              style: AppTypography.pixelData.copyWith(
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }

  String _getPainLevelText() {
    switch (_painLevel.toInt()) {
      case 0: return '无感知';
      case 1: return '轻微酸痛';
      case 2: return '持续不适';
      case 3: return '明显疼痛';
      case 4: return '严重损伤';
      case 5: return '濒临报废';
      default: return '未知';
    }
  }

  Color _getPainColor() {
    if (_painLevel <= 1) return AppColors.lifeSignal;
    if (_painLevel <= 3) return AppColors.cautionYellow;
    return AppColors.nuclearWarning;
  }
}
