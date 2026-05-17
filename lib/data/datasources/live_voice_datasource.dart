import 'dart:typed_data';

import 'package:firebase_ai/firebase_ai.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/prompt_constants.dart';

/// Wraps the Firebase AI Logic Live API: it opens a [LiveSession] with the
/// `gemini-3.1-flash-live-preview` model, streams microphone audio to it and
/// exposes the server's responses.
///
/// Authentication is handled by Firebase AI Logic — there is no API key in
/// the app. The Firebase project must have the AI Logic API enabled.
class LiveVoiceDataSource {
  LiveSession? _session;

  bool get isConnected => _session != null;

  /// Connects to the Live API and returns the stream of server responses.
  Future<Stream<LiveServerResponse>> connect() async {
    final model = FirebaseAI.googleAI().liveGenerativeModel(
      model: AppConstants.liveModel,
      systemInstruction: Content.system(PromptConstants.systemPrompt),
      liveGenerationConfig: LiveGenerationConfig(
        responseModalities: [ResponseModalities.audio],
        speechConfig: SpeechConfig(voiceName: AppConstants.voiceName),
        temperature: AppConstants.temperature,
        // Transcriptions power the on-screen transcript.
        inputAudioTranscription: AudioTranscriptionConfig(),
        outputAudioTranscription: AudioTranscriptionConfig(),
      ),
    );

    final session = await model.connect();
    _session = session;
    return session.receive();
  }

  /// Nudges God to open the conversation with a warm greeting.
  Future<void> sendOpeningCue() async {
    await _session?.send(
      input: Content.text(PromptConstants.sessionOpening),
      turnComplete: true,
    );
  }

  /// Streams one chunk of raw 16 kHz PCM microphone audio to the model.
  Future<void> sendAudioChunk(Uint8List pcmChunk) async {
    await _session?.sendAudioRealtime(
      InlineDataPart(AppConstants.inputAudioMime, pcmChunk),
    );
  }

  /// Closes the WebSocket session.
  Future<void> close() async {
    final session = _session;
    _session = null;
    await session?.close();
  }
}
