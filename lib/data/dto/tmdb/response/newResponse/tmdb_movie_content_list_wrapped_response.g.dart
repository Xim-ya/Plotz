// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movie_content_list_wrapped_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbMovieContentListWrappedResponse
    _$TmdbMovieContentListWrappedResponseFromJson(Map<String, dynamic> json) =>
        TmdbMovieContentListWrappedResponse(
          json['page'] as int,
          (json['results'] as List<dynamic>)
              .map((e) =>
                  TmdbMovieDetailResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
