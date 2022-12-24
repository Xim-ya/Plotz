import 'package:uppercut_fantube/domain/model/content/searched_content.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/* Created By Ximya - 2022.11.22
*  [TMDB API] API 데이터를 호출을 관리하는 Repository
* */

abstract class TmdbRepository {
  Future<Result<ContentDetailInfo>> loadTmdbTvDetailResponse(int tvId);

  Future<Result<List<ContentCreditInfo>>> loadTvCreditInfo(int tvId);

  Future<Result<List<String>>> loadTvImgUrlList(int tvId);

  Future<Result<ContentDetailInfo>> loadTmdbMovieDetailInfo(int movieId);

  Future<Result<List<ContentCreditInfo>>> loadMovieCreditInfo(int movieId);

  Future<Result<List<String>>> loadMovieImgUrlList(int movieId);

  Future<Result<List<SearchedContent>>> loadSearchedTvContentList(String query);

  Future<Result<List<SearchedContent>>> loadSearchedMovieContentList(String query);

  static TmdbRepository get to => Get.find();
}
