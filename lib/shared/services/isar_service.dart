import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/user_data.dart';

/// Isar 数据库服务
/// 负责本地数据的持久化存储
class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = _initDb();
  }

  Future<Isar> _initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [UserDataSchema],
        directory: dir.path,
        inspector: true, // 开启 Isar Inspector 方便调试
      );
    }
    return Future.value(Isar.getInstance());
  }

  /// 获取当前用户数据
  /// 如果数据库为空，则创建一个默认用户
  Future<UserData?> getUserData() async {
    final isar = await db;
    final data = await isar.userDatas.where().findFirst();
    
    if (data == null) {
      // 初始化默认数据
      final newUser = UserData();
      await isar.writeTxn(() async {
        await isar.userDatas.put(newUser);
      });
      return newUser;
    }
    return data;
  }

  /// 保存用户数据
  Future<void> saveUserData(UserData data) async {
    final isar = await db;
    data.updatedAt = DateTime.now();
    await isar.writeTxn(() async {
      await isar.userDatas.put(data);
    });
  }

  /// 监听用户数据变化流
  Stream<UserData?> watchUserData() async* {
    final isar = await db;
    yield* isar.userDatas.where().watch(fireImmediately: true).map((events) {
       // watch 返回的是列表，我们需要单个用户数据
       // 这里简单处理，取第一个或空
       return events.isNotEmpty ? events.first : null;
    });
  }
}

/// 全局 Isar 服务 Provider
final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService();
});
