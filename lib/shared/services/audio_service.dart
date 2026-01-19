import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 统一音频管理服务
/// 
/// 负责播放应用内的所有音效，包括 ASMR 反馈、系统警报和背景音。
/// 采用 fire-and-forget 模式，不在此处处理复杂的播放状态，
/// 仅提供简单的 API 给 UI 层调用。
class AudioService {
  final AudioPlayer _sfxPlayer = AudioPlayer();
  final AudioPlayer _ambiencePlayer = AudioPlayer();

  // 音频资源路径
  static const String _boneClickPath = 'audio/bone_click.mp3';
  static const String _scanPath = 'audio/cyber_scan.mp3';
  static const String _alertPath = 'audio/alert.mp3';
  static const String _ambiencePath = 'audio/ambience_loop.mp3';
  static const String _completePath = 'audio/complete.mp3';

  AudioService() {
    // 设置音频上下文配置，如需要混合播放等
    _sfxPlayer.setReleaseMode(ReleaseMode.stop);
    _ambiencePlayer.setReleaseMode(ReleaseMode.loop);
  }

  /// 播放骨骼复位 ASMR 音效
  Future<void> playBoneClick() async {
    try {
      // 每次点击都重新播放，允许重叠或打断视需求而定，这里使用这就停止上一个
      await _sfxPlayer.stop(); 
      await _sfxPlayer.play(AssetSource(_boneClickPath));
    } catch (e) {
      // 忽略音频播放错误，避免影响主流程
      print('Audio Error: $e');
    }
  }

  /// 播放系统扫描音效
  Future<void> playScan() async {
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource(_scanPath), volume: 0.5);
    } catch (e) {
      print('Audio Error: $e');
    }
  }

  /// 播放警报音效
  Future<void> playAlert() async {
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource(_alertPath));
    } catch (e) {
      print('Audio Error: $e');
    }
  }

  /// 播放任务完成音效
  Future<void> playComplete() async {
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource(_completePath));
    } catch (e) {
      print('Audio Error: $e');
    }
  }

  /// 开始播放背景氛围音 (循环)
  Future<void> startAmbience() async {
    try {
      if (_ambiencePlayer.state != PlayerState.playing) {
        await _ambiencePlayer.play(AssetSource(_ambiencePath), volume: 0.3);
      }
    } catch (e) {
      print('Audio Error: $e');
    }
  }

  /// 停止背景氛围音
  Future<void> stopAmbience() async {
    try {
      await _ambiencePlayer.stop();
    } catch (e) {
      print('Audio Error: $e');
    }
  }

  void dispose() {
    _sfxPlayer.dispose();
    _ambiencePlayer.dispose();
  }
}

/// 全局 AudioService Provider
final audioServiceProvider = Provider<AudioService>((ref) {
  final service = AudioService();
  ref.onDispose(() => service.dispose());
  return service;
});
