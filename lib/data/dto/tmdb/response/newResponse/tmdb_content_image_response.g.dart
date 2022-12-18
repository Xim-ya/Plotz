// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_content_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbImagesResponse _$TmdbImagesResponseFromJson(Map<String, dynamic> json) =>
    TmdbImagesResponse(
      (json['backdrops'] as List<dynamic>)
          .map((e) => TmdbImageItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

TmdbImageItemResponse _$TmdbImageItemResponseFromJson(
        Map<String, dynamic> json) =>
    TmdbImageItemResponse(
      (json['aspect_ratio'] as num).toDouble(),
      json['height'] as int,
      json['file_path'] as String,
      (json['vote_average'] as num).toDouble(),
      json['vote_count'] as int,
      json['width'] as int,
    );
