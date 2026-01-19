import 'package:go_router/go_router.dart';

import '../../features/reward/ui/coin_injection_page.dart';
import '../../features/reward/ui/hp_recovery_success_page.dart';
import '../../features/shop/ui/shop_page.dart';
import '../../features/shop/ui/special_offer_detail_page.dart';
import 'app_router.dart';

/// 商店与奖励相关路由
/// 
/// 包含：续命商店、限时特惠、金币注入、HP 恢复成功等
final List<GoRoute> shopRoutes = [
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

  // 金币注入特效页
  GoRoute(
    path: AppRoutes.coinInjection,
    builder: (context, state) => const CoinInjectionPage(),
  ),

  // 生命值回复成功页
  GoRoute(
    path: AppRoutes.hpRecoverySuccess,
    builder: (context, state) => const HpRecoverySuccessPage(),
  ),
];
