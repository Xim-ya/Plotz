// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_content_collection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryContentCollectionResponse _$CategoryContentCollectionResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryContentCollectionResponse(
      key: json['key'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) =>
              CategoryContentsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

CategoryContentsResponse _$CategoryContentsResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryContentsResponse(
      title: json['title'] as String,
      contents: (json['contents'] as List<dynamic>)
          .map((e) =>
              CategoryContentItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
