import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../core/constants/prompt_constants.dart';

class GeminiRemoteDataSource {
  Future<String> generateResponse(String userText) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API Key missing in assets/.env');
    }

    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey'
    );
    
    final body = jsonEncode({
      "system_instruction": {
        "parts": [{"text": PromptConstants.systemPrompt}]
      },
      "contents": [
        {
          "role": "user",
          "parts": [{"text": userText}]
        }
      ],
      "generationConfig": {
        "temperature": 0.4,
        "maxOutputTokens": 4096,
        "topP": 0.95
      }
    });

    debugPrint('Sending to Gemini: $userText');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final text = jsonResponse['candidates'][0]['content']['parts'][0]['text'];
      debugPrint('Gemini Response: $text');
      return text;
    } else {
      throw Exception('Gemini API Error: ${response.statusCode} - ${response.body}');
    }
  }
}
