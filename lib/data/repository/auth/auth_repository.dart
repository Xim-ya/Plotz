import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class AuthRepository {
  // 유저 로그인 여부
  Future<Result<bool>> isUserSignedIn();

  // 유저의 계정 등록 여부
  Future<Result<bool>> isUserRegistered(String userId);

  // 유저 정보 호출
  Future<Result<UserModel>> loadUserInfo();

  // 구글 로그인 (유저 정보 호출)
  Future<Result<UserModel>> getGoogleUserInfo();

  // 애플 로그인 (유저 정보 호출)
  Future<Result<UserModel>> getAppleUserInfo();

  // 유저 정보 등록(저장)
  Future<Result<void>> saveUserInfo(UserModel userInfo);

  // 구글 로그아웃
  Future<Result<void>> googleSignOut();

  // 애플 로그아웃
  Future<Result<void>> appleSignOut();

  // 유저 접속일 최신화
  Future<Result<void>> updateLoginDate(String userId);
}
