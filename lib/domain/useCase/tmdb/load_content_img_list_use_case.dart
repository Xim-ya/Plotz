import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

class LoadContentImgListUseCase
    extends BaseTwoParamUseCase<MediaType, int, Result<List<String>>> {
  LoadContentImgListUseCase(this._repository);

  final TmdbRepository _repository;

  @override
  Future<Result<List<String>>> call(MediaType firstReq, int secondReq) {
    /// firstReq -> [contentType] / secondRequest -> [contentId]
    if (firstReq == MediaType.tv) {
      return _repository.loadTvContentImages(secondReq);
    } else {
      // 임시
      return _repository.loadMovieContentImages(secondReq);
    }
  }
}
