// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movie_detail_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbMovieDetailInfoResponse _$TmdbMovieDetailInfoResponseFromJson(
        Map<String, dynamic> json) =>
    TmdbMovieDetailInfoResponse(
      json['adult'] as bool,
      json['backdrop_path'] as String?,
      json['belongs_to_collection'] == null
          ? null
          : MovieCollectionResponse.fromJson(
              json['belongs_to_collection'] as Map<String, dynamic>),
      json['budget'] as int,
      (json['genres'] as List<dynamic>?)
          ?.map((e) => MovieGenreResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['homepage'] as String?,
      json['id'] as int,
      json['imdb_id'] as String,
      json['original_language'] as String,
      json['original_title'] as String,
      json['overview'] as String?,
      (json['popularity'] as num).toDouble(),
      json['poster_path'] as String?,
      (json['production_companies'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      (json['production_countries'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      json['release_date'] as String,
      json['revenue'] as int,
      json['runtime'] as int?,
      (json['spoken_languages'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      json['status'] as String,
      json['tagline'] as String?,
      json['title'] as String,
      json['video'] as bool,
      (json['vote_average'] as num).toDouble(),
      json['vote_count'] as int,
    );

MovieGenreResponse _$MovieGenreResponseFromJson(Map<String, dynamic> json) =>
    MovieGenreResponse(
      json['id'] as int,
      json['name'] as String,
    );

MovieCollectionResponse _$MovieCollectionResponseFromJson(
        Map<String, dynamic> json) =>
    MovieCollectionResponse(
      json['id'] as int?,
      json['name'] as String?,
      json['poster_path'] as String?,
      json['backdrop_path'] as String?,
    );
