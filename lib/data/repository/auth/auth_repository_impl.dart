import 'package:google_sign_in/google_sign_in.dart';
import 'package:uppercut_fantube/data/dataSource/auth/auth_data_source.dart';
import 'package:uppercut_fantube/data/repository/auth/auth_repository.dart';
import 'package:uppercut_fantube/domain/exception/auth_exception.dart';
import 'package:uppercut_fantube/domain/model/auth/user_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

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
}
