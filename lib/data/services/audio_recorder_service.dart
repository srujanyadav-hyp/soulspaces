import 'dart:typed_data';

import 'package:record/record.dart';

/// Captures microphone audio as a raw 16-bit PCM stream (mono) — the input
/// format required by the Gemini Live API. Built on the `record` package.
class AudioRecorderService {
  final AudioRecorder _recorder = AudioRecorder();

  /// Checks for microphone permission, requesting it if not yet granted.
  Future<bool> hasPermission() => _recorder.hasPermission();

  /// Starts capturing and returns the raw PCM byte stream at [sampleRate].
  Future<Stream<Uint8List>> startStream(int sampleRate) {
    return _recorder.startStream(
      RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        sampleRate: sampleRate,
        numChannels: 1,
        // Reduce the model hearing its own voice through the speaker.
        echoCancel: true,
        noiseSuppress: true,
        autoGain: true,
      ),
    );
  }

  Future<bool> isRecording() => _recorder.isRecording();

  /// Stops the current capture session.
  Future<void> stop() => _recorder.stop();

  /// Releases the recorder. Call once, when the service is no longer needed.
  Future<void> dispose() => _recorder.dispose();
}
