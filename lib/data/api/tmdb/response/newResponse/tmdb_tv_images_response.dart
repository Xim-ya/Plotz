import 'package:uppercut_fantube/utilities/index.dart';

part 'tmdb_tv_images_response.g.dart';

@JsonSerializable(createToJson: false)
class TmdbTvImagesResponse {
  @JsonKey(name: 'backdrops')
  List<TmdbTvImagesItemResponse> backdrops;

  TmdbTvImagesResponse(this.backdrops);

  factory TmdbTvImagesResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbTvImagesResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class TmdbTvImagesItemResponse {
  @JsonKey(name: 'aspect_ratio')
  double aspect_ratio;

  @JsonKey(name: 'height')
  int height;

  @JsonKey(name: 'iso_639_1')
  String iso_639_1;

  @JsonKey(name: 'file_path')
  String file_path;

  @JsonKey(name: 'vote_average')
  double vote_average;

  @JsonKey(name: 'vote_count')
  int vote_count;

  @JsonKey(name: 'width')
  int width;

  TmdbTvImagesItemResponse(this.aspect_ratio, this.height, this.iso_639_1,
      this.file_path, this.vote_average, this.vote_count, this.width);

  factory TmdbTvImagesItemResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbTvImagesItemResponseFromJson(json);
}
