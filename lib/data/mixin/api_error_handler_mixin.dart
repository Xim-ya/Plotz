import 'dart:developer';

import 'package:dio/dio.dart';

/** Created By LEE HAE JOO
 *  API 호출을 래핑하고 예외 처리를 중앙화하기 위해 사용
 *
 * */

mixin ApiErrorHandlerMixin {
  Future<T> loadResponseOrThrow<T>(Future<T> Function() actionApi) async {
    try {
      return await actionApi.call();
    } on DioError catch (e) {
      log('********** DIO ERROR **********');
      log('[${e.type}]${e.message}');
      throw e.error;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
