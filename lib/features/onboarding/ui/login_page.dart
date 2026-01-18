import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/cyber_button.dart';
import '../../../shared/widgets/glitch_text.dart';

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
  bool _isCodeSent = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _sendCode() {
    // TODO: 实现发送验证码逻辑
    setState(() => _isCodeSent = true);
  }

  void _login() {
    // TODO: 实现登录逻辑
    context.go(AppRoutes.diagnostic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              
              // Logo 区域
              Center(
                child: Column(
                  children: [
                    GlitchText(
                      text: '续命',
                      style: AppTypography.pixelHeadline.copyWith(
                        fontSize: 48,
                        color: AppColors.lifeSignal,
                      ),
                      isActive: false,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '[ 生物信号注入 ]',
                      style: AppTypography.monoLabel.copyWith(
                        color: AppColors.bioUpgrade,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 60),
              
              // 手机号输入
              _buildInputField(
                controller: _phoneController,
                label: '生物识别码 (手机号)',
                hint: '请输入11位手机号',
                keyboardType: TextInputType.phone,
                suffix: !_isCodeSent
                    ? TextButton(
                        onPressed: _sendCode,
                        child: Text(
                          '获取信号',
                          style: AppTypography.monoLabel.copyWith(
                            color: AppColors.lifeSignal,
                          ),
                        ),
                      )
                    : null,
              ),
              
              const SizedBox(height: 16),
              
              // 验证码输入
              if (_isCodeSent) ...[
                _buildInputField(
                  controller: _codeController,
                  label: '验证信号',
                  hint: '请输入6位验证码',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 32),
              ],
              
              // 登录按钮
              CyberButton(
                text: '注入生命信号',
                onPressed: _login,
              ),
              
              const SizedBox(height: 24),
              
              // 第三方登录
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '其他信号源',
                    style: AppTypography.monoDecorative.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // 社交登录按钮
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(
                    icon: Icons.chat_bubble,
                    label: '微信',
                    onTap: () {},
                  ),
                  const SizedBox(width: 32),
                  _buildSocialButton(
                    icon: Icons.public,
                    label: 'QQ',
                    onTap: () {},
                  ),
                ],
              ),
              
              const SizedBox(height: 48),
              
              // 底部提示
              Center(
                child: Text(
                  '登录即同意《续命服务协议》',
                  style: AppTypography.monoDecorative,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    Widget? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.monoLabel.copyWith(
            color: AppColors.lifeSignal,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: AppTypography.monoBody,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
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
              border: Border.all(color: AppColors.lifeSignal.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.lifeSignal,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTypography.monoDecorative.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
