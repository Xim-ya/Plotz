
import 'package:uppercut_fantube/utilities/index.dart';

part 'tmdb_drama_item_response.g.dart';

@JsonSerializable(createToJson: false)
class TmdbDramaItemResponse {
  @JsonKey(name: 'backdrop_path')
  String? backdrop_path;

  @JsonKey(name: 'first_air_date')
  String first_air_date;

  @JsonKey(name: 'genre_ids')
  List<int> genre_ids;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'origin_country')
  List<String> origin_country;

  @JsonKey(name: 'original_language')
  String original_language;

  @JsonKey(name: 'original_name')
  String original_name;

  @JsonKey(name: 'overview')
  String overview;

  @JsonKey(name: 'popularity')
  double popularity;

  @JsonKey(name: 'poster_path')
  String? poster_path;

  @JsonKey(name: 'vote_average')
  double vote_average;

  @JsonKey(name: 'vote_count')
  int vote_count;

  TmdbDramaItemResponse(
      this.backdrop_path,
      this.first_air_date,
      this.genre_ids,
      this.id,
      this.name,
      this.origin_country,
      this.original_language,
      this.original_name,
      this.overview,
      this.popularity,
      this.poster_path,
      this.vote_average,
      this.vote_count);

  factory TmdbDramaItemResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbDramaItemResponseFromJson(json);
}
