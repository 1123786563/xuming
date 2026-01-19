import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/scanline_overlay.dart';

class PluginInjectionLoadingPage extends StatefulWidget {
  const PluginInjectionLoadingPage({super.key});

  @override
  State<PluginInjectionLoadingPage> createState() => _PluginInjectionLoadingPageState();
}

class _PluginInjectionLoadingPageState extends State<PluginInjectionLoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;

  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
    ));

    _rotateAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _progressAnimation = Tween<double>(begin: 0, end: 0.87).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // 1. Matrix Background Decoration
          Positioned.fill(child: _buildMatrixBackground()),

          // 2. Scanline Overlay
          const Positioned.fill(child: ScanlineOverlay()),

          // 3. Decorative Corners
          _buildCorner(top: 16, left: 16, color: AppColors.bioUpgrade, type: _CornerType.topLeft),
          _buildCorner(top: 16, right: 16, color: AppColors.bioUpgrade, type: _CornerType.topRight),
          _buildCorner(bottom: 16, left: 16, color: AppColors.lifeSignal, type: _CornerType.bottomLeft),
          _buildCorner(bottom: 16, right: 16, color: AppColors.lifeSignal, type: _CornerType.bottomRight),

          // 4. Main Content Area
          SafeArea(
            child: Column(
              children: [
                // Top Bar / Diagnostic Corners
                _buildTopBar(),

                const Spacer(),

                // Central Data Core Area
                _buildCentralCore(),

                // Plugin Title
                _buildPluginTitle(),

                const Spacer(),

                // Footer Progress Section
                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) => _buildFooterProgress(),
                ),
              ],
            ),
          ),

          // Glitch Squares
          _buildGlitchSquare(top: 0.25, left: 40, size: 32, color: AppColors.bioUpgrade.withOpacity(0.2)),
          _buildGlitchRect(bottom: 0.33, right: 48, width: 4, height: 80, color: AppColors.lifeSignal.withOpacity(0.1)),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SYSTEM_AUTH',
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.lifeSignal.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.verified_user, color: AppColors.lifeSignal, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    'AUTH_KEY_VALIDATED',
                    style: AppTypography.monoLabel.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
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
                'CPU_INTERNAL',
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.bioUpgrade.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              Row(
                children: [
                  Text(
                    '32.4°C_OPTIMAL',
                    style: AppTypography.monoLabel.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.thermostat, color: AppColors.bioUpgrade, size: 14),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCentralCore() {
    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer Pulse Rings
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Container(
                width: 260 * _pulseAnimation.value,
                height: 260 * _pulseAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.lifeSignal.withOpacity(0.1), width: 2),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (math.sin(_controller.value * 2 * math.pi) * 0.1),
                child: Container(
                  width: 230,
                  height: 230,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.bioUpgrade.withOpacity(0.2), width: 1),
                  ),
                ),
              );
            },
          ),

          // Main Core
          Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  AppColors.lifeSignal.withOpacity(0.4),
                  Colors.transparent,
                  AppColors.bioUpgrade.withOpacity(0.4),
                  Colors.transparent,
                  AppColors.lifeSignal.withOpacity(0.4),
                ],
                stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                transform: GradientRotation(_rotateAnimation.value),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lifeSignal.withOpacity(0.2),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
                BoxShadow(
                  color: AppColors.bioUpgrade.withOpacity(0.1),
                  blurRadius: 50,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: ClipOval(
              child: BackdropFilter(
                filter: ColorFilter.mode(Colors.white.withOpacity(0.05), BlendMode.overlay),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.rebase_edit,
                      size: 80,
                      color: AppColors.lifeSignal,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Tech Readout Label
          Positioned(
            top: 20,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.void_,
                border: Border.all(color: AppColors.lifeSignal.withOpacity(0.5)),
                boxShadow: const [
                  BoxShadow(color: AppColors.lifeSignal, offset: Offset(4, 4)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.lifeSignal,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'HARDWARE_COMPATIBLE',
                    style: AppTypography.monoDecorative.copyWith(
                      color: AppColors.lifeSignal,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPluginTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Column(
        children: [
          Text(
            'ACTIVE BIO-ENHANCEMENT',
            style: AppTypography.monoLabel.copyWith(
              color: AppColors.bioUpgrade,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: AppTypography.pixelHeadline.copyWith(
                fontSize: 28,
                fontStyle: FontStyle.italic,
              ),
              children: [
                const TextSpan(text: '插件注入中: '),
                TextSpan(
                  text: '[手腕修复模块]',
                  style: TextStyle(color: AppColors.lifeSignal),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'HARDWARE_COMPATIBLE // BIO_SYNC_ACTIVE // V.0.98.B',
            style: AppTypography.monoDecorative.copyWith(
              color: AppColors.lifeSignal.withOpacity(0.6),
              fontSize: 9,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterProgress() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0E0E11),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BIO_SYNCING...',
                    style: AppTypography.monoLabel.copyWith(
                      color: AppColors.lifeSignal,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    'BUFFER: DATA_STREAM_0X04F',
                    style: AppTypography.monoDecorative.copyWith(
                      color: Colors.white38,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '${(_progressAnimation.value * 100).toInt()}',
                    style: AppTypography.pixelHeadline.copyWith(
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    '%',
                    style: AppTypography.monoLabel.copyWith(
                      color: AppColors.lifeSignal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress Bar
          Container(
            height: 12,
            width: double.infinity,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _progressAnimation.value.clamp(0.01, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  gradient: const LinearGradient(
                    colors: [AppColors.lifeSignal, AppColors.bioUpgrade],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    10,
                    (index) => Container(
                      width: 1,
                      color: AppColors.void_.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('LIFELINE_OS', style: _footerMetaStyle(AppColors.lifeSignal)),
                  const SizedBox(width: 8),
                  Text('|', style: _footerMetaStyle(Colors.white30)),
                  const SizedBox(width: 8),
                  Text('BUILD_2024.03', style: _footerMetaStyle(Colors.white30)),
                ],
              ),
              RichText(
                text: TextSpan(
                  style: _footerMetaStyle(Colors.white30),
                  children: [
                    const TextSpan(text: 'SECURE_LINK: '),
                    TextSpan(
                      text: 'ENCRYPTED',
                      style: TextStyle(color: AppColors.bioUpgrade),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle _footerMetaStyle(Color color) {
    return AppTypography.monoDecorative.copyWith(
      fontSize: 8,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
      color: color,
    );
  }

  Widget _buildMatrixBackground() {
    return Opacity(
      opacity: 0.1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMatrixColumn('01010101\nXP_99\nSYN_ACK\n00110011\nERR_NONE\n01010101\nXP_99\nSYN_ACK\n00110011\nERR_NONE'),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: _buildMatrixColumn('CORE_V3\nLOAD_SH\n0x992F\n1110001\nBIO_MOD\nCORE_V3\nLOAD_SH\n0x992F\n1110001\nBIO_MOD'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildMatrixColumn('WRIST_FIX\n00001111\nLINK_OK\nHEX_A01\nSYSTEM\nWRIST_FIX\n00001111\nLINK_OK\nHEX_A01\nSYSTEM'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: _buildMatrixColumn('VOID_EXT\nDATA_STR\n99.9%\n010101\nUPLOAD\nVOID_EXT\nDATA_STR\n99.9%\n010101\nUPLOAD'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatrixColumn(String text) {
    return Text(
      text,
      style: AppTypography.monoDecorative.copyWith(
        color: AppColors.lifeSignal,
        fontSize: 8,
        height: 1.5,
      ),
    );
  }

  Widget _buildCorner({
    double? top,
    double? left,
    double? right,
    double? bottom,
    required Color color,
    required _CornerType type,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          border: Border(
            top: type == _CornerType.topLeft || type == _CornerType.topRight
                ? BorderSide(color: color, width: 2)
                : BorderSide.none,
            bottom: type == _CornerType.bottomLeft || type == _CornerType.bottomRight
                ? BorderSide(color: color, width: 2)
                : BorderSide.none,
            left: type == _CornerType.topLeft || type == _CornerType.bottomLeft
                ? BorderSide(color: color, width: 2)
                : BorderSide.none,
            right: type == _CornerType.topRight || type == _CornerType.bottomRight
                ? BorderSide(color: color, width: 2)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildGlitchSquare({required double top, required double left, required double size, required Color color}) {
    return Positioned(
      top: MediaQuery.of(context).size.height * top,
      left: left,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: AppColors.bioUpgrade.withOpacity(0.3)),
        ),
      ),
    );
  }

  Widget _buildGlitchRect({required double bottom, required double right, required double width, required double height, required Color color}) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * bottom,
      right: right,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          border: Border(right: BorderSide(color: AppColors.lifeSignal.withOpacity(0.5))),
        ),
      ),
    );
  }
}

enum _CornerType { topLeft, topRight, bottomLeft, bottomRight }
