import 'package:isar/isar.dart';

part 'user_data.g.dart';

@collection
class UserData {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? userId; // 可选，预留给多账户支持

  double hp = 100.0;
  int coins = 0;
  int level = 1;

  DateTime? lastDiagnosis;
  double sittingHours = 0.0;
  double painLevel = 0.0;
  int selectedPosture = 0;

  List<String> ownedIds = ['SPINE_ALIGN'];

  DateTime updatedAt = DateTime.now();
}
