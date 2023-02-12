import 'package:uppercut_fantube/utilities/index.dart';

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
}
