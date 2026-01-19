import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cyber_button.dart';
import '../../../shared/widgets/glitch_text.dart';
import '../../../shared/widgets/grid_background.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../../shared/widgets/stat_card.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';

/// 核打击级久坐提醒页
/// 
/// 赛博朋克风格的高级久坐预警页面
class SedentaryReminderPage extends StatelessWidget {
  const SedentaryReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // 1. 点阵背景 (Red grid style)
          const DotsBackground(
            dotColor: AppColors.nuclearWarning,
            dotSpacing: 10,
            dotSize: 0.5,
            opacity: 0.1,
          ),

          // 2. 扫描线叠加层 (Red scanlines)
          const ScanlineOverlay(
            opacity: 0.05,
          ),

          // 3. 装饰性技术背景文字 (Background Noise)
          _buildBackgroundNoise(),

          // 4. 主内容布局
          SafeArea(
            child: Column(
              children: [
                // 顶部警告条
                _buildTopWarningBar(),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Column(
                      children: [
                        // 中央警告图标
                        _buildCentralWarningHub(),
                        const SizedBox(height: 32),
                        
                        // 核心标题
                        const GlitchText(
                          text: "核打击预警：\n检测到生物性放弃",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // 数据卡片网格
                        const Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                label: "LIFE_REDUCED",
                                value: "-45MIN",
                                subValue: "-15.4% TOTAL",
                                color: AppColors.nuclearWarning,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: StatCard(
                                label: "BIO_SIGNS",
                                value: "FADING",
                                subValue: "CRITICAL_STATE",
                                color: AppColors.nuclearWarning,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        
                        // 毒舌文案块
                        _buildToxicCopyBlock(),
                      ],
                    ),
                  ),
                ),
                
                // 底部行动区
                _buildActionSection(context),
              ],
            ),
          ),
          
          // 侧面装饰小块
          _buildFloatingDiagnostic(),
        ],
      ),
    );
  }

  Widget _buildBackgroundNoise() {
    const textStyle = TextStyle(
      color: AppColors.nuclearWarning,
      fontSize: 10,
      fontWeight: FontWeight.bold,
      fontFamily: 'monospace',
      height: 1.2,
    );

    return const Positioned.fill(
      child: IgnorePointer(
        child: Opacity(
          opacity: 0.1,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("SYSTEM_FAIL_IMMINENT // SYSTEM_FAIL_IMMINENT //", style: textStyle),
                    Text("ERROR_CODE: 0x800421 //", style: textStyle),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("BIO_SIGNS_FADING // SEDENTARY_LOCKDOWN //", style: textStyle),
                    Text("LEVEL_3_STRIKE //", style: textStyle),
                  ],
                ),
                Text("SPINE_CRITICAL_FAILURE // SPINE_CRITICAL_FAILURE //", style: textStyle),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ESTIMATED_LIFE_REDUCED_BY_45MIN //", style: textStyle),
                    Text("REPAIR_REQUIRED //", style: textStyle),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopWarningBar() {
    return Container(
      color: AppColors.nuclearWarning,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.warning, color: Colors.white, size: 20),
          Text(
            "SYSTEM_FAIL_IMMINENT",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          Icon(Icons.qr_code_scanner, color: Colors.white, size: 20),
        ],
      ),
    );
  }

  Widget _buildCentralWarningHub() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // 外部发光圆背景
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: AppColors.nuclearWarning.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
        ),
        // 故障边框
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.nuclearWarning, width: 6),
            boxShadow: [
              BoxShadow(
                color: Colors.cyan.withOpacity(0.5),
                offset: const Offset(2, 0),
              ),
              BoxShadow(
                color: AppColors.nuclearWarning.withOpacity(0.5),
                offset: const Offset(-2, 0),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.power_settings_new,
              size: 80,
              color: AppColors.nuclearWarning,
            ),
          ),
        ),
        // 威胁级别标签
        Positioned(
          bottom: -4,
          right: -8,
          child: Container(
            color: AppColors.nuclearWarning,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: const Text(
              "LVL_03_THREAT",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToxicCopyBlock() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: AppColors.nuclearWarning, width: 4),
        ),
      ),
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "TRUTH_MODULE_v4.2",
              style: TextStyle(
                color: AppColors.nuclearWarning.withOpacity(0.5),
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "“你的脊椎正在哀鸣，而你却在为老板的游艇添砖加瓦。你想在轮椅上领退休金吗？”",
            style: AppTypography.displaySubscribed.copyWith(
              color: Colors.white,
              fontSize: 18,
              height: 1.3,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          CyberButton(
            text: "EMERGENCY REPAIR",
            color: AppColors.nuclearWarning,
            height: 72,
            onPressed: () {
              context.push(AppRoutes.recoveryRecommendation);
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Manual override required",
                style: TextStyle(
                  color: AppColors.nuclearWarning.withOpacity(0.5),
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                "Auth: 882-SYS-BIO",
                style: TextStyle(
                  color: AppColors.nuclearWarning.withOpacity(0.5),
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingDiagnostic() {
    return Positioned(
      top: 100,
      right: 16,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.void_.withOpacity(0.8),
          border: Border.all(color: AppColors.nuclearWarning.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              color: AppColors.nuclearWarning.withOpacity(0.1),
              child: const Icon(
                Icons.monitor_heart,
                color: AppColors.nuclearWarning,
                size: 30,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "UNIT_01_HEALTH",
              style: TextStyle(
                color: AppColors.nuclearWarning,
                fontSize: 8,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
