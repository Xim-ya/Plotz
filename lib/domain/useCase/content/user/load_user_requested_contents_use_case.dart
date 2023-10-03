import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/base/base_use_case.dart';
import 'package:soon_sak/domain/model/content/myPage/requested_content.m.dart';
import 'package:soon_sak/utilities/index.dart';

class LoadUserRequestedContentsUseCase
    extends BaseUseCase<int, Result<List<RequestedContent>>> {
  LoadUserRequestedContentsUseCase(this._repository);

  final UserRepository _repository;

  @override
  Future<Result<List<RequestedContent>>> call(request) =>
      _repository.loadRequestedContentByStatus(request);
}
