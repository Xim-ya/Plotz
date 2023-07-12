import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class TmdbDataSource {
  Future<TmdbTvDetailResponse> loadTvContentInfo(int tvId);

  Future<TmdbContentCreditResponse> loadTmdbTvCastInfo(int tvId);

  Future<TmdbImagesResponse> loadTmdbTvIContentImages(int tvId);

  Future<TmdbMovieDetailResponse> loadMovieInfo(int movieId);

  Future<TmdbContentCreditResponse> loadTmdbMovieCreditInfo(
    int movieId,
  );

  Future<TmdbImagesResponse> loadTmdbMovieIContentImages(int movieId);

  Future<TmdbTvContentListWrappedResponse> loadSearchedTvContents({
    required String query,
    required int page,
  });

  Future<TmdbMovieContentListWrappedResponse> loadSearchedMovieContents({
    required String query,
    required int page,
  });
}
