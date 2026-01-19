import 'package:flutter/material.dart';

class ComparisonCard extends StatelessWidget {
  final String phase;
  final String status;
  final Color statusColor;
  final Color borderColor;
  final Color bgColor;
  final Color gradientColor;
  final String subText1;
  final String subText2;
  final bool isLeft;
  final String imageDescription;

  const ComparisonCard({
    super.key,
    required this.phase,
    required this.status,
    required this.statusColor,
    required this.borderColor,
    required this.bgColor,
    required this.gradientColor,
    required this.subText1,
    required this.subText2,
    required this.isLeft,
    required this.imageDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        color: bgColor,
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          // 图片区域
          AspectRatio(
            aspectRatio: 4 / 5,
            child: Stack(
              children: [
                // 背景
                Container(
                  color: const Color(0xFF121212),
                  child: Center(
                    child: Icon(
                      isLeft ? Icons.warning_amber : Icons.check_circle_outline,
                      size: 80,
                      color: statusColor.withOpacity(0.3),
                    ),
                  ),
                ),
                // 渐变覆盖
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          gradientColor,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                // 状态标签
                Positioned(
                  top: 8,
                  left: isLeft ? 8 : null,
                  right: isLeft ? null : 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    color: statusColor,
                    child: Text(
                      status,
                      style: TextStyle(
                        color: isLeft ? Colors.white : Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // 信息文字
          Text(
            'Phase: $phase',
            style: TextStyle(
              color: statusColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subText1,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          Text(
            subText2,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Colors.white.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
