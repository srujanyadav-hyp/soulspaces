import '../entities/confession_response.dart';
import '../repositories/confession_repository.dart';

class GetConfessionResponseUseCase {
  final ConfessionRepository repository;
  GetConfessionResponseUseCase(this.repository);

  Future<ConfessionResponse> execute(String userText) {
    return repository.getResponse(userText);
  }
}
