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


  static TmdbDataSource get to => Get.find();
}
