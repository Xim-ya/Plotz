import 'package:json_annotation/json_annotation.dart';
import 'package:soon_sak/data/index.dart';

part 'newly_added_content_response.g.dart';

@JsonSerializable(createToJson: false)
class NewlyAddedContentResponse {
  @JsonKey(name: 'key')
  final String key;

  @JsonKey(name: 'items')
  final List<CategoryContentItemResponse> items;

  NewlyAddedContentResponse(this.key, this.items);

  factory NewlyAddedContentResponse.fromJson(Map<String, dynamic> json) =>
      _$NewlyAddedContentResponseFromJson(json);
}
