import 'package:uppercut_fantube/domain/model/content/top_exposed_content_list.dart';

abstract class ContentDataSource {
  Future<List<TopExposedContent>> loadTopExposedContentList();
}
