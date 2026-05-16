import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> initialize() async {
    await _flutterTts.setLanguage("te-IN");
    await _flutterTts.setSpeechRate(0.45); // Slightly slower for divine voice
    await _flutterTts.setPitch(0.9); // Deeper pitch
    await _flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> speak(String text, {Function? onComplete}) async {
    if (onComplete != null) {
      _flutterTts.setCompletionHandler(() {
        onComplete();
      });
    }
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
