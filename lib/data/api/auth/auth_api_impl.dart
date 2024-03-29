import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

class AuthApiImpl with FirestoreHelper implements AuthApi {
  // AuthDataSourceImpl(this._auth);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignInOutHandler = GoogleSignIn();

  @override
  Future<bool> isUserSignedIn() async {
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
  Future<bool> isUserRegistered(String userId) async {
    final doc = await getDocById('user', docId: userId);
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

  @override
  Future<UserModel> loadUserInfo() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('AuthDataSource : 유저 정보를 불러오지 못했습니다');
    }
    final doc = await getDocById('user', docId: userId);
    return UserModel.fromDocumentRes(doc);
  }

  @override
  Future<void> triggerAppleSignOut() async {
    await _auth.signOut();
  }

  @override
  Future<void> updateLoginDate(String userId) async {
    final data = {'lastLoginDate': FieldValue.serverTimestamp()};
    return updateDocumentField('user', docId: userId, data: data);
  }
}
