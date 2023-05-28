import 'package:soon_sak/utilities/index.dart';

part 'new_category_content_item_response.g.dart';

@JsonSerializable(createToJson: false)
class NewCategoryContentItemResponse {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'posterImgUrl')
  final String posterImgUrl;

  @JsonKey(name: 'title')
  final String title;

  NewCategoryContentItemResponse(
      {required this.id, required this.posterImgUrl, required this.title});

  factory NewCategoryContentItemResponse.fromJson(Map<String, dynamic> json) =>
      _$NewCategoryContentItemResponseFromJson(json);
}
