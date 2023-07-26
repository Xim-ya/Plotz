import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/domain/model/content/search/searched_content.m.dart';
import 'package:soon_sak/domain/model/content/search/searched_content_result.m.dart';
import 'package:soon_sak/utilities/index.dart';

/* Created By Ximya - 2022.11.22
*  [TMDB API] API 데이터를 호출을 관리하는 Repository
* */

abstract class TmdbRepository {
  Future<Result<ContentDetailInfo>> loadTvInfo(int tvId);

  Future<Result<List<ContentCreditInfo>>> loadTvCreditInfo(int tvId);

  Future<Result<List<String>>> loadTvContentImages(int tvId);

  Future<Result<ContentDetailInfo>> loadMovieInfo(int movieId);

  Future<Result<List<ContentCreditInfo>>> loadMovieCredits(int movieId);

  Future<Result<List<String>>> loadMovieContentImages(int movieId);

  Future<Result<SearchContentModel>> loadSearchedTvContents({
    required String query,
    required int page,
  });

  Future<Result<SearchContentModel>> loadSearchedMovieContents({
    required String query,
    required int page,
  });

  Future<Result<SearchedContentResult>> loadSearchedContents({
    required String query,
    required int page,
  });
}
