

import 'package:uppercut_fantube/utilities/index.dart';

part 'tmdb_movie_video_info_item_response.g.dart';

@JsonSerializable(createToJson: false)
class TmdbMovieVideoInfoItemResponse {
  @JsonKey(name: 'iso_639_1')
  String iso_639_1;

  @JsonKey(name: 'iso_3166_1')
  String iso_3166_1;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'key')
  String key;

  @JsonKey(name: 'site')
  String site;

  @JsonKey(name: 'size')
  int size;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'official')
  bool official;

  @JsonKey(name: 'published_at')
  String published_at;

  @JsonKey(name: 'id')
  String id;

  TmdbMovieVideoInfoItemResponse(
      this.iso_639_1,
      this.iso_3166_1,
      this.name,
      this.key,
      this.site,
      this.size,
      this.type,
      this.official,
      this.published_at,
      this.id);

  factory TmdbMovieVideoInfoItemResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbMovieVideoInfoItemResponseFromJson(json);
}
