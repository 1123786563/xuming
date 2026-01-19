import 'package:go_router/go_router.dart';

import '../../features/claim_failed/ui/claim_failed_page.dart';
import '../../features/dashboard/ui/dashboard_page.dart';
import '../../features/mission/ui/mission_center_page.dart';
import '../../features/profile/ui/medal_wall_page.dart';
import '../../features/profile/ui/profile_page.dart';
import '../../features/reminders/ui/sedentary_reminder_page.dart';
import '../../features/share/ui/share_poster_page.dart';
import '../../features/social/ui/social_viral_page.dart';
import '../../features/statistics/ui/statistics_page.dart';
import '../../features/widget/ui/widgets_page.dart';
import 'app_router.dart';

/// 个人档案与社交相关路由
/// 
/// 包含：仪表盘、个人设置、勋章墙、统计、分享等
final List<GoRoute> profileRoutes = [
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

  // Mission Center
  GoRoute(
    path: AppRoutes.missionCenter,
    builder: (context, state) => const MissionCenterPage(),
  ),

  // 勋章墙 - 生存成就
  GoRoute(
    path: AppRoutes.medalWall,
    builder: (context, state) => const MedalWallPage(),
  ),

  // 系统档案 - 个人设置页
  GoRoute(
    path: AppRoutes.profile,
    builder: (context, state) => const ProfilePage(),
  ),

  // Widgets Preview
  GoRoute(
    path: AppRoutes.widgets,
    builder: (context, state) => const WidgetsPage(),
  ),

  // 续命保单分享海报
  GoRoute(
    path: AppRoutes.sharePoster,
    builder: (context, state) => const SharePosterPage(),
  ),
];
