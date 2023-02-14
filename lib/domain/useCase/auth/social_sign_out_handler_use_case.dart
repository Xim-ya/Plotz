import 'package:soon_sak/data/repository/auth/auth_repository.dart';
import 'package:soon_sak/domain/enum/sns_type_enum.dart';
import 'package:soon_sak/utilities/index.dart';

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
