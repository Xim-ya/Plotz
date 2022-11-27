// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_tv_credit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbTveCreditResponse _$TmdbTveCreditResponseFromJson(
        Map<String, dynamic> json) =>
    TmdbTveCreditResponse(
      json['id'] as int,
      (json['cast'] as List<dynamic>)
          .map(
              (e) => TmdbTvCastInfoResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

TmdbTvCastInfoResponse _$TmdbTvCastInfoResponseFromJson(
        Map<String, dynamic> json) =>
    TmdbTvCastInfoResponse(
      json['adult'] as bool,
      json['gender'] as int?,
      json['id'] as int,
      json['known_for_department'] as String,
      json['name'] as String,
      json['original_name'] as String,
      (json['popularity'] as num).toDouble(),
      json['profile_path'] as String?,
      json['cast_id'] as int,
      json['character'] as String,
      json['credit_id'] as String,
    );
