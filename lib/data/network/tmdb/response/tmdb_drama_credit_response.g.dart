// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_drama_credit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbDramaCreditResponse _$TmdbDramaCreditResponseFromJson(
        Map<String, dynamic> json) =>
    TmdbDramaCreditResponse(
      json['id'] as int,
      (json['cast'] as List<dynamic>)
          .map((e) =>
              TmdbCastInfoItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
