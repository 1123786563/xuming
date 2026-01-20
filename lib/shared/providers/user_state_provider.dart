import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import '../models/user_data.dart';
import '../services/isar_service.dart';

part 'user_state_provider.g.dart';

/// 用户全局状态模型 (Immutable)
class UserState {
  final double hp;          // 0-100
  final int coins;          // 续命币
  final int level;          // 用户等级
  final DateTime? lastDiagnosis;
  
  // 诊断细节
  final double sittingHours;
  final double painLevel;
  final int selectedPosture;
  final List<String> ownedIds; // 已解锁的动作 ID 或资源 ID

  const UserState({
    this.hp = 100,
    this.coins = 0,
    this.level = 1,
    this.lastDiagnosis,
    this.sittingHours = 0,
    this.painLevel = 0,
    this.selectedPosture = 0,
    this.ownedIds = const ['SPINE_ALIGN'], // 默认拥有基础款
  });

  UserState copyWith({
    double? hp,
    int? coins,
    int? level,
    DateTime? lastDiagnosis,
    double? sittingHours,
    double? painLevel,
    int? selectedPosture,
    List<String>? ownedIds,
  }) {
    return UserState(
      hp: hp ?? this.hp,
      coins: coins ?? this.coins,
      level: level ?? this.level,
      lastDiagnosis: lastDiagnosis ?? this.lastDiagnosis,
      sittingHours: sittingHours ?? this.sittingHours,
      painLevel: painLevel ?? this.painLevel,
      selectedPosture: selectedPosture ?? this.selectedPosture,
      ownedIds: ownedIds ?? this.ownedIds,
    );
  }

  /// 转换为 Isar 模型
  UserData toData() {
    return UserData()
      ..hp = hp
      ..coins = coins
      ..level = level
      ..lastDiagnosis = lastDiagnosis
      ..sittingHours = sittingHours
      ..painLevel = painLevel
      ..selectedPosture = selectedPosture
      ..ownedIds = ownedIds;
  }

  /// 从 Isar 模型转换
  factory UserState.fromData(UserData data) {
    return UserState(
      hp: data.hp,
      coins: data.coins,
      level: data.level,
      lastDiagnosis: data.lastDiagnosis,
      sittingHours: data.sittingHours,
      painLevel: data.painLevel,
      selectedPosture: data.selectedPosture,
      ownedIds: data.ownedIds,
    );
  }
}

/// 用户状态管理 Provider (使用 riverpod_generator)
/// 
/// 异步初始化，从 Isar 加载数据
@Riverpod(keepAlive: true)
class UserStateNotifier extends _$UserStateNotifier {
  IsarService? _isarService;

  @override
  Future<UserState> build() async {
    _isarService = ref.watch(isarServiceProvider);
    return _loadFromDb();
  }

  Future<UserState> _loadFromDb() async {
    if (_isarService == null) return const UserState();
    final data = await _isarService!.getUserData();
    if (data != null) {
      return UserState.fromData(data);
    }
    return const UserState();
  }

  Future<void> _saveToDb(UserState newState) async {
    await _isarService?.saveUserData(newState.toData());
  }

  /// 设置初始 HP (基于诊断结果)
  Future<void> setInitialHp({
    required double hp,
    required double sittingHours,
    required double painLevel,
    required int selectedPosture,
  }) async {
    final currentState = state.valueOrNull ?? const UserState();
    final newState = currentState.copyWith(
      hp: hp.clamp(0.0, 100.0),
      lastDiagnosis: DateTime.now(),
      sittingHours: sittingHours,
      painLevel: painLevel,
      selectedPosture: selectedPosture,
    );
    state = AsyncData(newState);
    await _saveToDb(newState);
  }

  /// 增加 HP
  Future<void> addHp(double amount) async {
    final currentState = state.valueOrNull ?? const UserState();
    final newState = currentState.copyWith(hp: (currentState.hp + amount).clamp(0.0, 100.0));
    state = AsyncData(newState);
    await _saveToDb(newState);
  }

  /// 扣减 HP
  Future<void> reduceHp(double amount) async {
    final currentState = state.valueOrNull ?? const UserState();
    final newState = currentState.copyWith(hp: (currentState.hp - amount).clamp(0.0, 100.0));
    state = AsyncData(newState);
    await _saveToDb(newState);
  }

  /// 增加金币
  Future<void> addCoins(int amount) async {
    final currentState = state.valueOrNull ?? const UserState();
    final newState = currentState.copyWith(coins: currentState.coins + amount);
    state = AsyncData(newState);
    await _saveToDb(newState);
  }

  /// 消耗金币
  Future<bool> spendCoins(int amount, {String? unlockId}) async {
    final currentState = state.valueOrNull ?? const UserState();
    if (currentState.coins >= amount) {
      final newOwnedIds = unlockId != null 
          ? [...currentState.ownedIds, unlockId]
          : currentState.ownedIds;
          
      final newState = currentState.copyWith(
        coins: currentState.coins - amount,
        ownedIds: newOwnedIds,
      );
      state = AsyncData(newState);
      await _saveToDb(newState);
      return true;
    }
    return false;
  }

  /// 等级提升
  Future<void> levelUp() async {
    final currentState = state.valueOrNull ?? const UserState();
    final newState = currentState.copyWith(level: currentState.level + 1);
    state = AsyncData(newState);
    await _saveToDb(newState);
  }
}

/// 久坐监测服务
/// 
/// 监听加速计数据，如果 10 秒内位移变化极小，则视为久坐并扣除 HP
@riverpod
void sedentaryMonitor(SedentaryMonitorRef ref) {
  final notifier = ref.read(userStateNotifierProvider.notifier);
  
  DateTime lastMovement = DateTime.now();
  const double moveThreshold = 0.5; // 位移判定阈值
  const Duration checkInterval = Duration(seconds: 10);
  const Duration sedentaryLimit = Duration(minutes: 30); // 暂定 30 分钟无位移触发扣减

  // 监听加速计
  final subscription = userAccelerometerEventStream().listen((event) {
    // 计算位移矢量模长
    final double magnitude = (event.x.abs() + event.y.abs() + event.z.abs());
    
    if (magnitude > moveThreshold) {
      lastMovement = DateTime.now();
    }
  });

  // 定时检查久坐状态
  final timer = Timer.periodic(checkInterval, (timer) {
    final now = DateTime.now();
    final idleDuration = now.difference(lastMovement);
    
    if (idleDuration > sedentaryLimit) {
      // 模拟久坐损耗：每 10 秒减少 0.1%
      notifier.reduceHp(0.1);
    }
  });
  
  ref.onDispose(() {
    subscription.cancel();
    timer.cancel();
  });
}