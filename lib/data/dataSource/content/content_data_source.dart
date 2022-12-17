import 'package:uppercut_fantube/utilities/index.dart';

abstract class ContentDataSource {
  Future<List<PosterExposureContent>> loadTopExposedContentList();

  Future<List<ContentEpisodeInfoItem>> loadContentEpisodeItemList();

  Future<List<PosterExposureContent>> loadTopTenContentList();

  Future<List<CategoryBaseContentList>> loadContentWithCategory();
}
