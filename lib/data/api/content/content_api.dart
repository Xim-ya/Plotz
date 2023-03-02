import 'package:soon_sak/data/api/content/response/channel_response.dart';
import 'package:soon_sak/domain/model/content/search/content_request.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class ContentApi {
  // 모든 컨텐츠 id 리스트 호출
  Future<List<String>> loadTotalContentIdList();

  /// 탐색 컨텐츠 리스트 호출
  /// 주어진 ids에 속한 컨텐츠 리스트 호출
  Future<List<ExploreContentResponse>> loadExploreContents(List<String> ids);

  // 컨텐츠 비디오 정보 호출
  Future<List<VideoResponse>> loadVideoInfo(String id);

  // 컨텐츠 등록 요청 (큐레이션)
  Future<String> requestContentRegistration(
      ContentRegistrationRequest requestData);

  // 진행중인 큐레이션 리스트 호출
  Future<List<CurationContentResponse>> loadInProgressQurationList();

  // 큐레이터 정보 호출
  Future<UserResponse> loadCuratorInfo(String contentId);

  // 채널 정보 호출
  Future<ChannelResponse> loadChannelInfo(String contentId);

  // 컨텐츠 등록 요청 (단순 요청)
  Future<void> requestContent(ContentRequest requestInfo);
}
