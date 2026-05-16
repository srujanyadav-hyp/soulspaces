import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

class SttService {
  final SpeechToText _speechToText = SpeechToText();
  bool _isInitialized = false;

  Future<void> initialize() async {
    var status = await Permission.microphone.request();
    debugPrint("Microphone permission status: $status");
    if (status.isGranted) {
      _isInitialized = await _speechToText.initialize(
        onError: (error) => debugPrint("STT Error: ${error.errorMsg}"),
        onStatus: (status) => debugPrint("STT Status: $status"),
      );
      debugPrint("SpeechToText initialized: $_isInitialized");
    } else {
      debugPrint("Microphone permission denied!");
    }
  }

  void startListening(Function(String) onResult, {void Function()? onDone}) {
    if (_isInitialized) {
      _speechToText.listen(
        onResult: (result) {
          onResult(result.recognizedWords);
          if (result.finalResult && onDone != null) {
            onDone();
          }
        },
        localeId: 'te_IN',
        cancelOnError: true,
        listenMode: ListenMode.dictation,
        pauseFor: const Duration(seconds: 60), // Wait 60s of silence before giving up
      );
    }
  }

  void stopListening() {
    if (_isInitialized) {
      _speechToText.stop();
    }
  }
  
  bool get isListening => _speechToText.isListening;
}
