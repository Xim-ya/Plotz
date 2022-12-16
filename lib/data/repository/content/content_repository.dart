import 'package:uppercut_fantube/utilities/index.dart';

/* Created By Ximya - 2022.11.22
*  'Firebase Store' 로부터 데이터를 받음
*  [Content] 관련 데이터 호출을 담당하는 레이어.
* */

abstract class ContentRepository {
  Future<Result<ContentMainInfo>> loadContentMainInfo();

  Future<Result<List<TopExposedContent>>> loadTopExposedContent();

  Future<Result<List<ContentEpisodeInfoItem>>> loadContentEpisodeItemList();


  static ContentRepository get to => Get.find();
}
