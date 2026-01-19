import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/user_state_provider.dart';
import '../../../shared/widgets/digital_rain_background.dart';
import '../../../shared/widgets/scanline_overlay.dart';
import '../../../shared/widgets/hexagon_coin.dart';

class CoinInjectionPage extends ConsumerStatefulWidget {
  const CoinInjectionPage({super.key});

  @override
  ConsumerState<CoinInjectionPage> createState() => _CoinInjectionPageState();
}

class _CoinInjectionPageState extends ConsumerState<CoinInjectionPage>
    with TickerProviderStateMixin {
  // 动画控制器
  late final AnimationController _pulseController;
  late final AnimationController _floatController;
  
  // 颜色定义 (匹配设计稿)
  static const Color _primaryColor = Color(0xFF06EFC8);
  static const Color _bgColor = Color(0xFF0B0B0E);
  static const Color _accentMagenta = Color(0xFFE600E6);
  static const Color _accentYellow = Color(0xFFF7D407);

  @override
  void initState() {
    super.initState();
    
    // 脉冲动画
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // 悬浮动画
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: Stack(
        children: [
          // 1. 背景层
          const DigitalRainBackground(opacity: 0.15),
          const ScanlineOverlay(opacity: 0.2),
          
          // Glitch lines (Static placement for now)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: 0,
            right: 0,
            child: Container(height: 1, color: _accentMagenta.withOpacity(0.4)),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.66,
            left: 0,
            right: 0,
            child: Container(height: 1, color: _accentMagenta.withOpacity(0.4)),
          ),
          
          // 2. 装饰光斑
          Positioned(
            top: 40,
            right: 40,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _primaryColor.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(
                    color: _primaryColor.withOpacity(0.1),
                    blurRadius: 60,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 40,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _accentMagenta.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(
                    color: _accentMagenta.withOpacity(0.1),
                    blurRadius: 60,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          // 3. 主内容区
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                const Spacer(flex: 2),
                _buildTotalBalance(),
                const Spacer(flex: 3),
                _buildCentralAnimation(),
                const Spacer(flex: 2),
                _buildRewardText(),
                const Spacer(flex: 4),
                _buildBottomPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TRANSACTION_ID',
                style: TextStyle(
                  color: _accentYellow,
                  fontSize: 10,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Zpix',
                ),
              ),
              SizedBox(height: 4),
              Text(
                '0x4FF2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontFamily: 'Zpix',
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: _primaryColor,
                              blurRadius: 8 + 4 * _pulseController.value,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'ENCRYPTION_ACTIVE',
                    style: TextStyle(
                      color: _primaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontFamily: 'Zpix',
                    ),
                  ),
                ],
              ),
              Text(
                'SECURE_CHANNEL_LINKED',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 10,
                  fontFamily: 'Zpix',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalBalance() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: _primaryColor.withOpacity(0.1),
            border: Border.all(color: _primaryColor.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Container(
                    width: double.infinity,
                    height: 200, // This container seems wrong in context of design which shows balance inside.
                                 // Checking design: It's a small box wrapping "Current Balance" and Number.
                    // Correcting logic based on HTML:
                    // <div class="bg-primary/10 border ... flex-col items-center relative overflow-hidden group">
                    //   <div class="absolute inset-0 bg-primary/5 animate-pulse"></div>
                    //   <p ...>Current Balance</p> ...
                    decoration: BoxDecoration(
                      color: _primaryColor.withOpacity(0.05 * _pulseController.value),
                    ),
                    child: child,
                  );
                },
                child: const SizedBox.shrink(), // Just for background effect, but structure below handles content
              ),
            ]..clear()..addAll([ // Replacing the children to match new structure
               Text(
                'CURRENT BALANCE',
                style: TextStyle(
                  color: _primaryColor.withOpacity(0.7),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'Zpix',
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '${ref.watch(userStateProvider).coins}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Zpix',
                      shadows: [
                        Shadow(
                          color: _primaryColor.withOpacity(0.8),
                          blurRadius: 10,
                        ),
                        Shadow(
                          color: _primaryColor.withOpacity(0.4),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'XC',
                    style: TextStyle(
                      color: _primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Zpix',
                    ),
                  ),
                ],
              ),
              // Tick-Tick Visualizer
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 8, height: 4, color: _primaryColor.withOpacity(0.6)),
                  const SizedBox(width: 2),
                  Container(width: 16, height: 4, color: _primaryColor),
                  const SizedBox(width: 2),
                  Container(width: 4, height: 4, color: _primaryColor.withOpacity(0.4)),
                  const SizedBox(width: 2),
                  Container(width: 12, height: 4, color: _primaryColor.withOpacity(0.8)),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildCentralAnimation() {
    return AnimatedBuilder(
      animation: Listenable.merge([_pulseController, _floatController]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatController.value * -20),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Outer Glow Rings
              Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _primaryColor.withOpacity(0.2 * (1 - _pulseController.value)),
                    width: 2,
                  ),
                ),
              ),
              Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _primaryColor.withOpacity(0.4),
                    width: 1,
                  ),
                ),
              ),
              
              // Light Trails (上方光束)
              Positioned(
                top: -80, // Moved up slightly
                child: Column(
                  children: [
                    Container(
                      width: 2,
                      height: 64,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, _primaryColor],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 2,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, _primaryColor.withOpacity(0.4)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Hex Coin with Glow
              Container(
                 decoration: BoxDecoration(
                    shape: BoxShape.circle,
                     boxShadow: [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.3),
                        blurRadius: 50,
                        spreadRadius: 10,
                      ),
                    ],
                 ),
                 child: HexagonCoin(
                  size: 192,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Texture overlay simulation
                      Opacity(
                        opacity: 0.2,
                        child: Container(color: Colors.black), 
                        // In real code we'd use an image, but simple dark tint works for "carbon" feel on top of gradients
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.dangerous, 
                            color: _primaryColor,
                            size: 64,
                          ),
                          // Small vertical line below icon
                          Container(
                            width: 2,
                            height: 20,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [_primaryColor, Colors.transparent],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRewardText() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          color: _primaryColor,
          child: const Text(
            'SUCCESS INJECTION',
            style: TextStyle(
              color: _bgColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              fontFamily: 'Zpix',
            ),
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Zpix',
              color: Colors.white,
              height: 1.2,
              shadows: [
                 Shadow(
                    color: Color(0xCC06EFC8),
                    blurRadius: 10,
                 ),
                 Shadow(
                    color: Color(0x6606EFC8),
                    blurRadius: 20,
                 ),
              ],
            ),
            children: [
              TextSpan(text: '获取生物能量: '),
              TextSpan(
                text: '+100',
                style: TextStyle(
                  color: _primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: ' 续命币'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Zpix',
              color: Colors.white.withOpacity(0.6),
              letterSpacing: 1,
            ),
            children: const [
              TextSpan(text: 'SYSTEM_STATUS: '),
              TextSpan(
                text: 'INJECTION_COMPLETE',
                style: TextStyle(
                  color: _primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [_bgColor, _bgColor.withOpacity(0)],
          stops: const [0.8, 1.0],
        ),
      ),
      child: Column(
        children: [
          // Tech Readouts
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  label: 'BIO-METRIC PULSE',
                  value: '72',
                  unit: 'BPM',
                  color: _primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInfoCard(
                  label: 'SYNC STABILITY',
                  value: '98.4',
                  unit: '%',
                  color: _accentMagenta,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Action Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                context.go(AppRoutes.store);
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: _primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: _primaryColor.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: -5,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CONFIRM REDEMPTION',
                      style: TextStyle(
                        color: _bgColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 2,
                        fontFamily: 'Zpix',
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: _bgColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Footer Info
          Container(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LOG_SEQ: 8829-X\nMEM_LOAD: 44.2%',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 8,
                    fontFamily: 'Zpix',
                    height: 1.5,
                  ),
                ),
                 Text(
                  'OS_V: 2.0.4_CYBER\nLOCAL_TIME: 23:59:59',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 8,
                    fontFamily: 'Zpix',
                   height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String label,
    required String value,
    required String unit,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        border: Border(
          left: BorderSide(color: color, width: 2),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              fontFamily: 'Zpix',
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Zpix',
                ),
              ),
              const SizedBox(width: 2),
              Text(
                unit,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 10,
                  fontFamily: 'Zpix',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
