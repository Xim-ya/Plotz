abstract class BaseUseCase<REQUEST, RESPONSE> {
  Future<RESPONSE> call(REQUEST request);
}