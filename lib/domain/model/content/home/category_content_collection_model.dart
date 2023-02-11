import 'package:uppercut_fantube/utilities/index.dart';

class CategoryContentCollection {
  final String key;
  final List<CategoryContentModel> items;



  CategoryContentCollection({required this.key, required this.items});

  factory CategoryContentCollection.fromResponse(
    CategoryContentCollectionResponse response,
  ) =>
      CategoryContentCollection(
          key: response.key,
          items:
              response.items.map(CategoryContentModel.fromResponse).toList());
}

class CategoryContentModel {
  final String title;
  final List<CategoryContentItem> contents;

  CategoryContentModel({required this.title, required this.contents});

  factory CategoryContentModel.fromResponse(
    CategoryContentsResponse response,
  ) =>
      CategoryContentModel(
        title: response.title,
        contents:
            response.contents.map(CategoryContentItem.fromResponse).toList(),
      );
}

class CategoryContentItem {
  final int id;
  final ContentType contentType;
  final String posterImgUrl;

  CategoryContentItem(
      {required this.id,
      required this.contentType,
      required this.posterImgUrl});

  factory CategoryContentItem.fromResponse(
          CategoryContentItemResponse response) =>
      CategoryContentItem(
        id: SplittedIdAndType.fromOriginId(response.id).id,
        contentType: SplittedIdAndType.fromOriginId(response.id).type,
        posterImgUrl: response.posterImgUrl,
      );
}
