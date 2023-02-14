import 'package:soon_sak/domain/model/auth/user_model.dart';
import 'package:soon_sak/utilities/index.dart';


abstract class AuthRepository {
  // 유저 로그인 여부 확인
  Result<bool> isUserSignedIn();

  // 구글 로그인 (유저 정보 호출)
  Future<Result<UserModel>> getGoogleUserInfo();

  // 구글 로그아웃
  Future<Result<void>> googleSignOut();
}