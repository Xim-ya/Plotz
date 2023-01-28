abstract class BaseNoNetworkingUseCase<REQUEST, RESPONSE> {
  RESPONSE intent(REQUEST param);
}