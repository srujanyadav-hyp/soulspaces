/// The lifecycle phase of a live voice conversation with God.
enum LivePhase {
  /// No active session — the opening screen.
  idle,

  /// Establishing the WebSocket connection to the Live API.
  connecting,

  /// Session is live; the microphone is open and God is listening.
  listening,

  /// God is speaking — audio is playing back to the child.
  speaking,

  /// The session failed or was lost.
  error,
}
