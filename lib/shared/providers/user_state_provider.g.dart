// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sedentaryMonitorHash() => r'a95320ae30a855b3518541634a1e1e2d3c099b98';

/// 久坐监测服务
///
/// 监听加速计数据，如果 10 秒内位移变化极小，则视为久坐并扣除 HP
///
/// Copied from [sedentaryMonitor].
@ProviderFor(sedentaryMonitor)
final sedentaryMonitorProvider = AutoDisposeProvider<void>.internal(
  sedentaryMonitor,
  name: r'sedentaryMonitorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sedentaryMonitorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SedentaryMonitorRef = AutoDisposeProviderRef<void>;
String _$userStateNotifierHash() => r'ab3d23545de4dc4faf736bccf6034b02b16b305d';

/// 用户状态管理 Provider (使用 riverpod_generator)
///
/// 异步初始化，从 Isar 加载数据
///
/// Copied from [UserStateNotifier].
@ProviderFor(UserStateNotifier)
final userStateNotifierProvider =
    AsyncNotifierProvider<UserStateNotifier, UserState>.internal(
  UserStateNotifier.new,
  name: r'userStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userStateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserStateNotifier = AsyncNotifier<UserState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
