import 'package:firebase_auth/firebase_auth.dart';

mixin FireStoreErrorHandlerMixin {
  Future<T> loadResponseOrThrow<T>(Future<T> Function() actionApi) async {
    try {
      return await actionApi.call();
    } on FirebaseException catch (e) {
      throw e as dynamic;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
