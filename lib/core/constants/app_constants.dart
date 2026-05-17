/// Static configuration for the Gemini Live API voice experience.
///
/// The app is a hands-free, voice-to-voice conversation: the child speaks
/// in Telugu and God (the Heavenly Father) replies in Telugu, in real time,
/// over a single WebSocket — no device speech-to-text or text-to-speech.
class AppConstants {
  const AppConstants._();

  /// The Gemini Live audio-to-audio model (released March 2026).
  /// https://ai.google.dev/gemini-api/docs/models/gemini-3.1-flash-live-preview
  static const String liveModel = 'gemini-3.1-flash-live-preview';

  /// Prebuilt voice for God's responses — a calm, deep, fatherly timbre.
  /// Alternatives: 'Puck', 'Kore', 'Aoede', 'Fenrir', 'Orus'.
  /// https://cloud.google.com/text-to-speech/docs/chirp3-hd
  static const String voiceName = 'Charon';

  /// Sampling temperature. Kept low so the model stays grounded in real
  /// Scripture and never invents Bible stories.
  static const double temperature = 0.4;

  /// Microphone capture rate required by the Live API: raw 16-bit PCM, mono.
  static const int inputSampleRate = 16000;

  /// Playback rate of the model's audio output: raw 16-bit PCM, mono.
  static const int outputSampleRate = 24000;

  /// MIME type for the realtime audio chunks sent to the Live API.
  static const String inputAudioMime = 'audio/pcm;rate=16000';

  /// App display name — "Divine Word".
  static const String appTitle = 'దైవ వాక్యం';
}
