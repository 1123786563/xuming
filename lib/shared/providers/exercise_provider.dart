import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/exercise_model.dart';
import 'user_state_provider.dart';

/// 动作推荐 Provider
/// 
/// 根据 UserState 中的诊断细节筛选最合适的动作
final exerciseRecommendationProvider = Provider<List<ExerciseProtocol>>((ref) {
  final userStateAsync = ref.watch(userStateNotifierProvider);
  final userState = userStateAsync.valueOrNull ?? const UserState();
  
  if (userState.lastDiagnosis == null) {
    return allProtocols.take(3).toList();
  }

  // 排序逻辑：
  // 1. 匹配选定姿势的项目优先
  // 2. 如果疼痛等级高，优先推荐恢复性强的 (category == STRUCTURAL_REPAIR)
  
  final recommendations = allProtocols.toList();
  
  recommendations.sort((a, b) {
    // 计算 a 的得分
    int scoreA = 0;
    if (a.targetPostures.contains(userState.selectedPosture)) scoreA += 10;
    if (userState.painLevel > 3 && a.category == 'STRUCTURAL_REPAIR') scoreA += 5;
    
    // 计算 b 的得分
    int scoreB = 0;
    if (b.targetPostures.contains(userState.selectedPosture)) scoreB += 10;
    if (userState.painLevel > 3 && b.category == 'STRUCTURAL_REPAIR') scoreB += 5;
    
    return scoreB.compareTo(scoreA); // 降序
  });

  return recommendations;
});

/// 获取当前的第一个推荐动作
final topRecommendationProvider = Provider<ExerciseProtocol>((ref) {
  final list = ref.watch(exerciseRecommendationProvider);
  return list.first;
});
