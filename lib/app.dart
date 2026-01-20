import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'shared/providers/user_state_provider.dart';

/// 续命 App 主组件
class XuMingApp extends ConsumerWidget {
  const XuMingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 启动后台服务
    ref.watch(sedentaryMonitorProvider);

    final router = ref.watch(appRouterProvider);
    
    return MaterialApp.router(
      title: '续命 XuMing',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
