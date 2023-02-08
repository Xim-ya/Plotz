import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uppercut_fantube/data/dataSource/auth/auth_data_source.dart';
import 'package:uppercut_fantube/data/mixin/fire_store_error_handler_mixin.dart';

class AuthDataSourceImpl implements AuthDataSource {
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
}
