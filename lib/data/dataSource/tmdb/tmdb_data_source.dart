import 'package:uppercut_fantube/data/dto/tmdb/response/newResponse/tmdb_movie_content_list_wrapped_response.dart';
import 'package:uppercut_fantube/data/dto/tmdb/response/newResponse/tmdb_tv_content_list_wrapped_response.dart';
import 'package:uppercut_fantube/utilities/index.dart';

abstract class TmdbDataSource {
  Future<TmdbTvDetailResponse> loadTmdbTvDetailResponse(int tvId);

  Future<TmdbContentCreditResponse> loadTmdbTvCastInfoResponse(int tvId);

  Future<TmdbImagesResponse> loadTmdbTvIContentImages(int tvId);

  Future<TmdbMovieDetailResponse> loadTmdbMovieDetailResponse(int movieId);

  Future<TmdbContentCreditResponse> loadTmdbMovieCreditInfoResponse(
      int movieId);

  Future<TmdbImagesResponse> loadTmdbMovieIContentImages(int movieId);

  Future<TmdbTvContentListWrappedResponse> loadSearchedTvContentList(
      String query);

  Future<TmdbMovieContentListWrappedResponse> loadSearchedMovieContentList(
      String query);
}
