/// Who spoke a given line in the conversation.
enum Speaker { child, god }

/// A single spoken turn, reconstructed from the Live API's audio
/// transcriptions. Used only for the on-screen transcript — the real
/// experience is the voice itself.
class ConversationTurn {
  const ConversationTurn({
    required this.speaker,
    required this.text,
    this.isFinal = false,
  });

  final Speaker speaker;
  final String text;

  /// Whether the transcription for this turn is complete.
  final bool isFinal;

  ConversationTurn copyWith({String? text, bool? isFinal}) => ConversationTurn(
        speaker: speaker,
        text: text ?? this.text,
        isFinal: isFinal ?? this.isFinal,
      );
}
