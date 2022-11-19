// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movie_video_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbMovieVideoInfoResponse _$TmdbMovieVideoInfoResponseFromJson(
        Map<String, dynamic> json) =>
    TmdbMovieVideoInfoResponse(
      json['id'] as int,
      (json['results'] as List<dynamic>)
          .map((e) => TmdbMovieVideoInfoItemResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );
