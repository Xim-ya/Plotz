import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';


abstract class AuthDataSource {
  // 유저 로그인 여부 확인
  bool isUserSignedIn();

  // 구글 로그인 트리거
  Future<GoogleSignInAccount?> triggerGoogleSignIn();

  // 애플 로그인 트기거
  Future<AuthorizationCredentialAppleID> triggerAppleSignIn();


  // 유저의 계정 등록 여부
  Future<bool> isUserAlreadyRegistered(String userId);

  // 구글 로그아웃
  Future<void> triggerGoogleSignOut();
}
