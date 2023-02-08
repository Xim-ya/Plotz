import 'dart:developer';

import 'package:uppercut_fantube/data/repository/auth/auth_repository.dart';
import 'package:uppercut_fantube/domain/base/base_use_case.dart';
import 'package:uppercut_fantube/domain/enum/sns_type_enum.dart';

class SocialSignInHandlerUseCase extends BaseUseCase<Sns, void> {
  SocialSignInHandlerUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call(Sns request) async {
    if (request == Sns.google) {
      final response = await _authRepository.getGoogleUserInfo();
      response.fold(
        onSuccess: (data) {
        },
        onFailure: (e) {
          log(e.toString());
        },
      );
    }
  }
}
