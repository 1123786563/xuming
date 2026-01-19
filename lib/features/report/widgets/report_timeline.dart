import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ReportTimeline extends StatelessWidget {
  final List<TimelineEvent> events;

  const ReportTimeline({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: events.map((e) => _buildTimelineItem(e)).toList(),
      ),
    );
  }

  Widget _buildTimelineItem(TimelineEvent event) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 左侧图标和连接线
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(
                  color: event.isHighlighted 
                      ? AppColors.primary 
                      : AppColors.primary.withOpacity(0.3),
                ),
                color: AppColors.primary.withOpacity(0.1),
                boxShadow: event.isHighlighted ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 10,
                  ),
                ] : null,
              ),
              child: Icon(
                event.icon,
                size: 12,
                color: AppColors.primary,
              ),
            ),
            if (event.hasLine)
              Container(
                width: 1,
                height: 32,
                color: AppColors.primary.withOpacity(0.2),
              ),
          ],
        ),
        const SizedBox(width: 16),
        // 右侧文字
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: event.hasLine ? 16 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: event.isHighlighted 
                        ? AppColors.primary 
                        : Colors.white.withOpacity(0.8),
                    fontStyle: event.isHighlighted ? FontStyle.italic : FontStyle.normal,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  event.time,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: event.isHighlighted 
                        ? Colors.white.withOpacity(0.4) 
                        : AppColors.primary.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TimelineEvent {
  final IconData icon;
  final String title;
  final String time;
  final bool isHighlighted;
  final bool hasLine;

  TimelineEvent({
    required this.icon,
    required this.title,
    required this.time,
    required this.isHighlighted,
    required this.hasLine,
  });
}
