import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022-12-23
 *  [SearchViewModel]에서 사용되는 useCase
 *  TMDB API에서 데이터를 받아옴.
 *  [query(search)] 와[contentType]을 인자로 전달 받음.
 *  [contentType]값('tv' 'movie')에 따라 다른 Api를 호출
 * */

class LoadSearchedContentResultUseCase extends BaseTwoParamUseCase<ContentType,
    String, Result<List<SearchedContent>>> {
  LoadSearchedContentResultUseCase(this._repository);

  final TmdbRepository _repository;

  @override
  Future<Result<List<SearchedContent>>> call(
      ContentType firstReq, String secondReq) {
    /// firstReq -> [contentType] / secondRequest -> [Query]
    ///

    print("SELECT TYPE ${firstReq}");
    if (firstReq == ContentType.tv) {
      print("QUERY ${secondReq}");
      return _repository.loadSearchedTvContentList(secondReq);
    } else {
      print("MOVIE CALL");
      return _repository.loadSearchedMovieContentList(secondReq);
    }
  }
}
