import 'package:go_router/go_router.dart';

import '../../features/exercise/ui/bone_reset_page.dart';
import '../../features/exercise/ui/boss_mode_page.dart';
import '../../features/exercise/ui/exercise_execution_page.dart';
import '../../features/exercise/ui/feature_ready_welcome_page.dart';
import '../../features/exercise/ui/glute_activation_page.dart';
import '../../features/exercise/ui/metacarpal_pressure_flush_page.dart';
import '../../features/exercise/ui/neck_first_aid_page.dart';
import '../../features/exercise/ui/neck_stretch_page.dart';
import '../../features/exercise/ui/plugin_injection_loading_page.dart';
import '../../features/exercise/ui/pressure_report_page.dart';
import '../../features/exercise/ui/spinal_spiral_alignment_page.dart';
import '../../features/exercise/ui/stealth_stomach_vacuum_page.dart';
import '../../features/exercise/ui/visual_neural_reset_page.dart';
import '../../features/exercise/ui/wrist_restructure_page.dart';
import '../../features/recovery/ui/recovery_recommendation_page.dart';
import '../../features/stealth/ui/stealth_survival_page.dart';
import 'app_router.dart';

/// 运动动作相关路由
/// 
/// 包含：动作执行、各类拉伸指引、Boss 模式等
final List<GoRoute> exerciseRoutes = [
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

  // 视觉神经重置
  GoRoute(
    path: AppRoutes.visualNeuralReset,
    builder: (context, state) => const VisualNeuralResetPage(),
  ),

  // 颈椎急救指引 (男)
  GoRoute(
    path: AppRoutes.neckFirstAid,
    builder: (context, state) => const NeckFirstAidPage(),
  ),

  // 颈椎急救 (女)
  GoRoute(
    path: AppRoutes.neckStretch,
    builder: (context, state) => const NeckStretchPage(),
  ),

  // 掌骨压力排空
  GoRoute(
    path: AppRoutes.metacarpalPressureFlush,
    builder: (context, state) => const MetacarpalPressureFlushPage(),
  ),

  // 手腕重建
  GoRoute(
    path: '/exercise/wrist_restructure',
    name: 'wristRestructure',
    builder: (context, state) => const WristRestructurePage(),
  ),

  // 臀部机能唤醒
  GoRoute(
    path: AppRoutes.gluteActivation,
    builder: (context, state) => const GluteActivationPage(),
  ),

  // 隐形练腹指引
  GoRoute(
    path: AppRoutes.stealthStomachVacuum,
    builder: (context, state) => const StealthStomachVacuumPage(),
  ),

  // 系统插件注入加载页
  GoRoute(
    path: AppRoutes.pluginInjection,
    builder: (context, state) => const PluginInjectionLoadingPage(),
  ),

  // 新功能就绪欢迎页
  GoRoute(
    path: AppRoutes.featureReadyWelcome,
    builder: (context, state) => const FeatureReadyWelcomePage(),
  ),

  // 动作推荐 (紧急抢修)
  GoRoute(
    path: AppRoutes.recoveryRecommendation,
    builder: (context, state) => const RecoveryRecommendationPage(),
  ),

  // 潜行模式 - 桌下动作指引
  GoRoute(
    path: AppRoutes.stealthSurvival,
    builder: (context, state) => const StealthSurvivalPage(),
  ),
];
