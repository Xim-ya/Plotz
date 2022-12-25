import 'package:uppercut_fantube/domain/model/content/simple_content_info.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/* Created By Ximya - 2022.11.22
*  'Firebase Store' 로부터 데이터를 받음
*  [Content] 관련 데이터 호출을 담당하는 레이어.
* */

abstract class ContentRepository {
  Future<Result<List<PosterExposureContent>>> loadTopExposedContent();

  Future<Result<List<ContentEpisodeInfoItem>>> loadContentEpisodeItemList();

  Future<Result<List<PosterExposureContent>>> loadTopTenContentList();

  Future<Result<List<CategoryBaseContentList>>> loadContentListWithCategory();

  Future<Result<List<SimpleContentInfo>>> loadAllOfTvContentList();

  Future<Result<List<SimpleContentInfo>>> loadAllOfMovieContentList();




  static ContentRepository get to => Get.find();
}
