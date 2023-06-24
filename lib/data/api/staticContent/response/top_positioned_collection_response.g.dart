// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_positioned_collection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopPositionedCollectionResponse _$TopPositionedCollectionResponseFromJson(
        Map<String, dynamic> json) =>
    TopPositionedCollectionResponse(
      key: json['key'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) =>
              TopPositionedCategoryResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

TopPositionedCategoryResponse _$TopPositionedCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    TopPositionedCategoryResponse(
      title: json['title'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) =>
              CategoryContentItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
