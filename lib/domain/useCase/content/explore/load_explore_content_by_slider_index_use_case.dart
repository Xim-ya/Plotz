import 'package:uppercut_fantube/utilities/index.dart';

class LoadExploreContentBySlierIndexUseCase
    extends BaseUseCase<int, Result<List<ExploreContent>>> {
  final ContentRepository _repository;

  LoadExploreContentBySlierIndexUseCase(this._repository);

  @override
  Future<Result<List<ExploreContent>>> call(int request) {
    return _repository.loadBasicInfoOfExploreContentList();
  }
}
