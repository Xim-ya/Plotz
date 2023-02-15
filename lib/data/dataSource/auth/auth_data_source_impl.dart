import 'package:soon_sak/utilities/index.dart';

class AuthDataSourceImpl with FirestoreHelper implements AuthDataSource {
  // AuthDataSourceImpl(this._auth);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignInOutHandler = GoogleSignIn();

  @override
  bool isUserSignedIn() {
    if (_auth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<GoogleSignInAccount?> triggerGoogleSignIn() async {
    final GoogleSignInAccount? googleUser =
        await _googleSignInOutHandler.signIn();
    return googleUser;
  }

  @override
  Future<void> triggerGoogleSignOut() async {
    await _auth.signOut();
    await _googleSignInOutHandler.signOut();
  }

  @override
  Future<AuthorizationCredentialAppleID> triggerAppleSignIn() async {
    return SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
  }

  @override
  Future<bool> isUserAlreadyRegistered(String userId) async {
    final doc = await getDocsFromId('user', docId: userId);
    if (doc.exists) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> saveUserInfo(
    UserModel userInfo,
  ) async {
    return storeDocument('user', docId: userInfo.id, data: userInfo.toMap());
  }
}
