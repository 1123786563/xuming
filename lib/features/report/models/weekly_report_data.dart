/// 生存维度数据
class SurvivalRadarData {
  final double neckIntegrity; // 颈椎完整度
  final double lumbarPressure; // 腰椎压力值
  final double activityFrequency; // 活动频率
  final double slackingSkills; // 摸鱼技巧
  final double vitalSigns; // 生命体征

  const SurvivalRadarData({
    required this.neckIntegrity,
    required this.lumbarPressure,
    required this.activityFrequency,
    required this.slackingSkills,
    required this.vitalSigns,
  });

  List<double> toList() => [
    neckIntegrity,
    lumbarPressure,
    activityFrequency,
    slackingSkills,
    vitalSigns,
  ];
}

/// 周报数据模型
class WeeklyReportData {
  final int weekNumber; // 周数
  final String grade; // 评估等级 (B+, A-, etc.)
  final int efficiencyChange; // 效率变化百分比 (+5, -2, etc.)
  final SurvivalRadarData radarData; // 雷达图数据
  final int survivalMinutes; // 续命时长
  final int evadedAttacks; // 规避核击次数
  final int rankPercentile; // 排名百分比 (5 means TOP 5%)
  final String warningTitle; // 警告标题
  final String warningDescription; // 警告文案
  final String analysisId; // 分析 ID

  const WeeklyReportData({
    required this.weekNumber,
    required this.grade,
    required this.efficiencyChange,
    required this.radarData,
    required this.survivalMinutes,
    required this.evadedAttacks,
    required this.rankPercentile,
    required this.warningTitle,
    required this.warningDescription,
    required this.analysisId,
  });

  /// Mock 一个默认展示数据 (对应设计稿)
  factory WeeklyReportData.mock() {
    return const WeeklyReportData(
      weekNumber: 42,
      grade: 'B+',
      efficiencyChange: 5,
      radarData: SurvivalRadarData(
        neckIntegrity: 0.8,
        lumbarPressure: 0.7,
        activityFrequency: 0.6,
        slackingSkills: 0.65,
        vitalSigns: 0.75,
      ),
      survivalMinutes: 185,
      evadedAttacks: 12,
      rankPercentile: 5,
      warningTitle: '脊柱状态异常侦测',
      warningDescription: '"You survived another week of corporate slavery. Don\'t be too proud; your spine is still a question mark."',
      analysisId: '99x_FATAL',
    );
  }
}
