import 'package:soon_sak/utilities/index.dart';

class RequestContentRegistrationUseCase
    extends BaseUseCase<ContentRequest, Result<void>> {
  RequestContentRegistrationUseCase(this._repository);

  final ContentRepository _repository;

  @override
  Future<Result<void>> call(ContentRequest request) {
    return _repository.requestContentRegistration(request);
  }
}
