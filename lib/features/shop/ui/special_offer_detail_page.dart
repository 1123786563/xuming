import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glitch_text.dart';
import '../../../shared/widgets/scanline_overlay.dart';

/// 限时特惠 - 高级动作包详情页
class SpecialOfferDetailPage extends StatefulWidget {
  const SpecialOfferDetailPage({super.key});

  @override
  State<SpecialOfferDetailPage> createState() => _SpecialOfferDetailPageState();
}

class _SpecialOfferDetailPageState extends State<SpecialOfferDetailPage> {
  late Timer _timer;
  Duration _timeLeft = const Duration(hours: 2, minutes: 59, seconds: 58);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft.inSeconds > 0) {
        setState(() {
          _timeLeft -= const Duration(seconds: 1);
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // 全局扫描线特效
          const ScanlineOverlay(),
          
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildCountdownHeader(),
                        const SizedBox(height: 8),
                        _buildHologramSection(),
                        _buildStatGrid(),
                        _buildModuleList(),
                        const SizedBox(height: 100), // 为底部留白
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 底部悬浮按钮
          _buildBottomCTA(),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.void_,
        border: Border(
          bottom: BorderSide(
            color: AppColors.bioUpgrade.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          Column(
            children: [
              Text(
                'XUMING_STATION_V1.0',
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.bioUpgrade,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              Text(
                'LIMITED_TIME_OFFER',
                style: AppTypography.monoBody.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'DEAL_EXPIRY_SEQUENCE_ACTIVE',
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.nuclearWarning,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '#FF003C_RECOVERY',
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.bioUpgrade.withOpacity(0.5),
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildTimeCard(_formatNumber(_timeLeft.inHours), 'Hours'),
              const SizedBox(width: 8),
              _buildTimeCard(_formatNumber(_timeLeft.inMinutes % 60), 'Minutes'),
              const SizedBox(width: 8),
              _buildTimeCard(_formatNumber(_timeLeft.inSeconds % 60), 'Seconds'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCard(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.nuclearWarning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: AppColors.nuclearWarning.withOpacity(0.4),
              ),
            ),
            alignment: Alignment.center,
            child: GlitchText(
              text: value,
              style: AppTypography.pixelHeadline.copyWith(
                color: AppColors.nuclearWarning,
                fontSize: 32,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label.toUpperCase(),
            style: AppTypography.monoDecorative.copyWith(
              color: AppColors.nuclearWarning.withOpacity(0.7),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHologramSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Container(
            height: 320,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(2),
              border: const Border(
                top: BorderSide(color: AppColors.bioUpgrade, width: 1),
                right: BorderSide(color: AppColors.bioUpgrade, width: 4),
              ),
            ),
            child: ClipRRect(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // 背景图
                  Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDTJo8ysptNemryo8ZonCOgEdHdNueWFkrI3sZaoG2ZPn9EtM_UpLbzYgFQYLY1QOFpPdLKTU72AYnpWQAvmSCdmt5NFxfcTr8TwGsd_oZBEI24ZESHDsUfBkfHF8-WET34FtPdqgjiq5ky7An-ZxJWPYhcZYyDtcwd_aUwvNMfrRSPv5aSW6XR0cBEOkLqO1BbVq71RcBt2PJK_JyymqCaLwMOC5Gh1yScg784Tv8jPDtE644zYAUD5xGmgDzf2MVrdQEgxXMCXQ8',
                    fit: BoxFit.cover,
                  ),
                  // 渐变蒙层
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AppColors.void_.withOpacity(0.9),
                          AppColors.bioUpgrade.withOpacity(0.1),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  // 叠加色
                  Container(color: AppColors.bioUpgrade.withOpacity(0.05)),
                  
                  // 内容
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          color: AppColors.bioUpgrade,
                          child: const Text(
                            'PREMIUM_MODULE',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '全身结构重组',
                          style: AppTypography.pixelHeadline.copyWith(
                            fontSize: 32,
                            height: 1.0,
                          ),
                        ),
                        Text(
                          'TOTAL_BODY_RECONSTRUCTION [V.1.0]',
                          style: AppTypography.monoDecorative.copyWith(
                            color: AppColors.bioUpgrade.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // 左上角技术日志
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.all(4),
              color: Colors.black.withOpacity(0.4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLogText('> AUTHENTICATING...'),
                  _buildLogText('> ASSET_LOADED: BODY_RECON'),
                  _buildLogText('> FRAME_RATE: 120FPS'),
                ],
              ),
            ),
          ),
          
          // 右下角技术日志
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(4),
              color: Colors.black.withOpacity(0.4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildLogText('SYSTEM_STATUS: STABLE', color: AppColors.nuclearWarning),
                  _buildLogText('PRICE_INDEX: DECRYPTED', color: AppColors.nuclearWarning),
                  _buildLogText('OFFER_LIFETIME: CRITICAL', color: AppColors.nuclearWarning),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogText(String text, {Color? color}) {
    return Text(
      text,
      style: AppTypography.monoDecorative.copyWith(
        fontSize: 8,
        color: color ?? AppColors.bioUpgrade,
      ),
    );
  }

  Widget _buildStatGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildStatCard(
            'System Status',
            'PRICE_DROPPED',
            '-33.4% OFF',
            Icons.trending_down,
            AppColors.bioUpgrade,
          ),
          const SizedBox(width: 12),
          _buildStatCard(
            'Network Load',
            'HIGH_DEMAND',
            'CLAIMED: 88%',
            Icons.bolt,
            AppColors.nuclearWarning,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String title, String subtitle, IconData icon, Color accentColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: accentColor.withOpacity(0.05),
          border: Border(
            left: BorderSide(color: accentColor, width: 2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: AppTypography.monoDecorative.copyWith(
                color: accentColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: AppTypography.monoBody.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(icon, size: 12, color: accentColor == AppColors.bioUpgrade ? AppColors.nuclearWarning : AppColors.bioUpgrade),
                const SizedBox(width: 4),
                Text(
                  subtitle,
                  style: AppTypography.monoBody.copyWith(
                    color: accentColor == AppColors.bioUpgrade ? AppColors.nuclearWarning : AppColors.bioUpgrade,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 8, height: 8, color: AppColors.bioUpgrade),
              const SizedBox(width: 8),
              Text(
                'INCLUDED_MODULES',
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.bioUpgrade,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildModuleItem('01', '腰椎释压术', 'Lower_Back_Relief'),
          const SizedBox(height: 12),
          _buildModuleItem('02', '眼神经减压', 'Eye_Nerve_Decomp'),
          const SizedBox(height: 12),
          _buildModuleItem('03', '抗疲劳脉冲', 'Anti-Fatigue_Pulse'),
        ],
      ),
    );
  }

  Widget _buildModuleItem(String index, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Text(
            index,
            style: AppTypography.monoDecorative.copyWith(
              color: AppColors.bioUpgrade,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.monoBody.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  subtitle.toUpperCase(),
                  style: AppTypography.monoDecorative.copyWith(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.bioUpgrade),
        ],
      ),
    );
  }

  Widget _buildBottomCTA() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          border: Border(
            top: BorderSide(
              color: AppColors.bioUpgrade.withOpacity(0.2),
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ORIGINAL: 1500 COINS',
                      style: AppTypography.monoDecorative.copyWith(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 10,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppColors.nuclearWarning,
                        letterSpacing: 2,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        GlitchText(
                          text: '999',
                          style: AppTypography.pixelHeadline.copyWith(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'COINS',
                          style: AppTypography.monoDecorative.copyWith(
                            color: AppColors.bioUpgrade,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.nuclearWarning.withOpacity(0.2),
                    border: Border.all(color: AppColors.nuclearWarning),
                  ),
                  child: Text(
                    '-33% FLASH SALE',
                    style: AppTypography.monoDecorative.copyWith(
                      color: AppColors.nuclearWarning,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildUpgradeButton(),
            const SizedBox(height: 12),
            Text(
              'ENCRYPTION_KEY: X-77-ULTRA | NODE_04',
              style: AppTypography.monoDecorative.copyWith(
                color: Colors.white.withOpacity(0.3),
                fontSize: 8,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpgradeButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Stack(
        children: [
          // 按钮主体
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.bioUpgrade,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              padding: EdgeInsets.zero,
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.download_for_offline, size: 20),
                const SizedBox(width: 8),
                Text(
                  '[ INSTALL_UPGRADE_NOW ]',
                  style: AppTypography.monoButton.copyWith(
                    letterSpacing: 2,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // 四角装饰 (简易实现)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white, width: 2),
                  left: BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 2),
                  right: BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
