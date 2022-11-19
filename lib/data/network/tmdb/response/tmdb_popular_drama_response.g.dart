// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_popular_drama_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbPopularDramaResponse _$TmdbPopularDramaResponseFromJson(
        Map<String, dynamic> json) =>
    TmdbPopularDramaResponse(
      json['page'] as int,
      (json['results'] as List<dynamic>)
          .map((e) => TmdbDramaItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
