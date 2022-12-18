import 'package:uppercut_fantube/utilities/index.dart';

part 'tmdb_content_image_response.g.dart';

@JsonSerializable(createToJson: false)
class TmdbImagesResponse {
  @JsonKey(name: 'backdrops')
  List<TmdbImageItemResponse> backdrops;

  TmdbImagesResponse(this.backdrops);

  factory TmdbImagesResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbImagesResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class TmdbImageItemResponse {
  @JsonKey(name: 'aspect_ratio')
  double aspect_ratio;

  @JsonKey(name: 'height')
  int height;

  @JsonKey(name: 'file_path')
  String file_path;

  @JsonKey(name: 'vote_average')
  double vote_average;

  @JsonKey(name: 'vote_count')
  int vote_count;

  @JsonKey(name: 'width')
  int width;

  TmdbImageItemResponse(this.aspect_ratio, this.height, this.file_path,
      this.vote_average, this.vote_count, this.width);

  factory TmdbImageItemResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbImageItemResponseFromJson(json);
}
