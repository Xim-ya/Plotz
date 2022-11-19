// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_popular_movie_responsee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbMovieResponse _$TmdbMovieResponseFromJson(Map<String, dynamic> json) =>
    TmdbMovieResponse(
      json['page'] as int,
      (json['results'] as List<dynamic>)
          .map((e) => TmdbMovieItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
