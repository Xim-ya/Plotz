
import 'package:uppercut_fantube/domain/model/content/tv_content_credit_info.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/* Created By Ximya - 2022.11.22
*  [TMDB API] API 데이터를 호출을 관리하는 Repository
* */

abstract class TmdbRepository {
  Future<Result<ContentDescriptionInfo>> loadTmdbDetailResponse(int tvId);

  Future<Result<List<TvContentCreditInfo>>> loadTvCreditInfo(int tvId);


  static TmdbRepository get to => Get.find();
}
