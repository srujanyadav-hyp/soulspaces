import 'package:flutter/material.dart';
import '../../domain/usecases/get_confession_response_usecase.dart';
import '../../data/services/stt_service.dart';
import '../../data/services/tts_service.dart';

enum AppState { idle, listening, processing, speaking }

class HomeProvider extends ChangeNotifier {
  final GetConfessionResponseUseCase useCase;
  final SttService sttService;
  final TtsService ttsService;

  AppState _state = AppState.idle;
  AppState get state => _state;

  String _transcribedText = "";
  String get transcribedText => _transcribedText;

  String _godsResponse = "";
  String get godsResponse => _godsResponse;

  HomeProvider({
    required this.useCase,
    required this.sttService,
    required this.ttsService,
  }) {
    _initServices();
  }

  Future<void> _initServices() async {
    await sttService.initialize();
    await ttsService.initialize();
  }

  void toggleListening() {
    if (_state == AppState.idle || _state == AppState.speaking) {
      _startListening();
    } else if (_state == AppState.listening) {
      _stopListeningAndProcess();
    }
  }

  void _startListening() {
    ttsService.stop();
    _transcribedText = "";
    _godsResponse = "";
    _state = AppState.listening;
    notifyListeners();

    sttService.startListening((text) {
      _transcribedText = text;
      notifyListeners();
    }, onDone: () {
      // User must manually tap the mic button to stop and process.
      // Auto-stop is disabled so the user doesn't get cut off.
    });
  }

  Future<void> _stopListeningAndProcess() async {
    sttService.stopListening();
    if (_transcribedText.trim().isEmpty) {
      _state = AppState.idle;
      notifyListeners();
      return;
    }

    _state = AppState.processing;
    notifyListeners();

    try {
      final response = await useCase.execute(_transcribedText);
      _godsResponse = response.text;
      _state = AppState.speaking;
      notifyListeners();

      await ttsService.speak(_godsResponse, onComplete: () {
        _state = AppState.idle;
        notifyListeners();
      });
    } catch (e) {
      _godsResponse = "క్షమించండి, కనెక్ట్ చేయడంలో లోపం ఏర్పడింది. దయచేసి మళ్లీ ప్రయత్నించండి.";
      _state = AppState.speaking;
      notifyListeners();
      await ttsService.speak(_godsResponse, onComplete: () {
        _state = AppState.idle;
        notifyListeners();
      });
    }
  }
}
