

import 'package:uppercut_fantube/utilities/index.dart';

part 'tmdb_genre_movie_list_response.g.dart';

@JsonSerializable(createToJson: false)
class TmdbGenreMovieListResponse {
  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'results')
  List<TmdbMovieGenreItemResponse> results;

  TmdbGenreMovieListResponse(this.page, this.results);

  factory TmdbGenreMovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbGenreMovieListResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class TmdbMovieGenreItemResponse {
  @JsonKey(name: 'adult')
  bool adult;

  @JsonKey(name: 'backdrop_path')
  String? backdrop_path;

  @JsonKey(name: 'genre_ids')
  List<int> genre_ids;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'original_language')
  String original_language;

  @JsonKey(name: 'original_title')
  String original_title;

  @JsonKey(name: 'overview')
  String overview;

  @JsonKey(name: 'popularity')
  double popularity;

  @JsonKey(name: 'poster_path')
  String? poster_path;

  @JsonKey(name: 'release_date')
  String release_date;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'video')
  bool video;

  @JsonKey(name: 'vote_average')
  double vote_average;

  @JsonKey(name: 'vote_count')
  int vote_count;

  TmdbMovieGenreItemResponse(
      this.adult,
      this.backdrop_path,
      this.genre_ids,
      this.id,
      this.original_language,
      this.original_title,
      this.overview,
      this.popularity,
      this.poster_path,
      this.release_date,
      this.title,
      this.video,
      this.vote_average,
      this.vote_count);

  factory TmdbMovieGenreItemResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbMovieGenreItemResponseFromJson(json);
}
