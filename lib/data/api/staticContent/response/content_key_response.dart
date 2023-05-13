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

  @JsonKey(name: 'topPositionedCollectionKey')
  final String topPositionedCollectionKey;

  ContentKeyResponse({
    required this.bannerKey,
    required this.topTenContentKey,
    required this.categoryContent1,
    required this.categoryContent2,
    required this.topPositionedCollectionKey,
  });

  factory ContentKeyResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentKeyResponseFromJson(json);
}
