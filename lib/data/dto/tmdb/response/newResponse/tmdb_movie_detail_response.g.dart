// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movie_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbMovieDetailResponse _$TmdbMovieDetailResponseFromJson(
        Map<String, dynamic> json) =>
    TmdbMovieDetailResponse(
      (json['vote_average'] as num).toDouble(),
      json['adult'] as bool,
      json['backdrop_path'] as String?,
      (json['genres'] as List<dynamic>)
          .map((e) => MovieGenreResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['release_date'] as String,
      json['id'] as int,
      json['title'] as String,
      json['overview'] as String,
      json['poster_path'] as String?,
    );

MovieGenreResponse _$MovieGenreResponseFromJson(Map<String, dynamic> json) =>
    MovieGenreResponse(
      json['id'] as int,
      json['name'] as String,
    );
