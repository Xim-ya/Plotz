import 'package:uppercut_fantube/utilities/index.dart';

part 'tmdb_tv_detail_response.g.dart';

@JsonSerializable(createToJson: false)
class TmdbTvDetailResponse {
  @JsonKey(name:'adult')
  bool adult;

  @JsonKey(name:'backdrop_path')
  String? backdrop_path;

  @JsonKey(name:'genres')
  List<TvGenreResponse> genres;

  @JsonKey(name : 'first_air_date')
  String first_air_date;

  @JsonKey(name: 'homepage')
  String homepage;

  @JsonKey(name :'id')
  int id;

  @JsonKey(name : 'in_production')
  bool in_production;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'next_episode_to_air')
  String? next_episode_to_air;

  @JsonKey(name: 'number_of_seasons')
  int number_of_seasons;

  @JsonKey(name: 'original_name')
  String original_name;

  @JsonKey(name: 'overview')
  String overview;

  @JsonKey(name: 'poster_path')
  String poster_path;

  @JsonKey(name: 'seasons')
  List<SeasonResponse> seasons;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name : 'vote_average')
  double vote_average;

  @JsonKey(name: 'vote_count')
  int vote_count;

  TmdbTvDetailResponse(
      this.adult,
      this.backdrop_path,
      this.genres,
      this.first_air_date,
      this.homepage,
      this.id,
      this.in_production,
      this.name,
      this.next_episode_to_air,
      this.number_of_seasons,
      this.original_name,
      this.overview,
      this.poster_path,
      this.seasons,
      this.status,
      this.vote_average,
      this.vote_count);

  factory TmdbTvDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbTvDetailResponseFromJson(json);
}
// 시즌 - 에피소드
@JsonSerializable(createToJson: false)
class SeasonResponse {
  @JsonKey(name: 'air_date')
  String air_date;

  @JsonKey(name: 'episode_count')
  int episode_count;

  @JsonKey(name : 'id')
  int id;

  @JsonKey(name : 'name')
  String name;

  @JsonKey(name: 'overview')
  String overview;

  @JsonKey(name: 'poster_path')
  String poster_path;

  @JsonKey(name: 'season_number')
  int season_number;

  SeasonResponse(this.air_date, this.episode_count, this.id, this.name, this.overview,
      this.poster_path, this.season_number);

  factory SeasonResponse.fromJson(Map<String, dynamic> json) =>
      _$SeasonResponseFromJson(json);
}


// TV 장르
@JsonSerializable(createToJson: false)
class TvGenreResponse {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;


  TvGenreResponse(this.id, this.name);

  factory TvGenreResponse.fromJson(Map<String, dynamic> json) =>
      _$TvGenreResponseFromJson(json);
}