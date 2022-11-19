

import 'package:uppercut_fantube/utilities/index.dart';

part 'tmdb_movie_detail_info_response.g.dart';

@JsonSerializable(createToJson: false)
class TmdbMovieDetailInfoResponse {
  @JsonKey(name: 'adult')
  bool adult;

  @JsonKey(name: 'backdrop_path')
  String? backdrop_path;

  @JsonKey(name: 'belongs_to_collection')
  MovieCollectionResponse? belongs_to_collection;

  @JsonKey(name: 'budget')
  int budget;

  @JsonKey(name: 'genres')
  List<MovieGenreResponse>? genres;

  @JsonKey(name: 'homepage')
  String? homepage;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'imdb_id')
  String imdb_id;

  @JsonKey(name: 'original_language')
  String original_language;

  @JsonKey(name: 'original_title')
  String original_title;

  @JsonKey(name: 'overview')
  String? overview;

  @JsonKey(name: 'popularity')
  double popularity;

  @JsonKey(name: 'poster_path')
  String? poster_path;

  @JsonKey(name: 'production_companies')
  List<Map<String, dynamic>> production_companies;

  @JsonKey(name: 'production_countries')
  List<Map<String, dynamic>> production_countries;

  @JsonKey(name: 'release_date')
  String release_date;

  @JsonKey(name: 'revenue')
  int revenue;

  @JsonKey(name: 'runtime')
  int? runtime;

  @JsonKey(name: 'spoken_languages')
  List<Map<String, dynamic>> spoken_languages;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'tagline')
  String? tagline;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'video')
  bool video;

  @JsonKey(name: 'vote_average')
  double vote_average;

  @JsonKey(name: 'vote_count')
  int vote_count;

  TmdbMovieDetailInfoResponse(
      this.adult,
      this.backdrop_path,
      this.belongs_to_collection,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdb_id,
      this.original_language,
      this.original_title,
      this.overview,
      this.popularity,
      this.poster_path,
      this.production_companies,
      this.production_countries,
      this.release_date,
      this.revenue,
      this.runtime,
      this.spoken_languages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.vote_average,
      this.vote_count);

  factory TmdbMovieDetailInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbMovieDetailInfoResponseFromJson(json);
}

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

@JsonSerializable(createToJson: false)
class MovieCollectionResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'poster_path')
  String? poster_path;

  @JsonKey(name: 'backdrop_path')
  String? backdrop_path;

  MovieCollectionResponse(
      this.id, this.name, this.poster_path, this.backdrop_path);

  factory MovieCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieCollectionResponseFromJson(json);
}
