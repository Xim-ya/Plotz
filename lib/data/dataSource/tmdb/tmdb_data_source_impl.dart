import 'package:soon_sak/utilities/index.dart';

class TmdbDataSourceImpl with ApiErrorHandlerMixin implements TmdbDataSource {
  TmdbDataSourceImpl(this._api);

  final TmdbApi _api;

  // tmdb tv 컨텐츠 상세 정보
  @override
  Future<TmdbTvDetailResponse> loadTmdbTvDetailResponse(int tvId) async =>
      _api.loadTmdbMovieDetailResponse(tvId);

  // tmdb tv 컨텐츠 크레딧 정보
  @override
  Future<TmdbContentCreditResponse> loadTmdbTvCastInfoResponse(
          int tvId) async =>
      _api.loadTvCreditInfo(tvId);

  // tmdb tv 이미지 리스트
  @override
  Future<TmdbImagesResponse> loadTmdbTvIContentImages(int tvId) async =>
      _api.loadTvImages(tvId);

  @override
  Future<TmdbMovieDetailResponse> loadTmdbMovieDetailResponse(
          int movieId) async =>
      _api.loadTmdbMovieDetailInfoResponse(movieId);

  @override
  Future<TmdbContentCreditResponse> loadTmdbMovieCreditInfoResponse(
          int movieId) async =>
      _api.loadMovieCreditInfo(movieId);

  @override
  Future<TmdbImagesResponse> loadTmdbMovieIContentImages(int movieId) async =>
      _api.loadMovieImages(movieId);

  @override
  Future<TmdbTvContentListWrappedResponse> loadSearchedTvContentList(
          String query) async =>
      _api.loadSearchedTvContentList(query);

  @override
  Future<TmdbMovieContentListWrappedResponse> loadSearchedMovieContentList(
          String query) async =>
      _api.loadSearchedMovieContentList(query);
}
