import 'package:uppercut_fantube/utilities/index.dart';

part 'top_ten_content_response.g.dart';

@JsonSerializable(createToJson: false)
class TopTenContentResponse {
  final String id;
  final List<TopTenContentItemResponse> items;

  TopTenContentResponse({required this.id, required this.items});

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