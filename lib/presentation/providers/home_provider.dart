import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../domain/entities/divine_state.dart';
import '../../domain/entities/live_phase.dart';
import '../../domain/repositories/divine_voice_repository.dart';

/// Exposes the live conversation state to the UI as a [ChangeNotifier],
/// mirroring snapshots emitted by the [DivineVoiceRepository].
class HomeProvider extends ChangeNotifier {
  HomeProvider({required DivineVoiceRepository repository})
      : _repository = repository {
    _subscription = _repository.stateStream.listen((state) {
      _state = state;
      notifyListeners();
    });
  }

  final DivineVoiceRepository _repository;
  late final StreamSubscription<DivineState> _subscription;

  DivineState _state = const DivineState();
  DivineState get state => _state;

  LivePhase get phase => _state.phase;

  /// True while connecting or in a live session — the primary button then
  /// reads "end" rather than "start".
  bool get isBusy =>
      _state.phase == LivePhase.connecting || _state.isSessionActive;

  Future<void> startConversation() => _repository.startConversation();
  Future<void> endConversation() => _repository.endConversation();

  /// Toggles the session — the single primary control.
  Future<void> toggleSession() =>
      isBusy ? endConversation() : startConversation();

  @override
  void dispose() {
    _subscription.cancel();
    _repository.dispose();
    super.dispose();
  }
}
