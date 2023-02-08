import 'package:uppercut_fantube/data/repository/auth/auth_repository.dart';
import 'package:uppercut_fantube/domain/enum/sns_type_enum.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class SocialSignOutHandlerUseCase extends BaseUseCase<Sns, Result<void>> {
  SocialSignOutHandlerUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Result<void>> call(Sns request) async {
    switch (request) {
      case Sns.google:
        final response = await _authRepository.googleSignOut();
        return response;
      case Sns.apple:
        return Result.failure(Exception());
    }
  }
}
