import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/base/base_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

class DeleteRequestedContentUesCase extends BaseUseCase<String, Result<void>> {
  DeleteRequestedContentUesCase(this._repository);

  final UserRepository _repository;

  @override
  Future<Result<void>> call(String request) async {
    return _repository.removeRequestedContent(request);
  }
}
