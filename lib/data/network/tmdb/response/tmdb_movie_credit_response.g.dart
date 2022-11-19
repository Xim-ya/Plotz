// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movie_credit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbMovieCreditResponse _$TmdbMovieCreditResponseFromJson(
        Map<String, dynamic> json) =>
    TmdbMovieCreditResponse(
      json['id'] as int,
      (json['cast'] as List<dynamic>)
          .map((e) =>
              TmdbCastInfoItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
