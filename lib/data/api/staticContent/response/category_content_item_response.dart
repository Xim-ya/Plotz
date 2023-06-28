import 'package:soon_sak/utilities/index.dart';

part 'category_content_item_response.g.dart';

@JsonSerializable(createToJson: false)
class CategoryContentItemResponse {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'posterImgUrl')
  final String posterImgUrl;

  @JsonKey(name: 'title')
  final String title;

  CategoryContentItemResponse(
      {required this.id, required this.posterImgUrl, required this.title});

  factory CategoryContentItemResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryContentItemResponseFromJson(json);
}
