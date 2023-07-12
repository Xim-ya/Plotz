import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';


class AuthDataSourceImpl
    with FireStoreErrorHandlerMixin
    implements AuthDataSource {
  AuthDataSourceImpl({required this.api});

  final AuthApi api;

  @override
  Future<bool> isUserRegistered(String userId) =>
      loadResponseOrThrow(() => api.isUserRegistered(userId));

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

