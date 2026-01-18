import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/cyber_button.dart';
import '../../../shared/widgets/grid_background.dart';

/// 压力释放对比报告页
class PressureReportPage extends StatelessWidget {
  const PressureReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          const GridBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildComparisonView()),
                _buildImpactStats(),
                _buildFooterActions(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text("POST_MAINTENANCE_LOG", style: TextStyle(color: AppColors.lifeSignal, letterSpacing: 4, fontSize: 10, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("压力释放对比报告", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildComparisonView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: _buildModelCard("REPAIR_BEFORE", AppColors.nuclearWarning, "压力极高"),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.double_arrow, color: AppColors.lifeSignal),
          const SizedBox(width: 16),
          Expanded(
            child: _buildModelCard("REPAIR_AFTER", AppColors.lifeSignal, "压力已释放"),
          ),
        ],
      ),
    );
  }

  Widget _buildModelCard(String label, Color color, String status) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold)),
          const Spacer(),
          Icon(Icons.accessibility_new, size: 100, color: color.withOpacity(0.6)),
          const Spacer(),
          Text(status, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildImpactStats() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.lifeSignal.withOpacity(0.1),
          border: Border.all(color: AppColors.lifeSignal),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text("压力指数下降", style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 4),
                Text("-42%", style: TextStyle(color: AppColors.lifeSignal, fontSize: 32, fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                Text("获得续命币", style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 4),
                Text("+15", style: TextStyle(color: AppColors.lifeSignal, fontSize: 32, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: CyberButton(
        text: "返回生命仪表盘",
        onPressed: () => context.go(AppRoutes.dashboard),
        color: AppColors.lifeSignal,
      ),
    );
  }
}
