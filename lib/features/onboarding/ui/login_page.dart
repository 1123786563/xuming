import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/cyber_button.dart';
import '../../../shared/widgets/cyber_input.dart';
import '../../../shared/widgets/glitch_text.dart';
import '../../../shared/widgets/scanline_overlay.dart';

/// 系统认证登录页
/// 
/// 赛博朋克风格的登录界面，包含故障艺术 Logo、动态装饰和多重认证方式
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  int _countdown = 0;
  Timer? _countdownTimer;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _countdownTimer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  void _sendCode() {
    if (_phoneController.text.length < 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.errorInvalidPhone)),
      );
      return;
    }
    setState(() => _countdown = 60);
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() => _countdown--);
      } else {
        timer.cancel();
      }
    });
  }

  void _login() {
    // 简单的本地验证演示
    if (_phoneController.text.isEmpty || _codeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.errorEmptyCredentials)),
      );
      return;
    }
    context.go(AppRoutes.diagnostic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // 背景扫描线
          const ScanlineOverlay(),
          
          // 背景装饰比特位
          _buildDecorativeDataBits(),
          
          // 主内容
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  // 顶部导航
                  _buildTopNav(),
                  
                  // 分割线
                  const SizedBox(height: 24),
                  
                  // 可滚动内容区
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          
                          // Logo 区域 (带有故障效果)
                          _buildLogoSection(),
                          
                          const SizedBox(height: 56),
                          
                          // 表单区域
                          _buildForm(),
                          
                          const SizedBox(height: 32),
                          
                          // 登录按钮
                          _buildLoginButton(),
                          
                          const SizedBox(height: 64),
                          
                          // 第三方登录
                          _buildSocialLogin(),
                          
                          const SizedBox(height: 48),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // 角落装饰装饰元素
          _buildCornerBits(),
        ],
      ),
    );
  }

  /// 构建装饰性数据位 (背景层)
  Widget _buildDecorativeDataBits() {
    return Stack(
      children: [
        // 左上角日志
        Positioned(
          top: 16,
          left: 16,
          child: Text(
            'SYS_LOG: 0x4F2A\nOS_VER_2.0.42\nSTATUS: STABLE',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 10,
              height: 1.4,
              letterSpacing: 1,
              color: AppColors.primary.withOpacity(0.3),
            ),
          ),
        ),
        
        // 右上角状态
        Positioned(
          top: 16,
          right: 16,
          child: Text(
            'ENCRYPTION: ACTIVE\nLATENCY: 12ms\nLOC: 39.9042° N',
            textAlign: TextAlign.right,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 10,
              height: 1.4,
              letterSpacing: 1,
              color: AppColors.primary.withOpacity(0.3),
            ),
          ),
        ),
        
        // 点阵背景
        const Positioned.fill(
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.05,
              child: DotsBackground(),
            ),
          ),
        ),
      ],
    );
  }

  /// 构建顶部导航
  Widget _buildTopNav() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 关闭按钮
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.close,
                size: 18,
                color: AppColors.primary,
              ),
            ),
          ),
          
          // 状态标签
          Column(
            children: [
              Text(
                AppStrings.userAuthPending,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 48,
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.8),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // 占位
          const SizedBox(width: 32),
        ],
      ),
    );
  }

  /// 构建 Logo 区域
  Widget _buildLogoSection() {
    return Column(
      children: [
        // 使用 GlitchText 组件
        GlitchText(
          text: AppStrings.appName,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 64,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: AppColors.primary,
          ),
          glitchIntensity: 1.2,
        ),
        
        const SizedBox(height: 8),
        
        // Slogan
        Column(
          children: [
            Text(
              AppStrings.appSlogan,
              style: GoogleFonts.notoSansSc(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 6,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            
            // 装饰点
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 4, height: 4, color: AppColors.primary),
                const SizedBox(width: 8),
                Container(width: 4, height: 4, color: AppColors.primary.withOpacity(0.4)),
                const SizedBox(width: 8),
                Container(width: 4, height: 4, color: AppColors.primary.withOpacity(0.2)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// 构建表单区域
  Widget _buildForm() {
    return Column(
      children: [
        // 手机号输入
        CyberInput(
          controller: _phoneController,
          label: AppStrings.mobileEntryLabel,
          hint: AppStrings.enterDigitsHint,
          keyboardType: TextInputType.phone,
          maxLength: 11,
          prefix: const CyberPrefix(text: '+86'),
        ),
        
        const SizedBox(height: 20),
        
        // 验证码输入
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: CyberInput(
                controller: _codeController,
                label: AppStrings.validationProtocolLabel,
                hint: AppStrings.codeHint,
                keyboardType: TextInputType.number,
                maxLength: 6,
              ),
            ),
            const SizedBox(width: 12),
            GetCodeButton(
              onPressed: _sendCode,
              countdown: _countdown,
            ),
          ],
        ),
      ],
    );
  }

  /// 构建登录按钮
  Widget _buildLoginButton() {
    return CyberButton(
      text: AppStrings.initializeLogin,
      onPressed: _login,
      icon: Icons.bolt,
      color: AppColors.primary,
      width: double.infinity,
    );
  }

  /// 构建第三方登录
  Widget _buildSocialLogin() {
    return Column(
      children: [
        // 分割线
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.primary.withOpacity(0.1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppStrings.otherLoginMethods,
                style: GoogleFonts.notoSansSc(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: AppColors.primary.withOpacity(0.4),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.primary.withOpacity(0.1),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 32),
        
        // 社交登录按钮
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: const Icon(Icons.wechat, size: 28, color: Color(0xFF07C160)),
              label: AppStrings.weChat,
              color: const Color(0xFF07C160),
              onTap: () {},
            ),
            const SizedBox(width: 40),
            _buildSocialButton(
              icon: const Icon(Icons.chat_bubble, size: 26, color: Color(0xFF12B7F5)),
              label: AppStrings.systemQQ,
              color: const Color(0xFF12B7F5),
              onTap: () {},
            ),
            const SizedBox(width: 40),
            _buildSocialButton(
              icon: Icon(
                Icons.fingerprint,
                size: 28,
                color: AppColors.textPrimary.withOpacity(0.7),
              ),
              label: AppStrings.biometric,
              color: Colors.white,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  /// 构建社交登录按钮
  Widget _buildSocialButton({
    required Widget icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 1,
              ),
              color: color.withOpacity(0.05),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Center(child: icon),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: AppColors.primary.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建角落装饰装饰元素
  Widget _buildCornerBits() {
    return Stack(
      children: [
        // 左下角装饰
        Positioned(
          left: 16,
          bottom: 16,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 40,
          bottom: 40,
          child: Container(
            width: 4,
            height: 4,
            color: AppColors.nuclearWarning.withOpacity(0.3),
          ),
        ),
        
        // 右下角装饰条
        Positioned(
          right: 16,
          bottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 32,
                height: 4,
                color: AppColors.primary.withOpacity(0.1),
              ),
              const SizedBox(height: 4),
              Container(
                width: 16,
                height: 4,
                color: AppColors.primary.withOpacity(0.1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 点阵背景组件
class DotsBackground extends StatelessWidget {
  const DotsBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DotsPainter(),
      size: Size.infinite,
    );
  }
}

class _DotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.4)
      ..strokeWidth = 1.0;

    const spacing = 30.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 0.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
