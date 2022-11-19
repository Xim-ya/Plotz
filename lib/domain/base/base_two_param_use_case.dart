abstract class BaseTwoParamUseCase<REQUEST1, REQUEST2, RESPONSE> {
  Future<RESPONSE> call(REQUEST1 firstReq, REQUEST2 secondReq);
}
