import 'conversation_turn.dart';
import 'live_phase.dart';

/// An immutable snapshot of the live conversation, emitted by the
/// [DivineVoiceRepository] whenever the phase or transcript changes.
class DivineState {
  const DivineState({
    this.phase = LivePhase.idle,
    this.transcript = const [],
    this.errorMessage,
  });

  /// Current lifecycle phase.
  final LivePhase phase;

  /// The conversation so far (best-effort transcription).
  final List<ConversationTurn> transcript;

  /// A human-readable error message, set only when [phase] is
  /// [LivePhase.error].
  final String? errorMessage;

  /// Whether a live session is currently running.
  bool get isSessionActive =>
      phase == LivePhase.listening || phase == LivePhase.speaking;
}
