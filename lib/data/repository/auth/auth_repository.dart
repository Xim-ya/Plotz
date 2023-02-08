import 'package:uppercut_fantube/domain/model/auth/user_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';


abstract class AuthRepository {
  // 유저 로그인 여부 확인
  Result<bool> isUserSignedIn();

  // 구글 로그인
  Future<Result<UserModel>> getGoogleUserInfo();
}