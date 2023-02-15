import 'dart:developer';

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
        return response.fold(
          onSuccess: (data) {
            signWithCredential(data, snsType: Sns.google);
            return Result.success(null);
          },
          onFailure: Result.failure,
        );

      case Sns.apple:
        final response = await _authRepository.getAppleUserInfo();
        return response.fold(
          onSuccess: (data) async {
            await signWithCredential(data, snsType: Sns.apple);
            return Result.success(null);
          },
          onFailure: Result.failure,
        );
    }
  }


  // Firebase Auth 등록
  Future<void> signWithCredential(UserModel user,
      {required Sns snsType}) async {
    late final OAuthCredential credential;

    if (snsType == Sns.google) {
      credential = GoogleAuthProvider.credential(
        accessToken: user.token?.accessToken,
        idToken: user.token?.idToken,
      );
    } else {
      credential = OAuthProvider('apple.com').credential(
        idToken: user.token?.idToken,
        accessToken: user.token?.accessToken,
      );
    }

    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
