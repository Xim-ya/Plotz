// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_cast_info_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbCastInfoItemResponse _$TmdbCastInfoItemResponseFromJson(
        Map<String, dynamic> json) =>
    TmdbCastInfoItemResponse(
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
      json['integer'] as int?,
    );
