import 'package:go_router/go_router.dart';
import 'app_router.dart';
import '../../features/splash/ui/splash_page.dart';
import '../../features/onboarding/ui/login_page.dart';
import '../../features/onboarding/ui/diagnostic_page.dart';

/// 认证相关路由
/// 
/// 包含：启动页、登录页、诊断页
final List<GoRoute> authRoutes = [
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
];
