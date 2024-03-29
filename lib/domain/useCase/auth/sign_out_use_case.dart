import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

class SignOutUseCase extends BaseUseCase<Sns, Result<void>> {
  SignOutUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Result<void>> call(Sns request) async {
    switch (request) {
      case Sns.google:
        final response = await _authRepository.googleSignOut();
        return response;
      case Sns.apple:
        final response = await _authRepository.appleSignOut();
        return response;
    }
  }
}
