import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/ui/splash_page.dart';
import '../../features/onboarding/ui/login_page.dart';
import '../../features/onboarding/ui/diagnostic_page.dart';
import '../../features/dashboard/ui/dashboard_page.dart';
import '../../features/claim_failed/ui/claim_failed_page.dart';

import '../../features/social/ui/social_viral_page.dart';
import '../../features/recovery/ui/recovery_recommendation_page.dart';
import '../../features/reminders/ui/sedentary_reminder_page.dart';
import '../../features/exercise/ui/exercise_execution_page.dart';
import '../../features/exercise/ui/bone_reset_page.dart';
import '../../features/exercise/ui/pressure_report_page.dart';
import '../../features/exercise/ui/boss_mode_page.dart';

/// 路由路径常量
class AppRoutes {
  AppRoutes._();
  
  static const String splash = '/';
  static const String login = '/login';
  static const String diagnostic = '/diagnostic';
  static const String dashboard = '/dashboard';
  static const String claimFailed = '/claim-failed';

  static const String recoveryRecommendation = '/recovery-recommendation';
  static const String exercise = '/exercise';
  static const String store = '/store';
  static const String profile = '/profile';
  static const String sedentaryReminder = '/sedentary-reminder';
  static const String socialViral = '/social-viral';
  static const String boneReset = '/bone-reset';
  static const String pressureReport = '/pressure-report';
  static const String bossMode = '/boss-mode';
}

/// GoRouter Provider
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      // 启动页
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      
      // 登录页
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      
      // 诊断页
      GoRoute(
        path: AppRoutes.diagnostic,
        builder: (context, state) => const DiagnosticPage(),
      ),
      
      // 仪表盘
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardPage(),
      ),

      // 索赔失败页
      GoRoute(
        path: AppRoutes.claimFailed,
        builder: (context, state) => const ClaimFailedPage(),
      ),


      // 动作推荐 (紧急抢修)
      GoRoute(
        path: AppRoutes.recoveryRecommendation,
        builder: (context, state) => const RecoveryRecommendationPage(),
      ),
      
      
      // 核打击级久坐提醒页
      GoRoute(
        path: AppRoutes.sedentaryReminder,
        builder: (context, state) => const SedentaryReminderPage(),
      ),
      
      // 社交裂变页
      GoRoute(
        path: AppRoutes.socialViral,
        builder: (context, state) => const SocialViralPage(),
      ),

      // 动作执行页
      GoRoute(
        path: AppRoutes.exercise,
        builder: (context, state) => const ExerciseExecutionPage(),
      ),

      // 骨骼复位页
      GoRoute(
        path: AppRoutes.boneReset,
        builder: (context, state) => const BoneResetPage(),
      ),

      // 压力报告页
      GoRoute(
        path: AppRoutes.pressureReport,
        builder: (context, state) => const PressureReportPage(),
      ),

      // Boss Mode 伪装页
      GoRoute(
        path: AppRoutes.bossMode,
        builder: (context, state) => const BossModePage(),
      ),

      // TODO: 添加更多路由
    ],
  );
});
