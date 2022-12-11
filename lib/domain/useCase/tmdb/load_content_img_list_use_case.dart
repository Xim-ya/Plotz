
import 'package:uppercut_fantube/utilities/index.dart';

class LoadContentImgListUseCase extends  BaseTwoParamUseCase<String, int, Result<List<String>>> {
  LoadContentImgListUseCase(this._repository);

  final TmdbRepository _repository;
  @override
  Future<Result<List<String>>> call(String firstReq, int secondReq) {
    /// firstReq -> [contentType] / secondRequest -> [contentId]
    if (firstReq == 'tv') {
      return _repository.loadTvImgUrlList(secondReq);
    } else {
      // 임시
      return _repository.loadTvImgUrlList(secondReq);
    }
  }
}