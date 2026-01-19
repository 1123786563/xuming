import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'auth_routes.dart';
import 'exercise_routes.dart';
import 'profile_routes.dart';
import 'shop_routes.dart';

/// 路由路径常量
class AppRoutes {
  AppRoutes._();
  
  // Auth 模块
  static const String splash = '/';
  static const String login = '/login';
  static const String diagnostic = '/diagnostic';
  
  // Dashboard 模块
  static const String dashboard = '/dashboard';
  static const String statistics = '/statistics';
  static const String claimFailed = '/claim-failed';
  static const String sedentaryReminder = '/sedentary-reminder';
  static const String socialViral = '/social-viral';
  static const String missionCenter = '/mission-center';
  static const String medalWall = '/medal-wall';
  static const String profile = '/profile';
  static const String widgets = '/widgets';
  static const String sharePoster = '/share-poster';

  // Exercise 模块
  static const String exercise = '/exercise';
  static const String boneReset = '/bone-reset';
  static const String pressureReport = '/pressure-report';
  static const String bossMode = '/boss-mode';
  static const String spinalAlignment = '/spinal-alignment';
  static const String neckFirstAid = '/neck-first-aid';
  static const String neckStretch = '/neck-stretch';
  static const String visualNeuralReset = '/visual-neural-reset';
  static const String metacarpalPressureFlush = '/metacarpal-pressure-flush';
  static const String gluteActivation = '/glute-activation';
  static const String stealthStomachVacuum = '/stealth-stomach-vacuum';
  static const String pluginInjection = '/plugin-injection';
  static const String featureReadyWelcome = '/feature-ready-welcome';
  static const String recoveryRecommendation = '/recovery-recommendation';
  static const String stealthSurvival = '/stealth-survival';

  // Shop 模块
  static const String store = '/store';
  static const String specialOfferDetail = '/special-offer-detail';
  static const String coinInjection = '/coin-injection';
  static const String hpRecoverySuccess = '/hp-recovery-success';
}


/// GoRouter Provider
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      // 分模块路由组合
      ...authRoutes,
      ...exerciseRoutes,
      ...profileRoutes,
      ...shopRoutes,
    ],
  );
});
