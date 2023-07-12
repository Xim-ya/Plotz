import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/utilities/index.dart';

class TmdbDataSourceImpl implements TmdbDataSource {
  TmdbDataSourceImpl(this._api);

  final TmdbApi _api;

  final String _apiKey = dotenv.env['TMDB_API_KEY']!;
  final String _language = 'ko-KR';

// tmdb tv 컨텐츠 상세 정보
  @override
  Future<TmdbTvDetailResponse> loadTvContentInfo(int tvId) async =>
      _api.loadTvContentInfo(
        tvId: tvId,
        apiKey: _apiKey,
        language: _language,
      );

// tmdb tv 컨텐츠 크레딧 정보
  @override
  Future<TmdbContentCreditResponse> loadTmdbTvCastInfo(
          int tvId,) async =>
      _api.loadTvCreditInfo(tvId: tvId, apiKey: _apiKey, language: 'ko-KR');

// tmdb tv 이미지 리스트
  @override
  Future<TmdbImagesResponse> loadTmdbTvIContentImages(int tvId) async =>
      _api.loadTvImages(tvId: tvId, apiKey: _apiKey);

  @override
  Future<TmdbMovieDetailResponse> loadMovieInfo(
          int movieId,) async =>
      _api.loadMovieInfo(
        movieId: movieId,
        apiKey: _apiKey,
        language: _language,
      );

  @override
  Future<TmdbContentCreditResponse> loadTmdbMovieCreditInfo(
          int movieId,) async =>
      _api.loadMovieCreditInfo(
        movieId: movieId,
        apiKey: _apiKey,
        language: _language,
      );

  @override
  Future<TmdbImagesResponse> loadTmdbMovieIContentImages(int movieId) async =>
      _api.loadMovieImages(movieId: movieId, apiKey: _apiKey);

  @override
  Future<TmdbTvContentListWrappedResponse> loadSearchedTvContents(
          {required String query, required int page,}) async =>
      _api.loadSearchedTvContents(
          apiKey: _apiKey, language: _language, page: page, query: query,);

  @override
  Future<TmdbMovieContentListWrappedResponse> loadSearchedMovieContents(
          {required String query, required int page,}) async =>
      _api.loadSearchedMovieContents(
          apiKey: _apiKey, language: _language, page: page, query: query,);
}
