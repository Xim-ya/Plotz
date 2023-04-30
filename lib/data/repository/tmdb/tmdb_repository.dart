import 'package:soon_sak/domain/model/content/search/search_content_model.dart';
import 'package:soon_sak/utilities/index.dart';

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

  Future<Result<SearchContentModel>> loadSearchedTvContentList(
      {required String query, required int page,});

  Future<Result<SearchContentModel>> loadSearchedMovieContentList(
      {required String query, required int page,});

  static TmdbRepository get to => Get.find();
}
