import 'package:json_annotation/json_annotation.dart';

part 'content_key_response.g.dart';

@JsonSerializable(createToJson: false)
class ContentKeyResponse {
  @JsonKey(name: 'bannerKey')
  final String bannerKey;

  @JsonKey(name: 'topTenContentKey')
  final String topTenContentKey;

  ContentKeyResponse({required this.bannerKey, required this.topTenContentKey});

  factory ContentKeyResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentKeyResponseFromJson(json);
}
