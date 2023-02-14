import 'package:soon_sak/data/repository/auth/auth_repository.dart';
import 'package:soon_sak/domain/enum/sns_type_enum.dart';
import 'package:soon_sak/domain/model/auth/user_model.dart';
import 'package:soon_sak/utilities/index.dart';

class SocialSignInHandlerUseCase extends BaseUseCase<Sns, Result<void>> {
  SocialSignInHandlerUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Result<void>> call(Sns request) async {
    switch (request) {
      case Sns.google:
        final response = await _authRepository.getGoogleUserInfo();
        response.fold(
          onSuccess: (data) {
            signWithCredential(data);
          },
          onFailure: (e) {},
        );
        return response;
      case Sns.apple:
        return Result.failure(Exception());
    }
  }

  // Firebase Auth 등록
  void signWithCredential(UserModel user) {
    final credential = GoogleAuthProvider.credential(
      accessToken: user.token?.accessToken,
      idToken: user.token?.idToken,
    );

    FirebaseAuth.instance.signInWithCredential(credential);
  }
}
