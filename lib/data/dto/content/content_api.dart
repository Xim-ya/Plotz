import 'package:uppercut_fantube/data/dto/content/response/basic_content_info_response.dart';

abstract class ContentApi {

  // 모든 컨텐츠 id 리스트 호출
  Future<List<String>> loadTotalContentIdList();

  // 주어진 ids에 속한 컨텐츠 리스트 호출
  Future<List<BasicContentInfoResponse>> loadContainingIdsContents(List<String> ids);
}