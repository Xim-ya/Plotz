import 'package:json_annotation/json_annotation.dart';

part 'tmdb_movie_detail_response.g.dart';

@JsonSerializable(createToJson: false)
class TmdbMovieDetailResponse {
  @JsonKey(name: 'adult')
  bool adult;

  @JsonKey(name: 'backdrop_path')
  String? backdrop_path;

  @JsonKey(name: 'genres')
  List<MovieGenreResponse>? genres;

  @JsonKey(name: 'release_date')
  String? release_date;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;


  @JsonKey(name: 'overview')
  String overview;

  @JsonKey(name: 'poster_path')
  String? poster_path;

  @JsonKey(name: 'vote_average')
  double vote_average;

  TmdbMovieDetailResponse(
    this.vote_average,
    this.adult,
    this.backdrop_path,
    this.genres,
    this.release_date,
    this.id,
    this.title,
    this.overview,
    this.poster_path,
  );

  factory TmdbMovieDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbMovieDetailResponseFromJson(json);
}

// TV 장르
@JsonSerializable(createToJson: false)
class MovieGenreResponse {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  MovieGenreResponse(this.id, this.name);

  factory MovieGenreResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieGenreResponseFromJson(json);
}
