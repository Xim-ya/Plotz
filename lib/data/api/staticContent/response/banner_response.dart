import 'package:soon_sak/utilities/index.dart';

part 'banner_response.g.dart';

@JsonSerializable(createToJson: false)
class BannerResponse {
  @JsonKey(name: 'key')
  String key;

  @JsonKey(name: 'items')
  List<BannerItemResponse> items;

  BannerResponse(this.key, this.items);

  factory BannerResponse.fromJson(Map<String, dynamic> json) {
    return _$BannerResponseFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class BannerItemResponse {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'imgUrl')
  String imgUrl;

  @JsonKey(name: 'genres')
  List<String> genres;

  BannerItemResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.genres,
  });

  factory BannerItemResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerItemResponseFromJson(json);
}
