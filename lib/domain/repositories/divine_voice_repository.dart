import '../entities/divine_state.dart';

/// Contract for a live, voice-to-voice spiritual conversation with God,
/// powered by the Gemini Live API.
abstract class DivineVoiceRepository {
  /// A broadcast stream of conversation state snapshots.
  Stream<DivineState> get stateStream;

  /// The latest state snapshot.
  DivineState get currentState;

  /// Opens the microphone, connects to the Live API and begins the
  /// conversation.
  Future<void> startConversation();

  /// Ends the active conversation and releases the microphone and socket.
  Future<void> endConversation();

  /// Releases all resources. The repository cannot be reused afterwards.
  Future<void> dispose();
}
