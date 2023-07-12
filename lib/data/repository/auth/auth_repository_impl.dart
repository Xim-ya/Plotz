import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';


class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthDataSource dataSource})
      : _dataSource = dataSource;

  final AuthDataSource _dataSource;

  @override
  Future<Result<bool>> isUserSignedIn() async {
    try {
      final response = await _dataSource.isUserSignedIn();

      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserModel>> getGoogleUserInfo() async {
    try {
      final GoogleSignInAccount? response =
          await _dataSource.triggerGoogleSignIn();

      final GoogleSignInAuthentication? googleAuth =
          await response?.authentication;

      if (response == null || googleAuth == null) {
        return Result.failure(AuthException.stopGoogleSignInProcess());
      }

      return Result.success(
        UserModel.fromGoogleSignInRes(
          account: response,
          authentication: googleAuth,
        ),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> googleSignOut() async {
    try {
      final response = await _dataSource.triggerGoogleSignOut();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserModel>> getAppleUserInfo() async {
    try {
      final response = await _dataSource.triggerAppleSignIn();

      if (response.identityToken == null) {
        return Result.failure(AuthException.stopAppleSignInProgress());
      }

      return Result.success(
        UserModel.fromAppleSignInRes(response: response),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<bool>> isUserRegistered(String userId) async {
    try {
      final response = await _dataSource.isUserRegistered(userId);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> saveUserInfo(UserModel userInfo) async {
    try {
      final response = await _dataSource.saveUserInfo(userInfo);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserModel>> loadUserInfo() async {
    try {
      final response = await _dataSource.loadUserInfo();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> appleSignOut() async {
    try {
      final response = await _dataSource.triggerAppleSignOut();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateLoginDate(String userId) async {
    try {
      final response = await _dataSource.updateLoginDate(userId);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
