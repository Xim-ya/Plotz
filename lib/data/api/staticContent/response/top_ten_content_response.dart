import 'package:soon_sak/utilities/index.dart';

part 'top_ten_content_response.g.dart';

@JsonSerializable(createToJson: false)
class TopTenContentResponse {
  @JsonKey(name: 'key')
  final String key;

  @JsonKey(name: 'items')
  final List<TopTenContentItemResponse> items;

  TopTenContentResponse({required this.key, required this.items});

  factory TopTenContentResponse.fromJson(Map<String, dynamic> json) =>
      _$TopTenContentResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class TopTenContentItemResponse {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'imgUrl')
  final String imgUrl;

  @JsonKey(name: 'title')
  final String title;

  TopTenContentItemResponse(
      {required this.id, required this.imgUrl, required this.title});

  factory TopTenContentItemResponse.fromJson(Map<String, dynamic> json) =>
      _$TopTenContentItemResponseFromJson(json);
}
