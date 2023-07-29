import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class ContentApi {
  // 모든 컨텐츠 id 리스트 호출
  Future<List<String>> loadTotalContentIds();

  /// 탐색 컨텐츠 리스트 호출
  /// 주어진 ids에 속한 컨텐츠 리스트 호출
  Future<List<ExploreContentResponse>> loadExploreContents(List<String> ids);

  // 컨텐츠 비디오 정보 호출
  Future<List<VideoResponse>> loadVideoInfo(
      {required String contentId, required MediaType contentType});

  // 채널 정보 호출
  Future<ChannelResponse> loadChannelInfo(String contentId);

  // 컨텐츠 등록 요청
  Future<void> createRequestContent(ContentRequest requestInfo);
}
