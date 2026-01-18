import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../../shared/widgets/glitch_text.dart';
import '../../../shared/widgets/cyber_button.dart';

/// 极高压力针对性动作推荐页面
/// 
/// 紧急抢修任务 (Emergency Repair Task)
class RecoveryRecommendationPage extends StatelessWidget {
  const RecoveryRecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // 背景网格 HUD (模仿 HTML 中的装饰性文字)
          const _BackgroundHUD(),
          
          // 扫描线叠加层
          const ScanlineOverlay(lineOpacity: 0.05),
          
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 顶部工具栏
                _buildAppBar(context),
                
                // 状态警告栏
                const _HeadlineStatus(),
                
                // 主视觉：3D 脊椎诊断 (模拟)
                const Expanded(
                  child: _SpineDiagnosticVisual(),
                ),
                
                // 统计数据
                const _StatsSection(),
                
                // 推荐动作卡片
                const _ProtocolCard(),
                
                // 底部操作区
                const _CTASection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.nuclearWarning.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.nuclearWarning),
            onPressed: () => context.pop(),
          ),
          Expanded(
            child: Center(
              child: GlitchText(
                text: "紧急抢修任务: 脊椎解压",
                style: AppTypography.monoBody.copyWith(
                  color: AppColors.nuclearWarning,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.warning_amber_rounded, color: AppColors.nuclearWarning),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _BackgroundHUD extends StatelessWidget {
  const _BackgroundHUD();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("BIO_LINK_ESTABLISHED", style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'monospace')),
                Text("ID: XP-882-SYS", style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'monospace')),
              ],
            ),
            const Spacer(),
            Text("FATIGUE_LIMIT_REACHED", style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'monospace')),
            const SizedBox(height: 4),
            Text("STRUCTURAL_FAILURE_IMMINENT", style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'monospace')),
            const SizedBox(height: 4),
            Text("INITIATING_CORE_RECOVERY_PROTOCOL_V4", style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'monospace')),
          ],
        ),
      ),
    );
  }
}

class _HeadlineStatus extends StatefulWidget {
  const _HeadlineStatus();

  @override
  State<_HeadlineStatus> createState() => _HeadlineStatusState();
}

class _HeadlineStatusState extends State<_HeadlineStatus> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.nuclearWarning.withOpacity(0.1),
          ),
        ),
      ),
      child: FadeTransition(
        opacity: _animation,
        child: Text(
          "STRUCTURAL_INTEGRITY_LOW",
          textAlign: TextAlign.center,
          style: AppTypography.monoLabel.copyWith(
            color: AppColors.nuclearWarning,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _SpineDiagnosticVisual extends StatelessWidget {
  const _SpineDiagnosticVisual();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 背景圆环动效 (模拟 HTML 中的装饰圆)
            _buildCircles(),
            
            // 脊椎骨骼占位 (实际项目中应使用资源图片)
            Image.network(
              "https://lh3.googleusercontent.com/aida-public/AB6AXuBW4G-J5JT-jpXbYMuNjT79oO0bzaIUdf6FW-VISvq6hvLtYlflcETgxhEVia1bu7uyzcihFDYfmCJNFblybpS_Dawt4hgm2MsUVi9NU7vjSwZ70f7PmQ3aCRxPjCeNv1thpHrpo8_A2mop66SeUdm0DekKBSv7dMKmC98ddBjftCZZgzv2wVpDltm1UTa99dIvYv-Y65pSu4H_2wzBCuWo-lKIObA850Crm_6A6VCREFLa_e9dXWOxbL9epw-m9HrI-cRek7tSwXw",
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.accessibility_new,
                size: 200,
                color: AppColors.nuclearWarning,
              ),
            ),
            
            // HUD 标注
            Positioned(
              left: 40,
              top: 100,
              child: _buildHUDLabel("SEGMENT_C1-C7", "OVERLOAD", Alignment.bottomLeft),
            ),
            Positioned(
              right: 40,
              bottom: 120,
              child: _buildHUDLabel("SEGMENT_L1-L5", "CRITICAL", Alignment.topRight),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircles() {
    return Opacity(
      opacity: 0.2,
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.nuclearWarning.withOpacity(0.3)),
        ),
        alignment: Alignment.center,
        child: Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.nuclearWarning.withOpacity(0.2)),
          ),
        ),
      ),
    );
  }

  Widget _buildHUDLabel(String segment, String status, Alignment borderAlignment) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        border: Border(
          left: borderAlignment == Alignment.bottomLeft ? const BorderSide(color: AppColors.nuclearWarning, width: 1) : BorderSide.none,
          top: borderAlignment == Alignment.bottomLeft ? const BorderSide(color: AppColors.nuclearWarning, width: 1) : BorderSide.none,
          right: borderAlignment == Alignment.topRight ? const BorderSide(color: AppColors.nuclearWarning, width: 1) : BorderSide.none,
          bottom: borderAlignment == Alignment.topRight ? const BorderSide(color: AppColors.nuclearWarning, width: 1) : BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: borderAlignment == Alignment.bottomLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(segment, style: const TextStyle(color: Color(0x99FF003C), fontSize: 9, fontFamily: 'monospace')),
          Text(status, style: const TextStyle(color: AppColors.nuclearWarning, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem("Pressure Relief", "-45%"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatItem("Duration", "03:00"),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.nuclearWarning.withOpacity(0.05),
        border: Border.all(color: AppColors.nuclearWarning.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: AppTypography.monoLabel.copyWith(color: AppColors.nuclearWarning.withOpacity(0.7), fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: AppTypography.pixelHeadline.copyWith(fontSize: 28, color: Colors.white)),
        ],
      ),
    );
  }
}

class _ProtocolCard extends StatelessWidget {
  const _ProtocolCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Standing Back Extension", style: AppTypography.monoBody.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    "Recommended Protocol: Level 5 Relief",
                    style: AppTypography.monoLabel.copyWith(color: AppColors.nuclearWarning.withOpacity(0.8), fontSize: 11),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.info_outline, size: 14, color: AppColors.nuclearWarning),
                      const SizedBox(width: 4),
                      Text(
                        "VIEW TECHNICAL GUIDE",
                        style: AppTypography.monoLabel.copyWith(
                          color: AppColors.nuclearWarning,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white10),
                image: const DecorationImage(
                  image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuCeJKoccr-pifHeuOFMaukbeIKQhTKk_wiCw5Kc8DqeppWs1FbBKRdSyd8EptO0fD28EjL2mkITRgJnrtt7vlJpG9sVN1FnbQ7mai8-tdARUChexELhRMxbWwr-T43CUa7QIci81DKXGOPzWRzqemzwzfrQpe1x7Vvwf9QXw3ppkCdc_CWK0aEGa58S9dq4s6SAqOH_fS6aLJbXgqaKWnyyMXGo5gV0NLYBwciO2y_yG-awhOqnjq8igA83gWF9Zw4j_lkKl13ZCXI"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CTASection extends StatelessWidget {
  const _CTASection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CyberButton(
            text: "START REPAIR (开始修复)",
            color: AppColors.nuclearWarning,
            height: 64,
            onPressed: () {
              context.push(AppRoutes.exercise);
            },
          ),
          const SizedBox(height: 12),
          Text(
            "BIO_RECOVERY_SYSTEM_READY // NO_REVERSAL_ALLOWED",
            style: AppTypography.monoLabel.copyWith(color: Colors.white24, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
