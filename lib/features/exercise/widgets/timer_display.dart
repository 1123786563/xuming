import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// 计时器显示组件
/// 
/// 独立的计时器 UI，使用 AnimationController 实现 VSync 同步刷新
/// 避免整个页面因计时器更新而重建
class TimerDisplay extends StatefulWidget {
  final int durationSeconds;
  final Color themeColor;
  final VoidCallback onComplete;
  final ValueChanged<double>? onProgress;

  const TimerDisplay({
    super.key,
    required this.durationSeconds,
    this.themeColor = AppColors.lifeSignal,
    required this.onComplete,
    this.onProgress,
  });

  @override
  State<TimerDisplay> createState() => TimerDisplayState();
}

class TimerDisplayState extends State<TimerDisplay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  int get remainingSeconds {
    final elapsed = _controller.value * widget.durationSeconds;
    return (widget.durationSeconds - elapsed).ceil();
  }
  
  int get hundredths {
    final elapsed = _controller.value * widget.durationSeconds;
    final fraction = elapsed - elapsed.floor();
    return ((1.0 - fraction) * 100).floor() % 100;
  }
  
  double get progress => _controller.value;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationSeconds),
    );
    
    _controller.addListener(() {
      // 使用 setState 触发自身重建，不影响父组件
      if (mounted) setState(() {});
      widget.onProgress?.call(_controller.value);
    });
    
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    });
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  /// 立即完成计时
  void skip() {
    _controller.stop();
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    final seconds = remainingSeconds.clamp(0, widget.durationSeconds);
    final hs = hundredths.clamp(0, 99);
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              "00:${seconds.toString().padLeft(2, '0')}",
              style: const TextStyle(
                color: Colors.white, 
                fontSize: 60, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              hs.toString().padLeft(2, '0'),
              style: TextStyle(
                color: widget.themeColor.withOpacity(0.8), 
                fontSize: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
