import 'package:soon_sak/utilities/index.dart';

abstract class TmdbDataSource {
  Future<TmdbTvDetailResponse> loadTmdbTvDetailResponse(int tvId);

  Future<TmdbContentCreditResponse> loadTmdbTvCastInfoResponse(int tvId);

  Future<TmdbImagesResponse> loadTmdbTvIContentImages(int tvId);

  Future<TmdbMovieDetailResponse> loadTmdbMovieDetailResponse(int movieId);

  Future<TmdbContentCreditResponse> loadTmdbMovieCreditInfoResponse(
      int movieId,);

  Future<TmdbImagesResponse> loadTmdbMovieIContentImages(int movieId);

  Future<TmdbTvContentListWrappedResponse> loadSearchedTvContentList(
      {required String query, required int page,});

  Future<TmdbMovieContentListWrappedResponse> loadSearchedMovieContentList(
      {required String query, required int page,});


  static TmdbDataSource get to => Get.find();
}
