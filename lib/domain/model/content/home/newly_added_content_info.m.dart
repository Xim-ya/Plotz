import 'package:soon_sak/data/api/staticContent/response/newly_added_content_response.dart';
import 'package:soon_sak/domain/model/content/home/category_content_collection_model.dart';

class NewlyAddedContentInfo {
  final String key;
  final List<CategoryContentItem> contents;

  NewlyAddedContentInfo({required this.key, required this.contents});

  factory NewlyAddedContentInfo.fromResponse(
          NewlyAddedContentResponse response) =>
      NewlyAddedContentInfo(
        key: response.key,
        contents: response.items
            .map((e) => CategoryContentItem.fromResponse(e))
            .toList(),
      );
}
