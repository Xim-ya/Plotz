import 'package:soon_sak/domain/model/video/content_video_model.dart';
import 'package:soon_sak/utilities/index.dart';

/* Created By Ximya - 2022.11.22
*  'Firebase Store' 로부터 데이터를 받음
*  [Content] 관련 데이터 호출을 담당하는 레이어.
* */

abstract class ContentRepository {
  // Future<Result<List<ContentEpisodeInfoItem>>> loadContentEpisodeItemList();
  // Future<Result<List<CategoryBaseContentList>>> loadContentListWithCategory();

  // 모든 컨텐츠 id 정보 리스트 호출
  Future<Result<List<ContentIdInfoItem>>> loadContentIdInfoList();

  /// 탐색 컨텐츠 리스트 호출
  /// 주어진 ids에 속한 컨텐츠 리스트 호출
  Future<Result<List<ExploreContent>>> loadExploreContents(List<String> ids);


  // 컨텐츠 등록 요청 (단순 요청)
  Future<Result<void>> requestContent(ContentRequest requestInfo);

}
