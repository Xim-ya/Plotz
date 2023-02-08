import 'package:google_sign_in/google_sign_in.dart';


abstract class AuthDataSource {
  // 유저 로그인 여부 확인
  bool isUserSignedIn();

  // 구글 로그인
  Future<GoogleSignInAccount?> triggerGoogleSignIn();

  // 구글 로그아웃
  Future<void> triggerGoogleSignOut();
}
