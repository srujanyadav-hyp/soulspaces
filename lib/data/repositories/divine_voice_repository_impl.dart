import 'dart:async';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/foundation.dart';

import '../../core/constants/app_constants.dart';
import '../../domain/entities/conversation_turn.dart';
import '../../domain/entities/divine_state.dart';
import '../../domain/entities/live_phase.dart';
import '../../domain/repositories/divine_voice_repository.dart';
import '../datasources/live_voice_datasource.dart';
import '../services/audio_player_service.dart';
import '../services/audio_recorder_service.dart';

/// Orchestrates the live conversation: pipes microphone audio into the Live
/// API, plays God's audio back, tracks the conversation phase and builds a
/// best-effort transcript.
class DivineVoiceRepositoryImpl implements DivineVoiceRepository {
  DivineVoiceRepositoryImpl({
    required LiveVoiceDataSource dataSource,
    required AudioRecorderService recorder,
    required AudioPlayerService player,
  })  : _dataSource = dataSource,
        _recorder = recorder,
        _player = player {
    _player.onPlaybackDrained = _handlePlaybackDrained;
  }

  final LiveVoiceDataSource _dataSource;
  final AudioRecorderService _recorder;
  final AudioPlayerService _player;

  final StreamController<DivineState> _stateController =
      StreamController<DivineState>.broadcast();

  // Mutable state, published as immutable DivineState snapshots.
  LivePhase _phase = LivePhase.idle;
  String? _error;
  final List<ConversationTurn> _transcript = [];
  DivineState _state = const DivineState();

  StreamSubscription<Uint8List>? _micSubscription;
  StreamSubscription<LiveServerResponse>? _serverSubscription;

  /// Set when the model signals its turn is finished, so the
  /// playback-drained callback knows it can return to the listening phase.
  bool _godTurnComplete = false;

  /// True once the model sends any content — distinguishes a real
  /// conversation end from a session the server rejected on connect.
  bool _receivedServerContent = false;

  @override
  Stream<DivineState> get stateStream => _stateController.stream;

  @override
  DivineState get currentState => _state;

  void _publish() {
    _state = DivineState(
      phase: _phase,
      transcript: List.unmodifiable(_transcript),
      errorMessage: _error,
    );
    if (!_stateController.isClosed) _stateController.add(_state);
  }

  // --- Session control --------------------------------------------------

  @override
  Future<void> startConversation() async {
    if (_phase != LivePhase.idle && _phase != LivePhase.error) return;

    _transcript.clear();
    _godTurnComplete = false;
    _receivedServerContent = false;
    _error = null;
    _phase = LivePhase.connecting;
    _publish();

    try {
      if (!await _recorder.hasPermission()) {
        _fail('మైక్రోఫోన్ అనుమతి అవసరం. దయచేసి అనుమతించి మళ్లీ ప్రయత్నించండి.');
        return;
      }

      await _player.initialize(AppConstants.outputSampleRate);

      final serverStream = await _dataSource.connect();
      if (_phase != LivePhase.connecting) return _teardown();
      _serverSubscription = serverStream.listen(
        _handleServerResponse,
        onError: _handleServerError,
        onDone: _handleServerDone,
      );

      final micStream =
          await _recorder.startStream(AppConstants.inputSampleRate);
      if (_phase != LivePhase.connecting) return _teardown();
      _micSubscription = micStream.listen(
        _sendMicChunk,
        onError: (Object e) => debugPrint('Mic stream error: $e'),
      );

      await _dataSource.sendOpeningCue();

      // Only promote to listening if nothing else changed the phase
      // (an early server error, or the child speaking immediately).
      if (_phase == LivePhase.connecting) {
        _phase = LivePhase.listening;
        _publish();
      }
    } catch (e) {
      debugPrint('startConversation failed: $e');
      await _teardown();
      _fail('దేవునితో అనుసంధానం విఫలమైంది. దయచేసి మళ్లీ ప్రయత్నించండి.');
    }
  }

  @override
  Future<void> endConversation() async {
    await _teardown();
    _transcript.clear();
    _godTurnComplete = false;
    _error = null;
    _phase = LivePhase.idle;
    _publish();
  }

  @override
  Future<void> dispose() async {
    await _teardown();
    await _recorder.dispose();
    await _player.dispose();
    await _stateController.close();
  }

  void _sendMicChunk(Uint8List chunk) {
    _dataSource.sendAudioChunk(chunk).catchError((Object e) {
      debugPrint('sendAudioChunk failed: $e');
    });
  }

  void _fail(String message) {
    _error = message;
    _phase = LivePhase.error;
    _publish();
  }

  /// Cancels subscriptions and releases the socket, mic and player.
  /// Safe to call repeatedly and never throws.
  Future<void> _teardown() async {
    try {
      await _micSubscription?.cancel();
    } catch (_) {}
    _micSubscription = null;
    try {
      await _serverSubscription?.cancel();
    } catch (_) {}
    _serverSubscription = null;
    try {
      await _recorder.stop();
    } catch (_) {}
    try {
      await _dataSource.close();
    } catch (_) {}
    try {
      await _player.stop();
    } catch (_) {}
  }

  // --- Server message handling -----------------------------------------

  void _handleServerResponse(LiveServerResponse response) {
    final message = response.message;
    if (message is LiveServerContent) {
      _handleServerContent(message);
    } else if (message is GoingAwayNotice) {
      debugPrint('Live session going away: ${message.timeLeft}');
    }
  }

  void _handleServerContent(LiveServerContent content) {
    _receivedServerContent = true;

    // Barge-in: the child started speaking over God.
    if (content.interrupted == true) {
      _player.clear();
      _godTurnComplete = true;
      _finalizeLastTurn();
      if (_phase == LivePhase.speaking) _phase = LivePhase.listening;
      _publish();
      return;
    }

    var changed = false;

    // Audio output from God.
    final modelTurn = content.modelTurn;
    if (modelTurn != null) {
      for (final part in modelTurn.parts) {
        if (part is InlineDataPart && part.mimeType.startsWith('audio/')) {
          _player.play(part.bytes);
          if (_phase != LivePhase.speaking) {
            _godTurnComplete = false;
            _phase = LivePhase.speaking;
            changed = true;
          }
        }
      }
    }

    // Transcriptions — best-effort, for the on-screen transcript only.
    final childText = content.inputTranscription?.text;
    if (childText != null && childText.isNotEmpty) {
      _appendTranscript(Speaker.child, childText);
      changed = true;
    }
    final godText = content.outputTranscription?.text;
    if (godText != null && godText.isNotEmpty) {
      _appendTranscript(Speaker.god, godText);
      changed = true;
    }

    if (content.turnComplete == true) {
      _godTurnComplete = true;
      _finalizeLastTurn();
      changed = true;
    }

    if (changed) _publish();
  }

  /// God's audio finished playing — return to listening once the turn is
  /// also logically complete.
  void _handlePlaybackDrained() {
    if (_godTurnComplete && _phase == LivePhase.speaking) {
      _phase = LivePhase.listening;
      _publish();
    }
  }

  void _handleServerError(Object error, StackTrace stackTrace) {
    debugPrint('Live server error: $error');
    _teardown();
    _fail(_friendlyError(error));
  }

  void _handleServerDone() {
    // The socket closed. If the model never sent anything the server
    // rejected the session (e.g. the model is unavailable to this
    // project); otherwise it is a normal end such as the time limit.
    if (_phase == LivePhase.idle || _phase == LivePhase.error) return;
    _teardown();
    if (_receivedServerContent) {
      _phase = LivePhase.idle;
      _publish();
    } else {
      _fail('దేవునితో అనుసంధానం కుదరలేదు. సేవ ప్రస్తుతం అందుబాటులో '
          'లేకపోవచ్చు. దయచేసి మళ్లీ ప్రయత్నించండి.');
    }
  }

  String _friendlyError(Object error) {
    final text = error.toString();
    if (text.contains('expired') || text.contains('DEADLINE')) {
      return 'సంభాషణ సమయం ముగిసింది. దయచేసి మళ్లీ ప్రారంభించండి.';
    }
    if (text.contains('RESOURCE_EXHAUSTED')) {
      return 'ప్రస్తుతం సేవ అందుబాటులో లేదు. కొద్దిసేపటి తర్వాత ప్రయత్నించండి.';
    }
    return 'దేవునితో అనుసంధానంలో అంతరాయం. దయచేసి మళ్లీ ప్రయత్నించండి.';
  }

  // --- Transcript building ---------------------------------------------

  void _appendTranscript(Speaker speaker, String fragment) {
    final last = _transcript.isNotEmpty ? _transcript.last : null;
    if (last != null && last.speaker == speaker && !last.isFinal) {
      _transcript[_transcript.length - 1] =
          last.copyWith(text: last.text + fragment);
    } else {
      // Speaker changed — finalize the previous turn first.
      if (last != null && !last.isFinal) {
        _transcript[_transcript.length - 1] = last.copyWith(isFinal: true);
      }
      _transcript.add(ConversationTurn(speaker: speaker, text: fragment));
    }
  }

  void _finalizeLastTurn() {
    if (_transcript.isEmpty) return;
    final last = _transcript.last;
    if (!last.isFinal) {
      _transcript[_transcript.length - 1] = last.copyWith(isFinal: true);
    }
  }
}
