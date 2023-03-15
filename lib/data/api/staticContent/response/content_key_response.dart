import 'package:json_annotation/json_annotation.dart';

part 'content_key_response.g.dart';

@JsonSerializable(createToJson: false)
class ContentKeyResponse {
  @JsonKey(name: 'bannerKey')
  final String bannerKey;

  @JsonKey(name: 'topTenContentKey')
  final String topTenContentKey;

  @JsonKey(name: 'categoryContent1')
  final String categoryContent1;

  @JsonKey(name: 'categoryContent2')
  final String categoryContent2;

  ContentKeyResponse(
      {required this.bannerKey,
      required this.topTenContentKey,
      required this.categoryContent1,
      required this.categoryContent2});

  factory ContentKeyResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentKeyResponseFromJson(json);
}
