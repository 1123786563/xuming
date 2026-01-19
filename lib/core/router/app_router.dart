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
import '../../features/exercise/ui/spinal_spiral_alignment_page.dart';
import '../../features/exercise/ui/neck_first_aid_page.dart'; // Add import
import '../../features/exercise/ui/neck_stretch_page.dart';
import '../../features/exercise/ui/visual_neural_reset_page.dart';
import '../../features/exercise/ui/metacarpal_pressure_flush_page.dart';
import '../../features/reward/ui/coin_injection_page.dart';
import '../../features/mission/ui/mission_center_page.dart';
import '../../features/stealth/ui/stealth_survival_page.dart';
import '../../features/profile/ui/medal_wall_page.dart';
import '../../features/profile/ui/profile_page.dart';
import '../../features/reward/ui/hp_recovery_success_page.dart';
import '../../features/share/ui/share_poster_page.dart';
import '../../features/exercise/ui/stealth_stomach_vacuum_page.dart';


import '../../features/statistics/ui/statistics_page.dart';
import '../../features/widget/ui/widgets_page.dart'; // Add import
import '../../features/shop/ui/shop_page.dart';
import '../../features/shop/ui/special_offer_detail_page.dart';
import '../../features/exercise/ui/wrist_restructure_page.dart';
import '../../features/exercise/ui/glute_activation_page.dart';
import '../../features/exercise/ui/plugin_injection_loading_page.dart';
import '../../features/exercise/ui/feature_ready_welcome_page.dart';

/// 路由路径常量
class AppRoutes {
  AppRoutes._();
  
  static const String splash = '/';
  static const String login = '/login';
  static const String diagnostic = '/diagnostic';
  static const String dashboard = '/dashboard';
  static const String statistics = '/statistics'; // Add route constant
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
  static const String spinalAlignment = '/spinal-alignment';
  static const String neckFirstAid = '/neck-first-aid'; // Add route constant
  static const String neckStretch = '/neck-stretch';
  static const String visualNeuralReset = '/visual-neural-reset';
  static const String coinInjection = '/coin-injection';
  static const String missionCenter = '/mission-center';
  static const String stealthSurvival = '/stealth-survival';
  static const String medalWall = '/medal-wall';
  static const String hpRecoverySuccess = '/hp-recovery-success';
  static const String widgets = '/widgets';
  static const String metacarpalPressureFlush = '/metacarpal-pressure-flush';
  static const String specialOfferDetail = '/special-offer-detail';
  static const String sharePoster = '/share-poster';
  static const String pluginInjection = '/plugin-injection';
  static const String gluteActivation = '/glute-activation';
  static const String stealthStomachVacuum = '/stealth-stomach-vacuum';
  static const String featureReadyWelcome = '/feature-ready-welcome';
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

      // 统计页 (生命监控中心)
      GoRoute(
        path: AppRoutes.statistics,
        builder: (context, state) => const StatisticsPage(),
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

      // 脊柱螺旋对齐指引页
      GoRoute(
        path: AppRoutes.spinalAlignment,
        builder: (context, state) => const SpinalSpiralAlignmentPage(),
      ),

      // 金币注入特效页
      GoRoute(
        path: AppRoutes.coinInjection,
        builder: (context, state) => const CoinInjectionPage(),
      ),

      // 视觉神经重置 (Variant 1)
      GoRoute(
        path: AppRoutes.visualNeuralReset,
        builder: (context, state) => const VisualNeuralResetPage(),
      ),

      // 颈椎急救指引 (男)
      GoRoute(
        path: AppRoutes.neckFirstAid,
        builder: (context, state) => const NeckFirstAidPage(),
      ),

      // 颈椎急救 (女) - 侧向颈部拉伸
      GoRoute(
        path: AppRoutes.neckStretch,
        builder: (context, state) => const NeckStretchPage(),
      ),

      // Mission Center
      GoRoute(
        path: AppRoutes.missionCenter,
        builder: (context, state) => const MissionCenterPage(),
      ),

      // 潜行模式 - 桌下动作指引
      GoRoute(
        path: AppRoutes.stealthSurvival,
        builder: (context, state) => const StealthSurvivalPage(),
      ),

      // 勋章墙 - 生存成就
      GoRoute(
        path: AppRoutes.medalWall,
        builder: (context, state) => const MedalWallPage(),
      ),

      // 生命值回复成功页
      GoRoute(
        path: AppRoutes.hpRecoverySuccess,
        builder: (context, state) => const HpRecoverySuccessPage(),
      ),

      // Widgets Preview
      GoRoute(
        path: AppRoutes.widgets,
        builder: (context, state) => const WidgetsPage(),
      ),
      GoRoute(
        path: '/exercise/wrist_restructure',
        name: 'wristRestructure',
        builder: (context, state) => const WristRestructurePage(),
      ),

      // 掌骨压力排空 (Variant 2)
      GoRoute(
        path: AppRoutes.metacarpalPressureFlush,
        builder: (context, state) => const MetacarpalPressureFlushPage(),
      ),

      // 续命商店 - 资源解锁页
      GoRoute(
        path: AppRoutes.store,
        builder: (context, state) => const ShopPage(),
      ),

      // 限时特惠 - 高级动作包详情页
      GoRoute(
        path: AppRoutes.specialOfferDetail,
        builder: (context, state) => const SpecialOfferDetailPage(),
      ),

      // 臀部机能唤醒
      GoRoute(
        path: AppRoutes.gluteActivation,
        builder: (context, state) => const GluteActivationPage(),
      ),

      // 系统档案 - 个人设置页
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfilePage(),
      ),

      // 续命保单分享海报
      GoRoute(
        path: AppRoutes.sharePoster,
        builder: (context, state) => const SharePosterPage(),
      ),

      // 新功能就绪欢迎页
      GoRoute(
        path: AppRoutes.featureReadyWelcome,
        builder: (context, state) => const FeatureReadyWelcomePage(),
      ),

      // 隐形练腹指引 (Variant 2)
      GoRoute(
        path: AppRoutes.stealthStomachVacuum,
        builder: (context, state) => const StealthStomachVacuumPage(),
      ),

      // 系统插件注入加载页
      GoRoute(
        path: AppRoutes.pluginInjection,
        builder: (context, state) => const PluginInjectionLoadingPage(),
      ),
    ],
  );
});
