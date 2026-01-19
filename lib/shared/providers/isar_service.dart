import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user_data.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [UserDataSchema],
        directory: dir.path,
      );
    }
    return Isar.getInstance()!;
  }

  /// 获取唯一的运行档案数据
  Future<UserData?> getUserData() async {
    final isar = await db;
    return await isar.userDatas.where().findFirst();
  }

  /// 保存或更新档案数据
  Future<void> saveUserData(UserData data) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.userDatas.put(data);
    });
  }
}

final isarServiceProvider = FutureProvider<IsarService>((ref) async {
  return IsarService();
});
