import 'package:soon_sak/utilities/index.dart';

part 'top_ten_content_response.g.dart';

@JsonSerializable(createToJson: false)
class TopTenContentResponse {
  @JsonKey(name : 'key')
  final String key;

  @JsonKey(name : 'items')
  final List<TopTenContentItemResponse> items;

  TopTenContentResponse({required this.key, required this.items});

  factory TopTenContentResponse.fromJson(Map<String, dynamic> json) =>
      _$TopTenContentResponseFromJson(json);
}


@JsonSerializable(createToJson: false)
class TopTenContentItemResponse {
  final String id;
  final String posterImgUrl;

  TopTenContentItemResponse({required this.id, required this.posterImgUrl});

  factory TopTenContentItemResponse.fromJson(Map<String, dynamic> json) =>
      _$TopTenContentItemResponseFromJson(json);
}