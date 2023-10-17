import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

/* Created By Ximya - 2022.11.22
*  'Firebase Store' 로부터 데이터를 받음
*  [Content] 관련 데이터 호출을 담당하는 레이어.
* */

abstract class ContentRepository {
  // 모든 컨텐츠 id 정보 리스트 호출
  Future<Result<List<ContentIdInfoItem>>> loadContentIds();

  /// 탐색 컨텐츠 리스트 호출
  /// 주어진 ids에 속한 컨텐츠 리스트 호출
  Future<Result<List<ExploreContent>>> loadExploreContents(List<String> ids);

  // 컨텐츠 등록 요청
  Future<Result<void>> createRequestContent(ContentRequest requestInfo);

  /// 콘텐츠 요청 상태 여부
  Future<Result<bool>> checkIfContentAlreadyRequested(String contentId);

  /// 유효하지 않은 콘텐츠 삭제
  Future<Result<void>> reportInvalidContent(String id);
}
