import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sign_in_with_apple_platform_interface/authorization_credential.dart';
import 'package:soon_sak/data/dataSource/auth/auth_data_source.dart';
import 'package:soon_sak/data/mixin/fire_store_error_handler_mixin.dart';
import 'package:soon_sak/data/mixin/fire_store_helper_mixin.dart';

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
}
