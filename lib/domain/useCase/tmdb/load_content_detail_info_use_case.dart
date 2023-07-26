import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022-11-20
 *  [ContentDetailViewModel]에서 사용되는 useCase
 *  TMDB API에서 데이터를 받아옴.
 *  [originId] 와[contentType]을 인자로 전달 받음.
 *  [contentType]값('tv' 'movie')에 따라 다른 Api를 호출
 * */

class LoadContentDetailInfoUseCase extends BaseTwoParamUseCase<MediaType,
    int, Result<ContentDetailInfo>> {
  LoadContentDetailInfoUseCase(this._repository);

  final TmdbRepository _repository;

  @override
  Future<Result<ContentDetailInfo>> call(
      MediaType firstReq, int secondReq,) async {
    /// firstReq -> [contentType] / secondRequest -> [contentId]
    if (firstReq == MediaType.tv) {
      return _repository.loadTvInfo(secondReq);
    } else {
      // 임시
      return _repository.loadMovieInfo(secondReq);
    }
  }
}
