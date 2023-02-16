import 'package:soon_sak/data/dataSource/auth/auth_data_source.dart';
import 'package:soon_sak/utilities/index.dart';

class AuthDataSourceImpl
    with FireStoreErrorHandlerMixin
    implements AuthDataSource {
  AuthDataSourceImpl(this._api);

  final AuthApi _api;

  @override
  Future<bool> isUserAlreadyRegistered(String userId) =>
      loadResponseOrThrow(() => _api.isUserAlreadyRegistered(userId));

  @override
  Future<bool> isUserSignedIn() =>
      loadResponseOrThrow(() => _api.isUserSignedIn());

  @override
  Future<UserModel> loadUserInfo() =>
      loadResponseOrThrow(() => _api.loadUserInfo());

  @override
  Future<void> saveUserInfo(UserModel userInfo) =>
      loadResponseOrThrow(() => _api.saveUserInfo(userInfo));

  @override
  Future<AuthorizationCredentialAppleID> triggerAppleSignIn() =>
      loadResponseOrThrow(() => _api.triggerAppleSignIn());

  @override
  Future<GoogleSignInAccount?> triggerGoogleSignIn() =>
      loadResponseOrThrow(() => _api.triggerGoogleSignIn());

  @override
  Future<void> triggerGoogleSignOut() =>
      loadResponseOrThrow(() => _api.triggerGoogleSignOut());
}
