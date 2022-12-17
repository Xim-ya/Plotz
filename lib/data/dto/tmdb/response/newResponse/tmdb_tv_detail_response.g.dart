// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_tv_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbTvDetailResponse _$TmdbTvDetailResponseFromJson(
        Map<String, dynamic> json) =>
    TmdbTvDetailResponse(
      json['adult'] as bool,
      json['backdrop_path'] as String?,
      (json['genres'] as List<dynamic>)
          .map((e) => TvGenreResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['first_air_date'] as String,
      json['homepage'] as String,
      json['id'] as int,
      json['in_production'] as bool,
      json['name'] as String,
      json['next_episode_to_air'] as String?,
      json['number_of_seasons'] as int,
      json['original_name'] as String,
      json['overview'] as String,
      json['poster_path'] as String?,
      (json['seasons'] as List<dynamic>)
          .map((e) => SeasonResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] as String,
      (json['vote_average'] as num).toDouble(),
      json['vote_count'] as int,
    );

SeasonResponse _$SeasonResponseFromJson(Map<String, dynamic> json) =>
    SeasonResponse(
      json['air_date'] as String,
      json['episode_count'] as int,
      json['id'] as int,
      json['name'] as String,
      json['overview'] as String,
      json['poster_path'] as String?,
      json['season_number'] as int,
    );

TvGenreResponse _$TvGenreResponseFromJson(Map<String, dynamic> json) =>
    TvGenreResponse(
      json['id'] as int,
      json['name'] as String,
    );
