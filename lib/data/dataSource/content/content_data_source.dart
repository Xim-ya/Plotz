import 'package:uppercut_fantube/utilities/index.dart';

abstract class ContentDataSource {
  Future<List<TopExposedContent>> loadTopExposedContentList();
}
