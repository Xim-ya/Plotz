import 'package:flutter/cupertino.dart';

abstract class BaseUseCase<REQUEST, RESPONSE> {
  Future<RESPONSE> call(REQUEST request);

  BaseUseCase() {
    onInit();
  }

  @protected
  void onInit() {}
}
