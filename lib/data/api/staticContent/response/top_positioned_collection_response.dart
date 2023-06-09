import 'package:json_annotation/json_annotation.dart';
import 'package:soon_sak/data/api/staticContent/response/category_content_item_response.dart';

part 'top_positioned_collection_response.g.dart';

@JsonSerializable(createToJson: false)
class TopPositionedCollectionResponse {
  @JsonKey(name: 'key')
  final String key;

  @JsonKey(name: 'categories')
  final List<TopPositionedCategoryResponse> categories;

  TopPositionedCollectionResponse(
      {required this.key, required this.categories});

  factory TopPositionedCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$TopPositionedCollectionResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class TopPositionedCategoryResponse {
  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'items')
  final List<CategoryContentItemResponse> items;

  TopPositionedCategoryResponse({required this.title, required this.items});

  factory TopPositionedCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$TopPositionedCategoryResponseFromJson(json);
}
