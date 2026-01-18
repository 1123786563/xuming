import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/cyber_button.dart';
import '../../../shared/widgets/cyber_input.dart';
import '../../../shared/widgets/grid_background.dart';
import '../../../shared/widgets/scanline_overlay.dart';

/// 系统认证登录页
/// 
/// 赛博朋克风格的登录界面
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  int _countdown = 0;
  Timer? _countdownTimer;

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _sendCode() {
    // TODO: 实现发送验证码逻辑
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
    // TODO: 实现登录逻辑
    context.go(AppRoutes.diagnostic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // 背景点阵
          const DotsBackground(),
          
          // 角落装饰数据
          _buildCornerDecorations(),
          
          // 主内容
          SafeArea(
            child: Column(
              children: [
                // 顶部导航
                _buildTopNav(),
                
                // 可滚动内容区
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        const SizedBox(height: 48),
                        
                        // Logo 区域
                        _buildLogoSection(),
                        
                        const SizedBox(height: 48),
                        
                        // 表单区域
                        _buildForm(),
                        
                        const SizedBox(height: 24),
                        
                        // 登录按钮
                        _buildLoginButton(),
                        
                        const SizedBox(height: 48),
                        
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
          
          // 角落装饰元素
          _buildCornerBits(),
        ],
      ),
    );
  }

  /// 构建顶部导航
  Widget _buildTopNav() {
    return Padding(
      padding: const EdgeInsets.all(24),
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
                  color: AppColors.lifeSignal.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.close,
                size: 20,
                color: AppColors.lifeSignal,
              ),
            ),
          ),
          
          // 状态标签
          Column(
            children: [
              Text(
                'USER_AUTH_PENDING',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: AppColors.lifeSignal,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 48,
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.lifeSignal,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lifeSignal.withOpacity(0.8),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // 占位
          const SizedBox(width: 32, height: 32),
        ],
      ),
    );
  }

  /// 构建角落装饰数据
  Widget _buildCornerDecorations() {
    return Stack(
      children: [
        // 左上角
        Positioned(
          top: 16,
          left: 16,
          child: Text(
            'SYS_LOG: 0x4F2A\nOS_VER_2.0.42\nSTATUS: STABLE',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 10,
              height: 1.4,
              letterSpacing: 1,
              color: AppColors.lifeSignal.withOpacity(0.4),
            ),
          ),
        ),
        
        // 右上角
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
              color: AppColors.lifeSignal.withOpacity(0.4),
            ),
          ),
        ),
      ],
    );
  }

  /// 构建 Logo 区域
  Widget _buildLogoSection() {
    return Column(
      children: [
        // 主 Logo
        Stack(
          clipBehavior: Clip.none,
          children: [
            // 故障效果层 - 红色
            Positioned(
              left: -2,
              top: -1,
              child: Text(
                'XuMing',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFFFF3914).withOpacity(0.5),
                ),
              ),
            ),
            
            // 主文字
            Text(
              'XuMing',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: AppColors.lifeSignal,
                shadows: [
                  Shadow(
                    color: const Color(0xFFFF3914),
                    offset: const Offset(2, 0),
                  ),
                  Shadow(
                    color: AppColors.lifeSignal,
                    offset: const Offset(-2, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Slogan
        Column(
          children: [
            Text(
              '延缓报废，即刻续命',
              style: GoogleFonts.notoSansSc(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 8,
                color: AppColors.lifeSignal,
              ),
            ),
            const SizedBox(height: 8),
            
            // 装饰点
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 4,
                  height: 4,
                  color: AppColors.lifeSignal,
                ),
                const SizedBox(width: 8),
                Container(
                  width: 4,
                  height: 4,
                  color: AppColors.lifeSignal.withOpacity(0.4),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 4,
                  height: 4,
                  color: AppColors.lifeSignal.withOpacity(0.2),
                ),
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
          label: 'Mobile_Entry',
          hint: 'ENTER_DIGITS',
          keyboardType: TextInputType.phone,
          maxLength: 11,
          prefix: const CyberPrefix(text: '+86'),
        ),
        
        const SizedBox(height: 16),
        
        // 验证码输入
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: CyberInput(
                controller: _codeController,
                label: 'Validation_Protocol',
                hint: '6-DIGIT_CODE',
                keyboardType: TextInputType.number,
                maxLength: 6,
              ),
            ),
            const SizedBox(width: 8),
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
    return GestureDetector(
      onTap: _login,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.lifeSignal,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.lifeSignal.withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'INITIALIZE_LOGIN',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: AppColors.void_,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.bolt,
              size: 20,
              color: AppColors.void_,
            ),
          ],
        ),
      ),
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
                color: AppColors.lifeSignal.withOpacity(0.2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '其他方式注入生命值',
                style: GoogleFonts.notoSansSc(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: AppColors.lifeSignal.withOpacity(0.4),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.lifeSignal.withOpacity(0.2),
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
              icon: _buildWeChatIcon(),
              label: 'WE_CHAT',
              color: const Color(0xFF07C160),
              onTap: () {},
            ),
            const SizedBox(width: 32),
            _buildSocialButton(
              icon: Icon(
                Icons.chat_bubble_outline,
                size: 28,
                color: const Color(0xFF12B7F5),
              ),
              label: 'SYSTEM_QQ',
              color: const Color(0xFF12B7F5),
              onTap: () {},
            ),
            const SizedBox(width: 32),
            _buildSocialButton(
              icon: Icon(
                Icons.fingerprint,
                size: 28,
                color: AppColors.textPrimary.withOpacity(0.8),
              ),
              label: 'BIOMETRIC',
              color: AppColors.textPrimary.withOpacity(0.3),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  /// 微信图标
  Widget _buildWeChatIcon() {
    return Icon(
      Icons.wechat,
      size: 28,
      color: const Color(0xFF07C160),
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
                color: color.withOpacity(0.5),
                width: 1,
              ),
              color: color.withOpacity(0.05),
            ),
            child: Center(child: icon),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: AppColors.lifeSignal.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建角落装饰元素
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
              color: AppColors.lifeSignal.withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lifeSignal.withOpacity(0.2),
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
            color: AppColors.nuclearWarning.withOpacity(0.4),
          ),
        ),
        
        // 右下角装饰
        Positioned(
          right: 16,
          bottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 32,
                height: 4,
                color: AppColors.lifeSignal.withOpacity(0.2),
              ),
              const SizedBox(height: 4),
              Container(
                width: 16,
                height: 4,
                color: AppColors.lifeSignal.withOpacity(0.2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
