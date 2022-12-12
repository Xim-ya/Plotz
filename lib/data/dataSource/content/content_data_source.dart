import 'package:uppercut_fantube/domain/model/content/content_episode_info_item.dart';
import 'package:uppercut_fantube/utilities/index.dart';

abstract class ContentDataSource {
  Future<List<TopExposedContent>> loadTopExposedContentList();

  Future<List<ContentEpisodeInfoItem>> loadContentEpisodeItemList();

}
