import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 掌骨压力排空页面 (Variant 2)
///
/// 赛博风格的手部压力释放训练页面
/// 主色调: 青色 (#00EAFF)
class MetacarpalPressureFlushPage extends StatefulWidget {
  const MetacarpalPressureFlushPage({super.key});

  @override
  State<MetacarpalPressureFlushPage> createState() =>
      _MetacarpalPressureFlushPageState();
}

class _MetacarpalPressureFlushPageState
    extends State<MetacarpalPressureFlushPage> with TickerProviderStateMixin {
  late AnimationController _scanlineController;
  late AnimationController _progressController;

  // 主题色 - 青色
  static const Color _primaryCyan = Color(0xFF00EAFF);
  static const Color _backgroundDark = Color(0xFF0D1116);
  static const Color _surfaceDark = Color(0xFF1C232F);

  final double _progress = 0.65; // 65% 进度

  @override
  void initState() {
    super.initState();
    _scanlineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
  }

  @override
  void dispose() {
    _scanlineController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundDark,
      body: Stack(
        children: [
          // 背景网格点阵
          Positioned.fill(
            child: CustomPaint(
              painter: _DataGridPainter(color: _primaryCyan),
            ),
          ),

          // 顶部装饰线
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 1,
              color: Color.lerp(Colors.transparent, _primaryCyan, 0.3),
            ),
          ),

          Column(
            children: [
              _buildTopAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHeadlineSection(),
                      _buildCentralDiagnosticView(),
                      _buildProgressSection(),
                      _buildQuoteSection(),
                    ],
                  ),
                ),
              ),
              _buildBottomControlPanel(),
            ],
          ),

          // 底部指示条
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 128,
                height: 4,
                decoration: BoxDecoration(
                  color: Color.lerp(Colors.transparent, _primaryCyan, 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 顶部应用栏
  Widget _buildTopAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 8,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: Color.lerp(Colors.transparent, _backgroundDark, 0.8),
        border: Border(
          bottom: BorderSide(
              color: Color.lerp(Colors.transparent, _primaryCyan, 0.2)!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左侧菜单图标
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              child: const Icon(
                Icons.grid_view_rounded,
                color: _primaryCyan,
                size: 24,
              ),
            ),
          ),

          // 中间标题
          Column(
            children: [
              Text(
                'SYSTEM MODULE',
                style: GoogleFonts.spaceGrotesk(
                  color: Color.lerp(Colors.transparent, Colors.white, 0.6),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'XUMING v2.0',
                style: GoogleFonts.spaceGrotesk(
                  color: _primaryCyan,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),

          // 右侧设置按钮
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color.lerp(Colors.transparent, _primaryCyan, 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color.lerp(Colors.transparent, _primaryCyan, 0.3)!,
              ),
            ),
            child: const Icon(
              Icons.settings_input_component,
              color: _primaryCyan,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  /// 标题区域
  Widget _buildHeadlineSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
      child: Column(
        children: [
          // 标签
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color.lerp(Colors.transparent, _primaryCyan, 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color.lerp(Colors.transparent, _primaryCyan, 0.4)!,
              ),
            ),
            child: Text(
              'MANUAL DATA FLUSH',
              style: GoogleFonts.spaceGrotesk(
                color: _primaryCyan,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // 主标题
          Text(
            '任务: 掌骨压力排空',
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),

          // 分割线
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: _primaryCyan,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  /// 中央诊断视图 - 3D 手部可视化
  Widget _buildCentralDiagnosticView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.lerp(Colors.transparent, _surfaceDark, 0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color.lerp(Colors.transparent, _primaryCyan, 0.2)!,
            ),
            boxShadow: [
              BoxShadow(
                color: Color.lerp(Colors.transparent, _primaryCyan, 0.1)!,
                blurRadius: 10,
                spreadRadius: -5,
              ),
              BoxShadow(
                color: Color.lerp(Colors.transparent, _primaryCyan, 0.2)!,
                blurRadius: 10,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Stack(
            children: [
              // 3D 手部图像
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCwc0Bt4oqM_QyY8ZjFu7pKSPfMP3Ks7N4Oa2HqQifj9aDTAMZ7vJedzlpgtf7hLoUkJL9Z3jwe6WuJ55WagIWOjJzAeafFbBLEESWCUKwQUOsNrOtR3NuoX6IKAkDWvCw7tThhHJ9WH64B_OGgUZv1Zwl-Xmt3fhTt6I7-0S54SzYL4B-U6s2bxT62XAAtFEFvsCCuWIE_hqc9lBSq2u5P45dYiIHNsoPUJwFYdGri9jOdE6Sy2mJ1KjCaaMvuGdM6ltIEzt4D4pQ',
                    fit: BoxFit.contain,
                    opacity: const AlwaysStoppedAnimation(0.8),
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.back_hand_outlined,
                          size: 120,
                          color:
                              Color.lerp(Colors.transparent, _primaryCyan, 0.3),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // 左上角诊断覆盖层
              Positioned(
                top: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'X-AXIS: STABLE',
                      style: GoogleFonts.jetBrainsMono(
                        color:
                            Color.lerp(Colors.transparent, _primaryCyan, 0.7),
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Y-AXIS: FLUSHING...',
                      style: GoogleFonts.jetBrainsMono(
                        color:
                            Color.lerp(Colors.transparent, _primaryCyan, 0.7),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),

              // 右下角完整性指标
              Positioned(
                bottom: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'CARPAL INTEGRITY',
                      style: GoogleFonts.jetBrainsMono(
                        color:
                            Color.lerp(Colors.transparent, _primaryCyan, 0.7),
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '88.4%',
                      style: GoogleFonts.spaceGrotesk(
                        color: _primaryCyan,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // 扫描线效果
              AnimatedBuilder(
                animation: _scanlineController,
                builder: (context, child) {
                  return Positioned(
                    top: _scanlineController.value * 300,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color.lerp(Colors.transparent, _primaryCyan, 0.05)!,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 进度条区域
  Widget _buildProgressSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // 状态和百分比
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PROCESS STATUS',
                    style: GoogleFonts.spaceGrotesk(
                      color: _primaryCyan,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'FLUSHING TOXIC DATA...',
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              AnimatedBuilder(
                animation: _progressController,
                builder: (context, child) {
                  final displayProgress =
                      (_progress * _progressController.value * 100).toInt();
                  return Text(
                    '$displayProgress%',
                    style: GoogleFonts.spaceGrotesk(
                      color: _primaryCyan,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 进度条
          Container(
            height: 16,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _surfaceDark,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color.lerp(Colors.transparent, _primaryCyan, 0.2)!,
              ),
            ),
            child: AnimatedBuilder(
              animation: _progressController,
              builder: (context, child) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: constraints.maxWidth *
                            _progress *
                            _progressController.value,
                        decoration: BoxDecoration(
                          color: _primaryCyan,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Color.lerp(
                                  Colors.transparent, _primaryCyan, 0.6)!,
                              blurRadius: 15,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // 日志信息
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SYST_LOG: NEURAL_PATHWAY_CLEAR',
                style: GoogleFonts.jetBrainsMono(
                  color: Color.lerp(Colors.transparent, _primaryCyan, 0.6),
                  fontSize: 10,
                ),
              ),
              Text(
                'MT_02_CARPAL',
                style: GoogleFonts.jetBrainsMono(
                  color: Color.lerp(Colors.transparent, _primaryCyan, 0.6),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 引言区域
  Widget _buildQuoteSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color.lerp(Colors.transparent, _surfaceDark, 0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(
              color: Color.lerp(Colors.transparent, _primaryCyan, 0.5)!,
              width: 4,
            ),
          ),
        ),
        child: Text(
          '"Your hands were built for tools, not just for endless scrolling and clicking."',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: Color.lerp(Colors.transparent, Colors.white, 0.8),
            fontSize: 14,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  /// 底部控制面板
  Widget _buildBottomControlPanel() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      decoration: BoxDecoration(
        color: _surfaceDark,
        border: Border(
          top: BorderSide(
              color: Color.lerp(Colors.transparent, _primaryCyan, 0.2)!),
        ),
      ),
      child: Column(
        children: [
          // 主操作按钮
          GestureDetector(
            onTap: () {
              // 完成同步操作
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: _primaryCyan,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Color.lerp(Colors.transparent, _primaryCyan, 0.3)!,
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.bolt,
                    color: _backgroundDark,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'COMPLETE FLUSH SYNC',
                    style: GoogleFonts.spaceGrotesk(
                      color: _backgroundDark,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 底部标签栏
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabItem(Icons.fitness_center, 'TRAIN', true),
              _buildTabItem(Icons.analytics_outlined, 'DATA', false),
              _buildTabItem(Icons.person, 'BIO', false),
            ],
          ),
        ],
      ),
    );
  }

  /// 标签项
  Widget _buildTabItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive
              ? _primaryCyan
              : Color.lerp(Colors.transparent, Colors.white, 0.4),
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            color: isActive
                ? _primaryCyan
                : Color.lerp(Colors.transparent, Colors.white, 0.4),
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

/// 背景数据网格绘制器
class _DataGridPainter extends CustomPainter {
  final Color color;

  _DataGridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.lerp(Colors.transparent, color, 0.07)!
      ..style = PaintingStyle.fill;

    const spacing = 20.0;
    const dotRadius = 0.5;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
