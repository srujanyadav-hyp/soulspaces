import '../entities/confession_response.dart';

abstract class ConfessionRepository {
  Future<ConfessionResponse> getResponse(String userText);
}
