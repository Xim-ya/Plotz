// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_tv_images_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbTvImagesResponse _$TmdbTvImagesResponseFromJson(
        Map<String, dynamic> json) =>
    TmdbTvImagesResponse(
      (json['backdrops'] as List<dynamic>)
          .map((e) =>
              TmdbTvImagesItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

TmdbTvImagesItemResponse _$TmdbTvImagesItemResponseFromJson(
        Map<String, dynamic> json) =>
    TmdbTvImagesItemResponse(
      (json['aspect_ratio'] as num).toDouble(),
      json['height'] as int,
      json['file_path'] as String,
      (json['vote_average'] as num).toDouble(),
      json['vote_count'] as int,
      json['width'] as int,
    );
