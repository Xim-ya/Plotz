import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uppercut_fantube/data/dataSource/auth/auth_data_source.dart';
import 'package:uppercut_fantube/data/mixin/fire_store_error_handler_mixin.dart';

class AuthDataSourceImpl implements AuthDataSource {
  // AuthDataSourceImpl(this._auth);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  bool isUserSignedIn() {
    if (_auth.currentUser == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<GoogleSignInAccount?> triggerGoogleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    return googleUser;
  }
}
