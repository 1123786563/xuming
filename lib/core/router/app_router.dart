import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/ui/splash_page.dart';
import '../../features/onboarding/ui/login_page.dart';
import '../../features/onboarding/ui/diagnostic_page.dart';
import '../../features/dashboard/ui/dashboard_page.dart';

/// 路由路径常量
class AppRoutes {
  AppRoutes._();
  
  static const String splash = '/';
  static const String login = '/login';
  static const String diagnostic = '/diagnostic';
  static const String dashboard = '/dashboard';
  static const String exercise = '/exercise';
  static const String store = '/store';
  static const String profile = '/profile';
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
      
      // TODO: 添加更多路由
    ],
  );
});
