import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022-11-20
 *  [ContentDetailViewModel]에서 사용되는 useCase
 *  TMDB API에서 데이터를 받아옴.
 *  [contentId] 와[contentType]을 인자로 전달 받음.
 *  [contentType]값('tv' 'movie')에 따라 다른 Api를 호출
 * */

class LoadContentCreditInfoUseCase extends BaseTwoParamUseCase<ContentType, int,
    Result<List<ContentCreditInfo>>> {
  LoadContentCreditInfoUseCase(this._repository);

  final TmdbRepository _repository;

  @override
  Future<Result<List<ContentCreditInfo>>> call(
      ContentType firstReq, int secondReq) async {
    /// firstReq -> [contentType] / secondRequest -> [contentId]
    if (firstReq == ContentType.tv) {
      return _repository.loadTvCreditInfo(secondReq);
    } else {
      // 임시
      return _repository.loadMovieCreditInfo(secondReq);
    }
  }
}
