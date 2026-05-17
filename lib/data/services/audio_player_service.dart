import 'package:flutter/foundation.dart';
import 'package:flutter_pcm_sound/flutter_pcm_sound.dart';

/// Plays the raw 16-bit PCM audio streamed back by the Gemini Live API
/// (mono, little-endian). Built on `flutter_pcm_sound`.
///
/// All methods are defensive: failures are logged, never thrown, so the
/// conversation flow is never broken by a playback hiccup.
class AudioPlayerService {
  bool _isSetup = false;
  int _sampleRate = 24000;

  /// Invoked when the playback buffer fully drains (God stopped speaking).
  void Function()? onPlaybackDrained;

  /// Configures the native player for [sampleRate] Hz mono playback.
  Future<void> initialize(int sampleRate) async {
    _sampleRate = sampleRate;
    try {
      await FlutterPcmSound.setLogLevel(LogLevel.error);
      await FlutterPcmSound.setup(sampleRate: sampleRate, channelCount: 1);
      await FlutterPcmSound.setFeedThreshold(sampleRate ~/ 10); // ~100 ms
      FlutterPcmSound.setFeedCallback(_onFeed);
      _isSetup = true;
    } catch (e) {
      debugPrint('AudioPlayerService.initialize failed: $e');
    }
  }

  void _onFeed(int remainingFrames) {
    if (remainingFrames == 0) onPlaybackDrained?.call();
  }

  /// Queues a chunk of raw PCM16 little-endian audio for playback.
  Future<void> play(Uint8List pcmBytes) async {
    if (!_isSetup || pcmBytes.isEmpty) return;
    try {
      await FlutterPcmSound.feed(
        PcmArrayInt16(bytes: ByteData.sublistView(pcmBytes)),
      );
    } catch (e) {
      debugPrint('AudioPlayerService.play failed: $e');
    }
  }

  /// Immediately discards any audio still queued — used when the child
  /// interrupts God mid-sentence (barge-in).
  Future<void> clear() async {
    if (!_isSetup) return;
    try {
      await FlutterPcmSound.release();
      await FlutterPcmSound.setup(
        sampleRate: _sampleRate,
        channelCount: 1,
      );
      await FlutterPcmSound.setFeedThreshold(_sampleRate ~/ 10);
    } catch (e) {
      debugPrint('AudioPlayerService.clear failed: $e');
    }
  }

  /// Stops playback and releases native resources at the end of a session.
  Future<void> stop() async {
    if (!_isSetup) return;
    _isSetup = false;
    try {
      await FlutterPcmSound.release();
    } catch (e) {
      debugPrint('AudioPlayerService.stop failed: $e');
    }
  }

  /// Releases the player permanently.
  Future<void> dispose() async {
    FlutterPcmSound.setFeedCallback(null);
    onPlaybackDrained = null;
    await stop();
  }
}
