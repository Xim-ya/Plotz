import 'package:soon_sak/utilities/index.dart';

abstract class ContentDataSource {
  Future<List<ContentEpisodeInfoItem>> loadContentEpisodeItemList();

  Future<List<CategoryBaseContentList>> loadContentWithCategory();

  Future<List<SimpleContentInfo>> loadAllOfTvContentList();

  Future<List<SimpleContentInfo>> loadAllOfMovieContentList();

  Future<ContentVideos> loadMovieContentVideoList(int contentId);

  Future<ContentVideos> loadDramaContentVideoList(int contentId);

  Future<List<ExploreContentIdInfo>> loadExploreContentIdInfoList();

  // 모든 컨텐츠 id 리스트 호출
  Future<List<String>> loadTotalContentIdList();

  // 주어진 ids에 속한 컨텐츠 리스트 호출
  Future<List<BasicContentInfoResponse>> loadContainingIdsContents(
      List<String> ids);

  // 컨텐츠 비디오 정보 호출
  Future<List<VideoResponse>> loadVideoInfo(String id);

  // 컨텐츠 등록 요청
  Future<String> requestContentRegistration(ContentRequest requestData);

  // 유저 큐레이션 정보 추가
  Future<void> addUserQurationInfo(
      {required String qurationDocId, required String userId});

  // 진행중인 큐레이션 리스트 호출
  Future<List<InProgressCurationItemResponse>> loadInProgressQurationList();
}
