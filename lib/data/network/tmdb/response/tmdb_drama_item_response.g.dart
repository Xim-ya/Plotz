// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_drama_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbDramaItemResponse _$TmdbDramaItemResponseFromJson(
        Map<String, dynamic> json) =>
    TmdbDramaItemResponse(
      json['backdrop_path'] as String?,
      json['first_air_date'] as String,
      (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
      json['id'] as int,
      json['name'] as String,
      (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['original_language'] as String,
      json['original_name'] as String,
      json['overview'] as String,
      (json['popularity'] as num).toDouble(),
      json['poster_path'] as String?,
      (json['vote_average'] as num).toDouble(),
      json['vote_count'] as int,
    );
