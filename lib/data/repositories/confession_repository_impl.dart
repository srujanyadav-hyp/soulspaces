import '../../domain/entities/confession_response.dart';
import '../../domain/repositories/confession_repository.dart';
import '../datasources/gemini_remote_datasource.dart';
import 'package:flutter/foundation.dart';

class ConfessionRepositoryImpl implements ConfessionRepository {
  final GeminiRemoteDataSource remoteDataSource;

  ConfessionRepositoryImpl(this.remoteDataSource);

  @override
  Future<ConfessionResponse> getResponse(String userText) async {
    try {
      final text = await remoteDataSource.generateResponse(userText);
      return ConfessionResponse(text: text);
    } catch (e) {
      debugPrint("API Error: $e");
      return ConfessionResponse(text: "క్షమించండి, కనెక్ట్ చేయడంలో లోపం ఏర్పడింది. దయచేసి మళ్లీ ప్రయత్నించండి.");
    }
  }
}
