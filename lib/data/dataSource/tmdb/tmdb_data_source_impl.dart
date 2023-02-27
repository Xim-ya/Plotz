import 'package:soon_sak/utilities/index.dart';

class TmdbDataSourceImpl implements TmdbDataSource {
  TmdbDataSourceImpl(this._api);

  final TmdbApi _api;

  final String _apiKey = dotenv.env['TMDB_API_KEY']!;
  final String _language = 'ko-KR';

// tmdb tv 컨텐츠 상세 정보
  @override
  Future<TmdbTvDetailResponse> loadTmdbTvDetailResponse(int tvId) async =>
      _api.loadTmdbMovieDetailResponse(
        tvId: tvId,
        apiKey: _apiKey,
        language: _language,
      );

// tmdb tv 컨텐츠 크레딧 정보
  @override
  Future<TmdbContentCreditResponse> loadTmdbTvCastInfoResponse(
          int tvId) async =>
      _api.loadTvCreditInfo(tvId: tvId, apiKey: _apiKey, language: 'ko-KR');

// tmdb tv 이미지 리스트
  @override
  Future<TmdbImagesResponse> loadTmdbTvIContentImages(int tvId) async =>
      _api.loadTvImages(tvId: tvId, apiKey: _apiKey);

  @override
  Future<TmdbMovieDetailResponse> loadTmdbMovieDetailResponse(
          int movieId) async =>
      _api.loadTmdbMovieDetailInfoResponse(
        movieId: movieId,
        apiKey: _apiKey,
        language: _language,
      );

  @override
  Future<TmdbContentCreditResponse> loadTmdbMovieCreditInfoResponse(
          int movieId) async =>
      _api.loadMovieCreditInfo(
        movieId: movieId,
        apiKey: _apiKey,
        language: _language,
      );

  @override
  Future<TmdbImagesResponse> loadTmdbMovieIContentImages(int movieId) async =>
      _api.loadMovieImages(movieId: movieId, apiKey: _apiKey);

  @override
  Future<TmdbTvContentListWrappedResponse> loadSearchedTvContentList(
          {required String query, required int page}) async =>
      _api.loadSearchedTvContentList(
          apiKey: _apiKey, language: _language, page: page, query: query);

  @override
  Future<TmdbMovieContentListWrappedResponse> loadSearchedMovieContentList(
          {required String query, required int page}) async =>
      _api.loadSearchedMovieContentList(
          apiKey: _apiKey, language: _language, page: page, query: query);
}
