import 'package:google_sign_in/google_sign_in.dart';
import 'package:soon_sak/data/dataSource/auth/auth_data_source.dart';
import 'package:soon_sak/data/repository/auth/auth_repository.dart';
import 'package:soon_sak/domain/exception/auth_exception.dart';
import 'package:soon_sak/domain/model/auth/user_model.dart';
import 'package:soon_sak/utilities/index.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final AuthDataSource _dataSource;

  @override
  Result<bool> isUserSignedIn() {
    try {
      final response = _dataSource.isUserSignedIn();

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
  Future<Result<bool>> isUserAlreadyRegistered(String userId) async {
    try {
      final response = await _dataSource.isUserAlreadyRegistered(userId);
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
}
