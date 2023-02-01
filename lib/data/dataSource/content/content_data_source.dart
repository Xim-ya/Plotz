import 'package:uppercut_fantube/utilities/index.dart';

abstract class ContentDataSource {
  Future<List<PosterExposureContent>> loadTopExposedContentList();

  Future<List<ContentEpisodeInfoItem>> loadContentEpisodeItemList();

  Future<List<ContentShell>> loadTopTenContentList();

  Future<List<CategoryBaseContentList>> loadContentWithCategory();

  Future<List<SimpleContentInfo>> loadAllOfTvContentList();

  Future<List<SimpleContentInfo>> loadAllOfMovieContentList();

  Future<ContentVideos> loadMovieContentVideoList(int contentId);

  Future<ContentVideos> loadDramaContentVideoList(int contentId);

  Future<List<ExploreContentIdInfo>> loadExploreContentIdInfoList();
}
