import 'package:dio/dio.dart';

mixin ApiErrorHandlerMixin {
  Future<T> loadResponseOrThrow<T>(Future<T> Function() actionApi) async {
    try {
      return await actionApi.call();
    } on DioError catch (e) {
      throw e.error;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
