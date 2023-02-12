import 'package:uppercut_fantube/data/dto/content/response/explore_content_response.dart';

abstract class ContentApi {

  // 모든 컨텐츠 id 리스트 호출
  Future<List<String>> loadTotalContentIdList();
}
