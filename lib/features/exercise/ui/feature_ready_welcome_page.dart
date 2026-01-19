import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/scanline_overlay.dart';

/// 新功能就绪欢迎页 - 手腕修复模块激活
class FeatureReadyWelcomePage extends StatelessWidget {
  const FeatureReadyWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // 赛博网格背景
          _CyberGridBackground(),
          
          // 扫描线滤镜
          ScanlineOverlay(),
          
          SafeArea(
            child: Column(
              children: [
                _HeaderAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          _TopDecorationLabels(),
                          _CenterVisualArea(),
                          _HeadlineText(),
                          SizedBox(height: 16),
                          _KernelStatusBanner(),
                          SizedBox(height: 24),
                          _TechnicalStatsLogs(),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
                _FooterAction(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CyberGridBackground extends StatelessWidget {
  const _CyberGridBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: _GridPainter(),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.05)
      ..strokeWidth = 1.0;

    const double step = 40.0;
    for (double i = 0; i <= size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i <= size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _HeaderAppBar extends StatelessWidget {
  const _HeaderAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              color: AppColors.primary.withOpacity(0.05),
            ),
            child: const Icon(Icons.terminal, color: AppColors.primary, size: 20),
          ),
          Column(
            children: [
              Text(
                'SYSTEM_STATUS',
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.primary.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'MODULE ACTIVATED',
                style: AppTypography.monoLabel.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              color: AppColors.primary.withOpacity(0.1),
            ),
            child: const Icon(Icons.settings_input_component, color: AppColors.primary, size: 20),
          ),
        ],
      ),
    );
  }
}

class _TopDecorationLabels extends StatelessWidget {
  const _TopDecorationLabels();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'SEC_INIT_9921-X\nBUFFER_STABLE_0x8F',
          style: AppTypography.monoDecorative.copyWith(
            fontSize: 8,
            color: AppColors.primary.withOpacity(0.4),
          ),
        ),
        Text(
          'LINK: ESTABLISHED\nCORE: v4.2.0',
          textAlign: TextAlign.right,
          style: AppTypography.monoDecorative.copyWith(
            fontSize: 8,
            color: AppColors.primary.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}

class _CenterVisualArea extends StatefulWidget {
  const _CenterVisualArea();

  @override
  State<_CenterVisualArea> createState() => _CenterVisualAreaState();
}

class _CenterVisualAreaState extends State<_CenterVisualArea> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Glows
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withOpacity(0.1),
            ),
          ),
          
          // Rotating border
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * math.pi,
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.2),
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              );
            },
          ),

          // Main Image
          Padding(
            padding: const EdgeInsets.all(40),
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAU23FiGilNbPJyCxtM3233mcqn4O77hMAuO5oqLcYruIIzTjJErqtkbUE7XPUPmXbE_8BNyeZc7jr50w10d6qhKuMWoyWVYiFlhWfvEtTSR9hnpyop814Ojr_0UVnfJBpaBNG8NGlPwU4qhPVm89arI19mil5wvdIHxfyGzYNYQnvwTA42CgapOcayOr3LPAWSztAO5DHeYKAEu9BIO4W9mfsYgjEaYVBKA777aciJRsjtbKrYoBQE23i55sKEB--rIB33OPsmsF8',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, color: AppColors.primary),
            ),
          ),

          // Floating nodes (pulses)
          const _PulseNode(top: 60, right: 80, size: 8),
          const _PulseNode(bottom: 100, left: 70, size: 6),
          
          // Technical scanner line overlay
          const _ScanningLine(),
        ],
      ),
    );
  }
}

class _PulseNode extends StatefulWidget {
  final double? top, bottom, left, right;
  final double size;
  const _PulseNode({this.top, this.bottom, this.left, this.right, required this.size});

  @override
  State<_PulseNode> createState() => _PulseNodeState();
}

class _PulseNodeState extends State<_PulseNode> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top, bottom: widget.bottom, left: widget.left, right: widget.right,
      child: FadeTransition(
        opacity: _controller,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
            boxShadow: [
              BoxShadow(color: AppColors.primary.withOpacity(0.8), blurRadius: 8, spreadRadius: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScanningLine extends StatefulWidget {
  const _ScanningLine();

  @override
  State<_ScanningLine> createState() => _ScanningLineState();
}

class _ScanningLineState extends State<_ScanningLine> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          top: 300 * _controller.value,
          left: 0,
          right: 0,
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.primary.withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HeadlineText extends StatelessWidget {
  const _HeadlineText();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'NEW_ASSET_UNLOCKED',
          style: AppTypography.monoLabel.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '新模块已上线: [手腕修复]',
          textAlign: TextAlign.center,
          style: AppTypography.pixelHeadline.copyWith(
            fontSize: 28,
            fontStyle: FontStyle.italic,
            shadows: [
              const Shadow(color: AppColors.primary, blurRadius: 15),
            ],
          ),
        ),
      ],
    );
  }
}

class _KernelStatusBanner extends StatelessWidget {
  const _KernelStatusBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.primary.withOpacity(0.1)),
        ),
      ),
      child: Text(
        'KERNEL_UPDATE_SUCCESS_UID_8293-X // SYNCING_NEURAL_NODES',
        textAlign: TextAlign.center,
        style: AppTypography.monoDecorative.copyWith(
          fontSize: 8,
          color: AppColors.primary.withOpacity(0.6),
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _TechnicalStatsLogs extends StatelessWidget {
  const _TechnicalStatsLogs();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStatItem('[PRECISION]', '99.98%', isFirst: true),
        _buildStatItem('[BIO-SYNC]', 'STABLE', valueColor: AppColors.primary),
        _buildStatItem('[TOXIC LEVEL]', 'EXTREME', valueColor: AppColors.nuclearWarning, isLast: true, showPulse: true),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, {
    Color? valueColor, 
    bool isFirst = false, 
    bool isLast = false,
    bool showPulse = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(12) : Radius.zero,
          bottom: isLast ? const Radius.circular(12) : Radius.zero,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text('>', style: TextStyle(color: AppColors.primary, fontFamily: 'monospace')),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTypography.monoLabel.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Row(
            children: [
              if (showPulse) ...[
                const _PulseNode(size: 6),
                const SizedBox(width: 8),
              ],
              Text(
                value,
                style: AppTypography.monoBody.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: valueColor ?? Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterAction extends StatelessWidget {
  const _FooterAction();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.void_,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.bolt, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    '立即开始首次修复',
                    style: AppTypography.pixelHeadline.copyWith(
                      fontSize: 18,
                      color: AppColors.void_,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'SECURE PROTOCOL: HIGH_PRIORITY_EXECUTION',
            style: AppTypography.monoDecorative.copyWith(
              fontSize: 10,
              color: AppColors.primary.withOpacity(0.4),
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
