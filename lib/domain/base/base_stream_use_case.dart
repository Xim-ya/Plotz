abstract class BaseStreamUseCase<REQUEST, RESPONSE> {
  Stream<RESPONSE> call(REQUEST request);
}
