// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_content_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchedContentResponse _$SearchedContentResponseFromJson(
        Map<String, dynamic> json) =>
    SearchedContentResponse(
      json['page'] as int,
      (json['results'] as List<dynamic>)
          .map((e) =>
              SearchedContentItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

SearchedContentItemResponse _$SearchedContentItemResponseFromJson(
        Map<String, dynamic> json) =>
    SearchedContentItemResponse(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String,
      id: json['id'] as int,
      name: json['name'] as String?,
      title: json['title'] as String?,
      originalLanguage: json['original_language'] as String,
      originalName: json['original_name'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String,
      mediaType: json['media_type'] as String,
      genreIds:
          (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
      popularity: (json['popularity'] as num).toDouble(),
      firstAirDate: json['first_air_date'] as String?,
      releaseDate: json['release_date'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
