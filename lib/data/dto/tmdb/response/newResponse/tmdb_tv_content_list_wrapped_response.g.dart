// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_tv_content_list_wrapped_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbTvContentListWrappedResponse _$TmdbTvContentListWrappedResponseFromJson(
        Map<String, dynamic> json) =>
    TmdbTvContentListWrappedResponse(
      json['page'] as int,
      (json['results'] as List<dynamic>)
          .map((e) => TmdbTvDetailResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
