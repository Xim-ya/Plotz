import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';

class CategoryContentCollection {
  final String key;
  final List<CategoryContentSection> items;

  CategoryContentCollection({required this.key, required this.items});

  // Response
  factory CategoryContentCollection.fromResponse(
    CategoryContentCollectionResponse response,
  ) =>
      CategoryContentCollection(
        key: response.key,
        items: response.items.map(CategoryContentSection.fromResponse).toList(),
      );
}

class CategoryContentSection {
  final String title;
  final List<CategoryContentItem> contents;

  CategoryContentSection({required this.title, required this.contents});

  factory CategoryContentSection.fromResponse(
    CategoryContentsResponse response,
  ) =>
      CategoryContentSection(
        title: response.title,
        contents:
            response.contents.map(CategoryContentItem.fromResponse).toList(),
      );
}

class CategoryContentItem {
  final int id;
  final String originId;
  final String title;
  final MediaType contentType;
  final String posterImgUrl;

  CategoryContentItem({
    required this.id,
    required this.originId,
    required this.contentType,
    required this.title,
    required this.posterImgUrl,
  });

  factory CategoryContentItem.fromResponse(
    CategoryContentItemResponse response,
  ) =>
      CategoryContentItem(
        originId: response.id,
        title: response.title,
        id: SplittedIdAndType.fromOriginId(response.id).id,
        contentType: SplittedIdAndType.fromOriginId(response.id).type,
        posterImgUrl: response.posterImgUrl,
      );


}
