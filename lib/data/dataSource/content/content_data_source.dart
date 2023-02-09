import 'package:uppercut_fantube/domain/model/staticContent/banner.dart';
import 'package:uppercut_fantube/utilities/index.dart';

abstract class ContentDataSource {
  Future<List<BannerItem>> loadBannerContentList();

  Future<List<ContentEpisodeInfoItem>> loadContentEpisodeItemList();

  Future<List<ContentShell>> loadTopTenContentList();

  Future<List<CategoryBaseContentList>> loadContentWithCategory();

  Future<List<SimpleContentInfo>> loadAllOfTvContentList();

  Future<List<SimpleContentInfo>> loadAllOfMovieContentList();

  Future<ContentVideos> loadMovieContentVideoList(int contentId);

  Future<ContentVideos> loadDramaContentVideoList(int contentId);

  Future<List<ExploreContentIdInfo>> loadExploreContentIdInfoList();
}
