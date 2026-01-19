import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import '../models/user_data.dart';
import 'isar_service.dart';

/// 用户全局状态模型
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

  UserState({
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

/// 用户状态管理类
class UserStateNotifier extends StateNotifier<UserState> {
  final IsarService? _isarService;

  UserStateNotifier(this._isarService) : super(UserState()) {
    _loadFromDb();
  }

  Future<void> _loadFromDb() async {
    if (_isarService == null) return;
    final data = await _isarService!.getUserData();
    if (data != null) {
      state = UserState.fromData(data);
    }
  }

  Future<void> _saveToDb() async {
    await _isarService?.saveUserData(state.toData());
  }

  /// 设置初始 HP (基于诊断结果)
  void setInitialHp({
    required double hp,
    required double sittingHours,
    required double painLevel,
    required int selectedPosture,
  }) {
    state = state.copyWith(
      hp: hp.clamp(0.0, 100.0),
      lastDiagnosis: DateTime.now(),
      sittingHours: sittingHours,
      painLevel: painLevel,
      selectedPosture: selectedPosture,
    );
    _saveToDb();
  }

  /// 增加 HP
  void addHp(double amount) {
    state = state.copyWith(hp: (state.hp + amount).clamp(0.0, 100.0));
    _saveToDb();
  }

  /// 扣减 HP
  void reduceHp(double amount) {
    state = state.copyWith(hp: (state.hp - amount).clamp(0.0, 100.0));
    _saveToDb();
  }

  /// 增加金币
  void addCoins(int amount) {
    state = state.copyWith(coins: state.coins + amount);
    _saveToDb();
  }

  /// 消耗金币
  bool spendCoins(int amount, {String? unlockId}) {
    if (state.coins >= amount) {
      final newOwnedIds = unlockId != null 
          ? [...state.ownedIds, unlockId]
          : state.ownedIds;
          
      state = state.copyWith(
        coins: state.coins - amount,
        ownedIds: newOwnedIds,
      );
      _saveToDb();
      return true;
    }
    return false;
  }

  /// 等级提升
  void levelUp() {
    state = state.copyWith(level: state.level + 1);
    _saveToDb();
  }
}

/// 全局 Provider
final userStateProvider = StateNotifierProvider<UserStateNotifier, UserState>((ref) {
  final isarService = ref.watch(isarServiceProvider).valueOrNull;
  return UserStateNotifier(isarService);
});

/// 久坐监测服务
/// 
/// 监听加速计数据，如果 10 秒内位移变化极小，则视为久坐并扣除 HP
final sedentaryMonitorProvider = Provider<void>((ref) {
  final notifier = ref.read(userStateProvider.notifier);
  
  DateTime lastMovement = DateTime.now();
  const double moveThreshold = 0.5; // 位移判定阈值
  const Duration checkInterval = Duration(seconds: 10);
  const Duration sedentaryLimit = Duration(minutes: 30); // 暂定 30 分钟无位移触发扣减

  // 监听加速计
  final subscription = userAccelerometerEvents.listen((event) {
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
});
