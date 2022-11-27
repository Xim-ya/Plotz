import 'package:uppercut_fantube/data/api/tmdb/response/newResponse/tmdb_tv_credit_response.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class TmdbDataSourceImpl with ApiErrorHandlerMixin implements TmdbDataSource {
  TmdbDataSourceImpl(this._api);

  final TmdbApi _api;

  // tmdb tv 컨텐츠 상세 정보
  @override
  Future<TmdbTvDetailResponse> loadTmdbDetailResponse(int tvId) async =>
      _api.loadTmdbDetailResponse(tvId);


  // tmdb tv 컨텐츠 크레딧 정보
  @override
  Future<TmdbTveCreditResponse> loadTmdbTvCastInfoResponse(int tvId) async =>
      _api.loadTvCreditInfo(tvId);
}
