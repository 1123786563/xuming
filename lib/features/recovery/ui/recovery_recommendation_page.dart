import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../../shared/widgets/glitch_text.dart';

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
          // 背景网格 HUD
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
                
                // 主视觉：3D 脊椎诊断
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
        color: AppColors.void_.withOpacity(0.8),
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
                  shadows: [
                    Shadow(color: AppColors.nuclearWarning.withOpacity(0.5), blurRadius: 10),
                  ],
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
    return Positioned.fill(
      child: Opacity(
        opacity: 0.1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("BIO_LINK_ESTABLISHED", style: AppTypography.monoDecorative.copyWith(color: Colors.white)),
                  Text("ID: XP-882-SYS", style: AppTypography.monoDecorative.copyWith(color: Colors.white)),
                ],
              ),
              const Spacer(),
              _buildMonospaceColumn([
                "FATIGUE_LIMIT_REACHED",
                "STRUCTURAL_FAILURE_IMMINENT",
                "INITIATING_CORE_RECOVERY_PROTOCOL_V4",
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonospaceColumn(List<String> lines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(line, style: AppTypography.monoDecorative.copyWith(color: Colors.white, fontSize: 10)),
      )).toList(),
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
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
            letterSpacing: 6,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _SpineDiagnosticVisual extends StatefulWidget {
  const _SpineDiagnosticVisual();

  @override
  State<_SpineDiagnosticVisual> createState() => _SpineDiagnosticVisualState();
}

class _SpineDiagnosticVisualState extends State<_SpineDiagnosticVisual> with TickerProviderStateMixin {
  late AnimationController _rotateController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 旋转的装饰环
        RotationTransition(
          turns: _rotateController,
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Opacity(
                opacity: 0.1 + (_pulseController.value * 0.1),
                child: CustomPaint(
                  size: const Size(320, 320),
                  painter: _HUDPainter(color: AppColors.nuclearWarning),
                ),
              );
            },
          ),
        ),
        
        // 核心脊椎图
        Container(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Image.network(
            "https://lh3.googleusercontent.com/aida-public/AB6AXuBW4G-J5JT-jpXbYMuNjT79oO0bzaIUdf6FW-VISvq6hvLtYlflcETgxhEVia1bu7uyzcihFDYfmCJNFblybpS_Dawt4hgm2MsUVi9NU7vjSwZ70f7PmQ3aCRxPjCeNv1thpHrpo8_A2mop66SeUdm0DekKBSv7dMKmC98ddBjftCZZgzv2wVpDltm1UTa99dIvYv-Y65pSu4H_2wzBCuWo-lKIObA850Crm_6A6VCREFLa_e9dXWOxbL9epw-m9HrI-cRek7tSwXw",
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const CircularProgressIndicator(color: AppColors.nuclearWarning);
            },
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.accessibility_new,
              size: 200,
              color: AppColors.nuclearWarning,
            ),
          ),
        ),
        
        // HUD 动态标注
        Positioned(
          left: 30,
          top: 80,
          child: _buildHUDLabel("SEGMENT_C1-C7", "OVERLOAD", isLeft: true),
        ),
        Positioned(
          right: 30,
          bottom: 100,
          child: _buildHUDLabel("SEGMENT_L1-L5", "CRITICAL", isLeft: false),
        ),
      ],
    );
  }

  Widget _buildHUDLabel(String segment, String status, {required bool isLeft}) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final double pulse = _pulseController.value;
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            border: Border(
              left: isLeft ? const BorderSide(color: AppColors.nuclearWarning, width: 1) : BorderSide.none,
              top: isLeft ? const BorderSide(color: AppColors.nuclearWarning, width: 1) : BorderSide.none,
              right: !isLeft ? const BorderSide(color: AppColors.nuclearWarning, width: 1) : BorderSide.none,
              bottom: !isLeft ? const BorderSide(color: AppColors.nuclearWarning, width: 1) : BorderSide.none,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.nuclearWarning.withOpacity(0.1 + pulse * 0.1),
                blurRadius: 10 * pulse,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Text(segment, style: AppTypography.monoDecorative.copyWith(color: AppColors.nuclearWarning.withOpacity(0.6), fontSize: 9)),
              Text(status, style: AppTypography.monoLabel.copyWith(color: AppColors.nuclearWarning, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
        );
      },
    );
  }
}

class _HUDPainter extends CustomPainter {
  final Color color;
  _HUDPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // 外圆
    canvas.drawCircle(center, size.width / 2, paint);
    
    // 内圆
    canvas.drawCircle(center, size.width / 2 - 40, paint);

    // 绘制一些刻度线
    for (int i = 0; i < 360; i += 30) {
      final double radians = i * math.pi / 180;
      final start = Offset(
        center.dx + (size.width / 2 - 10) * math.cos(radians),
        center.dy + (size.width / 2 - 10) * math.sin(radians),
      );
      final end = Offset(
        center.dx + (size.width / 2) * math.cos(radians),
        center.dy + (size.width / 2) * math.sin(radians),
      );
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(child: _buildStatItem("Pressure Relief", "-45%")),
          const SizedBox(width: 12),
          Expanded(child: _buildStatItem("Duration", "03:00")),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.nuclearWarning.withOpacity(0.05),
        border: Border.all(color: AppColors.nuclearWarning.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: AppTypography.monoLabel.copyWith(color: AppColors.nuclearWarning.withOpacity(0.7), fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: AppTypography.pixelHeadline.copyWith(fontSize: 32, color: Colors.white)),
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
          color: Colors.white.withOpacity(0.03),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(2),
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
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.info_outline, size: 14, color: AppColors.nuclearWarning),
                        const SizedBox(width: 6),
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
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(4),
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

class _CTASection extends StatefulWidget {
  const _CTASection();

  @override
  State<_CTASection> createState() => _CTASectionState();
}

class _CTASectionState extends State<_CTASection> with SingleTickerProviderStateMixin {
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _glowController,
            builder: (context, child) {
              final double glow = _glowController.value;
              return GestureDetector(
                onTap: () => context.push('/exercise'),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.nuclearWarning,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.nuclearWarning.withOpacity(0.4 + glow * 0.4),
                        blurRadius: 15 + glow * 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bolt, color: Colors.white, size: 28 + glow * 4),
                      const SizedBox(width: 8),
                      Text(
                        "START REPAIR (开始修复)",
                        style: AppTypography.monoButton.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            "BIO_RECOVERY_SYSTEM_READY // NO_REVERSAL_ALLOWED",
            style: AppTypography.monoDecorative.copyWith(color: Colors.white30, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

