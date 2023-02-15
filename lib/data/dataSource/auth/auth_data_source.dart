import 'package:soon_sak/utilities/index.dart';


abstract class AuthDataSource {
  // 유저 로그인 여부 확인
  bool isUserSignedIn();

  // 구글 로그인 트리거
  Future<GoogleSignInAccount?> triggerGoogleSignIn();

  // 애플 로그인 트기거
  Future<AuthorizationCredentialAppleID> triggerAppleSignIn();

  // 유저 정보 등록(저장)
  Future<void> saveUserInfo(UserModel userInfo);

  // 유저 정보 호출
  Future<UserModel> loadUserInfo();

  // 유저의 계정 등록 여부
  Future<bool> isUserAlreadyRegistered(String userId);

  // 구글 로그아웃
  Future<void> triggerGoogleSignOut();
}
