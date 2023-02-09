import 'package:json_annotation/json_annotation.dart';

part 'banner_response.g.dart';

@JsonSerializable(createToJson : false)
class BannerResponse {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'items')
  List<BannerItemResponse> items;

  BannerResponse(this.id, this.items);

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);
}


@JsonSerializable(createToJson: false)
class BannerItemResponse {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'videoId')
  String videoId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'imgUrl')
  String imgUrl;

  @JsonKey(name: 'backdropImgUrl')
  String backdropImgUrl;

  BannerItemResponse(
      {required this.id,
        required this.videoId,
        required this.title,
        required this.description,
        required this.imgUrl,
        required this.backdropImgUrl});

  factory BannerItemResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerItemResponseFromJson(json);


}