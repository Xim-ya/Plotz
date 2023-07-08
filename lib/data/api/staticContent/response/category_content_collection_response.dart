import 'package:soon_sak/data/api/staticContent/response/category_content_item_response.dart';
import 'package:soon_sak/utilities/index.dart';

part 'category_content_collection_response.g.dart';

@JsonSerializable(createToJson: false)
class CategoryContentCollectionResponse {
  @JsonKey(name: 'key')
  final String key;

  @JsonKey(name: 'items')
  final List<CategoryContentsResponse> items;

  CategoryContentCollectionResponse({required this.key, required this.items});

  factory CategoryContentCollectionResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CategoryContentCollectionResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class CategoryContentsResponse {
  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'contents')
  final List<CategoryContentItemResponse> contents;

  CategoryContentsResponse({required this.title, required this.contents});

  factory CategoryContentsResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryContentsResponseFromJson(json);
}
