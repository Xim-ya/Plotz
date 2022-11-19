abstract class BaseNoParamStreamUseCase<RESPONSE> {
  Stream<RESPONSE> call();
}
