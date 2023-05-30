import 'dart:isolate';

import 'package:soon_sak/data/mixin/isolate_helper_mixin.dart';
import 'package:soon_sak/utilities/index.dart';

class AuthDataSourceImpl
    with FireStoreErrorHandlerMixin
    implements AuthDataSource {
  AuthDataSourceImpl({required this.api});

  final AuthApi api;

  @override
  Future<bool> isUserAlreadyRegistered(String userId) =>
      loadResponseOrThrow(() => api.isUserAlreadyRegistered(userId));

  @override
  Future<bool> isUserSignedIn() =>
      loadResponseOrThrow(api.isUserSignedIn);

  @override
  Future<UserModel> loadUserInfo() =>
      loadResponseOrThrow(api.loadUserInfo);

  @override
  Future<void> saveUserInfo(UserModel userInfo) =>
      loadResponseOrThrow(() => api.saveUserInfo(userInfo));

  @override
  Future<AuthorizationCredentialAppleID> triggerAppleSignIn() =>
      loadResponseOrThrow(api.triggerAppleSignIn);

  @override
  Future<GoogleSignInAccount?> triggerGoogleSignIn() =>
      loadResponseOrThrow(api.triggerGoogleSignIn);

  @override
  Future<void> triggerGoogleSignOut() =>
      loadResponseOrThrow(api.triggerGoogleSignOut);

  @override
  Future<void> triggerAppleSignOut() =>
      loadResponseOrThrow(api.triggerAppleSignOut);

  @override
  Future<void> updateLoginDate(String userId) =>
      loadResponseOrThrow(() => api.updateLoginDate(userId));
}

